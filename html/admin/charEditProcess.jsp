<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
page import="invasion.util.*, java.sql.*,java.util.logging.*" %><%
    String locid = WebUtils.getRequiredParameter(request, "location");
    String name = WebUtils.getRequiredParameter(request, "name");
    String station = WebUtils.getRequiredParameter(request, "station");
    String charid = WebUtils.getRequiredParameter(request, "id");

    String dest = "charEdit.jsp?id=" + charid;

    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
        String query = "update alt set name=?, location=?, station=? where id=?";
        int count = conn.psExecuteUpdate(query, "",  EscapeChars.forHTML(name), Integer.parseInt( locid ), Integer.parseInt( station ), Integer.parseInt(charid));
        if( count == 0 )
        {
            //TODO set error dest
            //dest = "somehwere?error=Error updating character - no changes were made
        }
    }
    catch (SQLException e)
    {
        Logger log = Logger.getLogger( "charEditProcess.jsp" );
        log.log(Level.WARNING, "Error editing character " + charid, e);
    }
    finally
    {
        DatabaseUtility.close(conn);
    }

%><jsp:forward page="<%=dest%>" />
