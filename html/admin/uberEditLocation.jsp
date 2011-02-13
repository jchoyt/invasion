<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.*, invasion.dataobjects.*, invasion.util.*, java.sql.*,javax.sql.*" %>

<%
    String locid = WebUtils.getRequiredParameter(request, "locid");
    InvasionConnection conn = null;
    try
    {
        conn = new InvasionConnection();
        String query = "select name, description, station from Location where id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(locid));
        ResultSet rs = ps.executeQuery();
        String name = "not found";
        String description = "not found";
        int station = 0;
        if(rs.next())
        {
            name = rs.getString(1);
            description = rs.getString(2);
            station = rs.getInt("station");
        }
        DatabaseUtility.close(rs);
        DatabaseUtility.close(ps);
        request.setAttribute("conn", conn);
%>

Edit this tile:
<form action="uberEditLocation" method="post">
    <input type="hidden" name="locid" value="<%=locid%>" />
    <input type="hidden" name="station" value="<%=station%>" />
    Type: <select name="type"><tags:Locationtypes/></select><br/>
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
