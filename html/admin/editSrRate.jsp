<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
page import="invasion.util.*, java.sql.*,java.util.logging.*" %><%
    String s_newval = WebUtils.getRequiredParameter(request, "newrate");
    String s_srid = WebUtils.getRequiredParameter(request, "srid");  //search rate id
    String locid = WebUtils.getRequiredParameter(request, "locid");

    int newval = Integer.parseInt(s_newval);
    int srid = Integer.parseInt(s_srid);

    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
        String query = "update searchodds set odds=? where id=?";
        conn.psExecuteUpdate(query, "drat", newval, srid);
    }
    catch (SQLException e)
    {
        Logger log = Logger.getLogger( "editSrRate.tag" );
        log.log(Level.WARNING, "Error editing item.", e);
    }
    finally
    {
        DatabaseUtility.close(conn);
    }

    response.sendRedirect("locationTypeEdit.jsp?id=" + locid);
%>
