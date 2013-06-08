/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.util.*;
import invasion.dataobjects.*;
import java.io.*;
import java.util.*;
import java.util.logging.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import org.json.*;

/**
 *
 *
 * @author     jchoyt
 */
@WebServlet(urlPatterns = { "/logout" } )
public class Logout extends HttpServlet
{

    public final static String KEY = Logout.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public Logout()
    {
        super();
    }



    /**
     *  Description of the Method
     *
     * @param  config                Description of the Parameter
     * @exception  ServletException  Description of the Exception
     */
    public void init( ServletConfig config )
        throws ServletException
    {
        log.entering( KEY, "init" );
        /*
         *  required for all Servlets
         */
        super.init( config );
    }


    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);

        if( wazzit == null ) return;

        int altid = wazzit.getAlt().getId();
        request.getSession().invalidate();
        AltFactory.uncache( altid );
        response.sendRedirect( WebUtils.BASE + "index.jsp" );
    }


    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}


