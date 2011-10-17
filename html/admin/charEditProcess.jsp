<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
page import="invasion.util.*,invasion.dataobjects.*, java.sql.*,java.util.logging.*" %><%
    String locid_string = WebUtils.getRequiredParameter(request, "location");
    String name = WebUtils.getRequiredParameter(request, "name");
    String station_string = WebUtils.getRequiredParameter(request, "station");
    String charid_string = WebUtils.getRequiredParameter(request, "id");

    String dest = "charEdit.jsp?id=" + charid_string;

    int charid = -1;

    InvasionConnection conn = null;
    try{
        charid = Integer.parseInt( charid_string );
        int locid = Integer.parseInt( locid_string );
        int stationid = Integer.parseInt( station_string );
        String clean_name = EscapeChars.forHTML(name);


        conn = new InvasionConnection();
        String query = "update alt set name=?, location=?, station=? where id=?";
        int count = conn.psExecuteUpdate(query, "",  clean_name, locid, stationid, charid);
        if( count == 0 )
        {
            //TODO set error dest
            //dest = "somehwere?error=Error updating character - no changes were made
        }
        Alt alt = Alt.load( conn, charid );
        alt.setName( clean_name );
        alt.setLocation( locid );
        // alt.setStation( stationid );  //not tracked in Alt.java
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
