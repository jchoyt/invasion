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
 * @created
 */
@WebServlet(urlPatterns = { "/connect" } )
public class Connect extends HttpServlet
{

    public final static String KEY = Connect.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public Connect()
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


    /**
     *  Description of the Method
     *
     */
    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        PrintWriter out = response.getWriter();
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
            //check if dead
            if( alt.getLocation() == -57005 || alt.getHp() < 1 )
            {
                response.sendRedirect( InitServlet.BASE_URL + "map/dead.jsp");
                return;
            }
            request.getSession().setAttribute( Whatzit.KEY,  wazzit );
            response.sendRedirect( InitServlet.BASE_URL + "map/index.jsp" );
        }
        catch(Exception e)
        {
            log.throwing(KEY, "Body", e);
            response.sendRedirect( InitServlet.BASE_URL + "index.jsp" );
        }
    }


    /**
     *  Description of the Method
     *
     */
    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}


