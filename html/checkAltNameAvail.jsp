<%@ page import="java.sql.*, java.util.*, invasion.dataobjects.*, invasion.util.*" %><%
    String name = WebUtils.getRequiredParameter(request, "name");
        String query = "select * from alt where name=?";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1,name);
            rs = ps.executeQuery();
            if(rs.next())
                out.write("false");
            else
                out.write("true");
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            conn.close();
        }
%>
