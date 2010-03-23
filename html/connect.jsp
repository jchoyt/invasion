<%@ page import="java.util.*, invasion.dataobjects.*, invasion.util.*, java.util.logging.*, java.sql.*" %><%!
    public final static String KEY = "connect.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}
%><%
    log.entering("connect.jsp", "body");
    String charId = WebUtils.getRequiredParameter(request, "id");
    Alt alt = null;
    try
    {
        alt = new Alt(request.getRemoteUser(), Integer.parseInt(charId), true);
        Whatzit wazzit = new Whatzit();
        wazzit.setAlt( alt );
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

