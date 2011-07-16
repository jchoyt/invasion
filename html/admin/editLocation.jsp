<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.*, invasion.dataobjects.*, invasion.util.*, java.sql.*,javax.sql.*" %>

<%
    String locid = WebUtils.getRequiredParameter(request, "locid");
    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
        String query = "select l.name, description, l.typeid, t.name as tilename from location l join locationtype t on l.typeid=t.typeid where id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(locid));
        ResultSet rs = ps.executeQuery();
        String name = "not found";
        String description = "not found";
        int type = 0;
        String typename = "not found";
        if(rs.next())
        {
            name = rs.getString(1);
            description = rs.getString(2);
            type = rs.getInt("typeid");
            typename = rs.getString("tilename");
        }
        DatabaseUtility.close(rs);
        DatabaseUtility.close(ps);
        request.setAttribute("conn", conn);
%>

<a href="${base}admin/stationEdit.jsp?locid=<%=locid%>">Recenter map here</a><br/>
-OR-<br/>
Edit this tile:
<form action="editLocationProcess.jsp" method="post">
    <input type="hidden" name="locid" value="<%=locid%>" />
    Type: <select name="type">
        <option value="<%=type%>"><%=typename%></option>
        <tags:Locationtypes/>
    </select><br/>
    Name: <input type="text" name="name" size="50" value="<%=name%>"/><br/>
    Description: <input type="text" name="desc" size="50" value="<%=description%>"/><br/>
    <input type="Submit" value="Submit Change"/>
</form>

<%
    }
    catch(Exception e)
    { e.printStackTrace();}
    finally
    { DatabaseUtility.close(conn); }
%>
