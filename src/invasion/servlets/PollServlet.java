/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.util.*;
import java.util.logging.*;
import invasion.dataobjects.*;
import invasion.util.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;

@WebServlet(urlPatterns = { "/poll" })
public class PollServlet extends HttpServlet
{
    public final static String KEY = "PollServlet";
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Description of the Method
     *
     *@param  config                Description of the Parameter
     *@exception  ServletException  Description of the Exception
     */
    public void init( ServletConfig config )
        throws ServletException
    {
        /*
         *  required for all Servlets
         */
        super.init( config );
    }

    /**
     *  Description of the Method
     *
     *@param  req                   Description of the Parameter
     *@param  resp                  Description of the Parameter
     *@exception  ServletException  Description of the Exception
     *@exception  IOException       Description of the Exception
     */
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
            response.sendRedirect("/index.jsp");
            return;
        }
        Poll.fullPoll( response.getWriter(), wazzit, null );
    }


    /**
     *  Description of the Method
     *
     *@param  req                   Description of the Parameter
     *@param  resp                  Description of the Parameter
     *@exception  ServletException  Description of the Exception
     *@exception  IOException       Description of the Exception
     */
    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws ServletException, IOException
    {
        response.sendRedirect("/naughty.jsp");
    }

}
