<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
    page import="invasion.util.*, java.sql.*,java.util.logging.*,invasion.dataobjects.*" %><%

    String message = WebUtils.getRequiredParameter(request, "message");

    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    String type = "chalk";
    String action = "wrote";

    if( message.startsWith("!draw " ) )
    {
        type = "draw";
        message = message.substring("!draw ".length());
        action = "drew";
    }
    else if( message.startsWith("!scrawl " ) )
    {
        type = "scrawl";
        message = message.substring("!scrawl ".length());
        action = "scrawled";
    }

    InvasionConnection conn = null;
    PreparedStatement ps = null;
    try{
        conn = new InvasionConnection();
        String query = "update location set messagetype=?, message=? where id=?";
        ps = conn.prepareStatement(query);
        ps.setString(1, type );
        ps.setString(2, message );
        ps.setInt(3, wazzit.getAlt().getLocation());
        ps.execute();
        DatabaseUtility.close(ps);
        Message.locationBroadcast( conn, wazzit.getAlt().getLocation(), Message.NORMAL, wazzit.getAlt().getName() + " " + action + " something on the wall.", wazzit.getAlt().getId() );
    }
    catch (SQLException e)
    {
        Logger log = Logger.getLogger( "chalkProcess.jsp" );
        log.log(Level.WARNING, "Error adding writintg to the wall", e);
    }
    finally
    {
        DatabaseUtility.close(ps);
        conn.close();
    }
    response.sendRedirect("index.jsp");
%>
