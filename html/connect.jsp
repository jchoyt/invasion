<%@ page import="java.util.*, invasion.dataobjects.*, invasion.util.*, java.util.logging.*, java.sql.*" %><%!
    public final static String KEY = "connect.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}
%><%
    log.entering("connect.jsp", "body");
    String charId = WebUtils.getRequiredParameter(request, "id");
    Alt alt = null;
    int altid = Integer.parseInt(charId);
    try
    {
        alt = Alt.load( altid );
        if( !alt.getUsername().equals(request.getRemoteUser()) )
        {
            response.sendRedirect("/naughty.jsp");
            return;
        }
        Whatzit wazzit = new Whatzit(altid);
        wazzit.reload();
        session.setAttribute( Whatzit.KEY,  wazzit );
        response.sendRedirect( "/map/index.jsp" );
    }
    catch(Exception e)
    {
        log.throwing(KEY, "Body", e);
        response.sendRedirect( "/index.jsp" );
    }
    log.exiting("connect.jsp", "body");
%>

