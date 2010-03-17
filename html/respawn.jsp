<%@ page import="invasion.util.*,java.sql.*, invasion.dataobjects.*, java.util.logging.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%!
    public final static String KEY = "respawn.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}
%><%
%><%
    String charId = WebUtils.getRequiredParameter(request, "id");
    int altid = Integer.parseInt(charId);
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    Alt alt = null;

    String query = "update alt set hp=hpmax, ip=0, lasthurtby=null, ticksalive=1 where id=? and ticksalive=0;";
    InvasionConnection conn = new InvasionConnection();
    try
    {
        int count = conn.psExecuteUpdate( query, "Error respawning alt " + altid, altid );
        if( count == 0 )
        {
            //ticksalive is not 0, so someone is trying to cheat and respawn early
            response.sendRedirect("/naughty.jsp");
            return;
        }
        alt = new Alt(request.getRemoteUser(), altid);
        wazzit.setAlt( alt );
        wazzit.setLocid( alt.getLocation() );
        wazzit.setLocidtype( alt.getLocationType() );
        //set whether the equipped weapon uses ammunition or not
        query = "select item i join itemtype t on (i.typeid = t.typeid) where i=?";
        ResultSet rs = conn.psExecuteUpdate( query, "Error connecting to " + charId, alt.getEquippedWeapon() );
        rs.next();
        wazzit.setAmmoModNeeded( rs.getBoolean( "usesammo" ) );

        new Message( conn, altid, Message.SELF, "You step out of the cloning chamber and look around with your new old eyes.  You see rows of identical chambers around the room.  Moving around experimentally, you determine everything appears to be as it should be.");
        response.sendRedirect( "/map/index.jsp" );
    }
    catch(Exception e)
    {
        log.throwing(KEY, "Body", e);
        response.sendRedirect( "/index.jsp" );
    }
    finally
    {
        conn.close();
    }

%>
