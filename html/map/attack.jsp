<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%!
    public final static String KEY = "/map/attack.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}%><%

    // response.setHeader( "Content-Type", "application/json; charset=\"ISO-8859-1\"" );
    String target = WebUtils.getRequiredParameter(request, "target");
    int targetid = Integer.parseInt(target);
    String targetName = null;
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    int apIncrement = 1;
    wazzit.setLastTarget( targetid );
    JSONArray alerts = null;
    InvasionConnection conn = null;
    try
    {
        conn = new InvasionConnection();
        Defender defender = Alt.load( targetid );
        alerts = wazzit.getAlt().attack( defender, conn );
    }
    catch (Exception e)
    {
        log.throwing(KEY, "body", e);
        alerts = new JSONArray();
        alerts.put( Poll.createErrorAlert(e.getMessage()) );
    }
    finally
    {
        Poll.fullPoll( conn, out, wazzit, alerts );
        conn.close();
    }
%>

