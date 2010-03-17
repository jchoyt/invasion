<%@ page import="java.util.*, invasion.dataobjects.*, invasion.util.*, java.util.logging.*, java.sql.*" %><%!
    public final static String KEY = "connect.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}
%><%

    String charId = WebUtils.getRequiredParameter(request, "id");
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    Alt alt = null;
    try
    {
        alt = new Alt(request.getRemoteUser(), Integer.parseInt(charId));
        wazzit.setAlt( alt );
        wazzit.setLocid( alt.getLocation() );
        wazzit.setLocidtype( alt.getLocationType() );
        //set whether the equipped weapon uses ammunition or not
        String query = "select item i join itemtype t on (i.typeid = t.typeid) where i=?";
        InvasionConnection conn = new InvasionConnection();
        ResultSet rs = conn.psExecuteUpdate( query, "Error connecting to " + charId, alt.getEquippedWeapon() );
        rs.next();
        wazzit.setAmmoModNeeded( rs.getBoolean( "usesammo" ) );

        response.sendRedirect( "/map/index.jsp" );
    }
    catch(Exception e)
    {
        log.throwing(KEY, "Body", e);
        response.sendRedirect( "/index.jsp" );
    }
%>

