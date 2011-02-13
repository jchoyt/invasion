<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
page import="invasion.util.*, java.sql.*,java.util.logging.*" %><%
    String s_locid = WebUtils.getRequiredParameter(request, "locid");
    String s_newval = WebUtils.getRequiredParameter(request, "newrate");
    String s_itemid = WebUtils.getRequiredParameter(request, "itemid");  //search rate id

    int newval = Integer.parseInt(s_newval);
    int itemid = Integer.parseInt(s_itemid);
    int locid = Integer.parseInt(s_locid);

    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
        String query = "insert into searchodds (locationtype, odds, return) values (?, ?, ?);";
        conn.psExecuteUpdate(query, "drat", locid, newval, itemid);
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
    response.sendRedirect( "locationTypeEdit.jsp?id=" + s_locid );
%>
