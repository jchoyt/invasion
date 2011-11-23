<%@ page import="java.sql.*, java.util.*, invasion.dataobjects.*, invasion.util.*" %><%
    String name = WebUtils.getRequiredParameter(request, "name");

    String query = "select * from factions where name=?";
    InvasionConnection conn = null;
    ResultSet rs = null;
    try
    {
        conn = new InvasionConnection();
        rs = conn.psExecuteQuery( query, name );
        if(rs.next())
            out.write("false");
        else
            out.write("true");
    } catch (Exception e) {
        throw new RuntimeException(e);
    }
    finally
    {
        DatabaseUtility.close(rs);
        conn.close();
    }
%>
