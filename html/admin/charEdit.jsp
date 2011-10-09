<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.*, invasion.dataobjects.*, invasion.util.*, java.sql.*,javax.sql.*" %>

<%
    String charid = WebUtils.getRequiredParameter(request, "id");
    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
        request.setAttribute("conn", conn);
        String query = "select a.name, s.name as sta_name, s.id as sta_id, location from alt a join station s on a.station=s.id where a.id = ?";
        ResultSet rs = conn.psExecuteQuery( query, "", Integer.parseInt(charid) );
        if(rs.next())
        {
%>

<form action="charEditProcess.jsp" method="post">
    <input type="hidden" name="id" value="<%=charid%>" />
    Name: <input name="name" value="<%=rs.getString("name")%>" /><br/>
    Station: <select name="station">
        <option value="<%=rs.getString("sta_id")%>"><%=rs.getString("sta_name")%></option>
        <tags:DropDown table="station" idcol="id" nicecol="name" />
    </select><br/>
    Location: <input type="text" name="location" size="50" value="<%=rs.getString("location")%>"/><br/>
    <input type="Submit" value="Submit Change"/>
</form>
<br clear="all"/><a href="${base}admin">Back</a>


<%
        }
        DatabaseUtility.close(rs);
    }
    catch(Exception e)
    { e.printStackTrace();}
    finally
    { DatabaseUtility.close(conn); }
%>
