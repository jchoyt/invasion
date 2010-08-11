<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*" %><%

    String ME = "/me ";
    String message = WebUtils.getRequiredParameter(request, "words");
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    boolean emote = message.length() > 4 && message.substring(0,4).equals( ME );

    //clean up message (prevent bad things)
    message = EscapeChars.forHTML(message);
    //prepare message
    /*  emotes
    - EugeneKay farts loudly (2010-01-21 21:02:30).
    - You emote, " passes out" (2010-01-21 21:03:49).
    */

    /* other
    #  Congo Jack said, "Sweet Marquai that's a lotta people! Oh an.... "  (House (11,40) (Marshall) (Valhalla) : Tue, 26 Aug 2008 22:45:23 -0400)
    #  You say, "WHY WON'T YOU TURN OUT THE LIGHTS WHEN YOU ARE DONE!! I CAN'T TAKE IT ANYMORE!!!"  (House (4,13) (Iverson) (Valhalla) : Thu, 28 Aug 2008 09:45:57 -0400)
    */

    if( emote )
    {
        message = "<a href=\"/viewCharacter.jsp?id=" + wazzit.getAlt().getId() + "\">" + wazzit.getAlt().getName() + "</a> " + message.substring(8);
    }
    else
        message = "<a href=\"/viewCharacter.jsp?id=" + wazzit.getAlt().getId() + "\">" + wazzit.getAlt().getName() + "</a> said, \"" + message + "\"";

    //do DB inserts
    String query = "insert into messages (message, altid) select ?, id from alt where location = ?";
    InvasionConnection conn = new InvasionConnection();
    PreparedStatement ps = conn.prepareStatement(query);
    try{
        ps.setString(1, message);
        ps.setInt(2, wazzit.getLocid());
        ps.executeUpdate();
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    finally
    {
        DatabaseUtility.close(ps);
        conn.close();
        response.sendRedirect("index.jsp");
    }

%>

