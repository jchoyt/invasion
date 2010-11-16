<%@ page import="invasion.util.*, invasion.pets.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%!
    public final static String KEY = "/map/attackPet.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}
    %><%

    // response.setHeader( "Content-Type", "application/json; charset=\"ISO-8859-1\"" );
    String target = WebUtils.getRequiredParameter(request, "target");
    int targetid = Integer.parseInt(target);
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    JSONArray alerts = null;
    InvasionConnection conn = null;
    try
    {
        conn = new InvasionConnection();
        Defender defender = CritterFactory.loadCritter( targetid );
        if( defender == null )
        {
            log.finer("No defender found");
            alerts = new JSONArray();
            alerts.put( Poll.createErrorAlert("Your target is no longer in this location.") );
            return;
        }
        log.finer("Character " + wazzit.getAlt().getId() + " about to attack pet " + target );
        alerts = wazzit.getAlt().attack( defender, conn );
        if( wazzit.getAlt().getReload() )
        {
            Poll.sendReloadCommand(out);
            return;
        }
        Poll.fullPoll( conn, out, wazzit, alerts );
    }
    catch (Exception e)
    {
        log.throwing(KEY, "body", e);
        alerts = new JSONArray();
        alerts.put( Poll.createErrorAlert(e.getMessage()) );
    }
    finally
    {
        conn.close();
    }
%>

