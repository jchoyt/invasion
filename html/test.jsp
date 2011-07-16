<%@ page import="invasion.util.*,invasion.ui.*,java.sql.*,invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%

    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    if( wazzit == null )
    {  //nobody is logged in
        response.sendRedirect(WebUtils.BASE + "index.jsp");
        return;
    }

    InvasionConnection conn = new InvasionConnection();
    Poll.fullPoll(conn, out, wazzit, null);
    DatabaseUtility.close(conn);
%>
