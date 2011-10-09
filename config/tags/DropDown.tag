<%@ tag import="java.util.*, invasion.util.*, java.sql.*" %>
<%@ attribute name="table" required="true" %>
<%@ attribute name="idcol" required="true" %>
<%@ attribute name="nicecol" required="true" %>

<%
        String query = "select distinct " + idcol + ", " + nicecol + " from " + table + " order by " + nicecol;
        InvasionConnection conn = (InvasionConnection)request.getAttribute("conn");
        ResultSet rs = conn.executeQuery( query);
        while(rs.next())
        {
            out.write( "<option value=\"" + rs.getInt(1) + "\">" + rs.getString(2) + "</option>\n");
        }
        DatabaseUtility.close(rs);
        conn.close();
%>

