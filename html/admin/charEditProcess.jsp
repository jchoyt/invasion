<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
page import="invasion.util.*,invasion.bot.*,invasion.pets.*,invasion.dataobjects.*, java.sql.*,java.util.logging.*,java.util.*" %><%
    String locid_string = WebUtils.getRequiredParameter(request, "location");
    String name = WebUtils.getRequiredParameter(request, "name");
    String station_string = WebUtils.getRequiredParameter(request, "station");
    String charid_string = WebUtils.getRequiredParameter(request, "id");

    String dest = "charEdit.jsp?id=" + charid_string;

    int charid = -1;

    Logger log = Logger.getLogger( "charList.jsp" );  //"charEditProcess.jsp" );
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
        List<String> list = LocationCache.verify();
        if( list.size() > 2 )
        {
            VasionBot.announce("Resynced the cache after a teleport and found " + list.size() + " thing(s) wrong.  Two of these were the transport." );
            for( String s : list )
            {
                log.info( s );
            }
        }

    }
    catch (SQLException e)
    {
        log.log(Level.WARNING, "Error editing character " + charid, e);
    }
    finally
    {
        DatabaseUtility.close(conn);
    }

%><jsp:forward page="<%=dest%>" />
