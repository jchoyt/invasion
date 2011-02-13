<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
page import="invasion.util.*, java.sql.*,java.util.logging.*" %><%
    String s_srid = WebUtils.getRequiredParameter(request, "srid");

    int srid = Integer.parseInt(s_srid);

    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
        String query = "delete from searchodds where id=?";
        conn.psExecuteUpdate(query, "drat", srid);
    }
    catch (SQLException e)
    {
        Logger log = Logger.getLogger( "deleteSrRate.jsp" );
        log.log(Level.WARNING, "Error editing item.", e);
    }
    finally
    {
        DatabaseUtility.close(conn);
    }
%>
<%-- Note:  It is up to the calling javascript page to do the page reload --%>
