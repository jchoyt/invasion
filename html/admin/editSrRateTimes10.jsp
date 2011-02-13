<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
page import="invasion.util.*, java.sql.*,java.util.logging.*" %><%
    String s_locid = WebUtils.getRequiredParameter(request, "locid");

    int locid = Integer.parseInt(s_locid);

    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
        String query = "update searchodds set odds=odds*10 where locationtype=?";
        conn.psExecuteUpdate(query, "drat", locid);
    }
    catch (SQLException e)
    {
        Logger log = Logger.getLogger( "editSrRateTimes10.jsp" );
        log.log(Level.WARNING, "Error editing item.", e);
    }
    finally
    {
        DatabaseUtility.close(conn);
    }
%>
<%-- Note:  It is up to the calling javascript page to do the page reload --%>
