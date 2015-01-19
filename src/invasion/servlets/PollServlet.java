/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.util.*;
import java.util.logging.*;
import invasion.dataobjects.*;
import invasion.ui.Poll;
import invasion.util.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;

@WebServlet(urlPatterns = { "/poll" })
public class PollServlet extends HttpServlet
{
    public final static String KEY = "PollServlet";
    public final static Logger log = Logger.getLogger( KEY );

    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws ServletException, IOException
    {
        response.setHeader( "Content-Type", "application/json; charset=\"ISO-8859-1\"" );
        // String direction = WebUtils.getRequiredParameter(request, "dir");
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        if( wazzit==null)
        {
            //not logged in
            log.warning("User not logged in.");
            response.sendRedirect("index.jsp");
            return;
        }
        Poll.fullPoll( response.getWriter(), wazzit, null );
    }

    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws ServletException, IOException
    {
        response.sendRedirect("naughty.jsp");
    }
}
