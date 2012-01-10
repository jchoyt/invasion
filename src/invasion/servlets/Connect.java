/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.bot.VasionBot;
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
        String charId = WebUtils.getRequiredParameter(request, "id");
        Alt alt = null;
        int altid = Integer.parseInt(charId);
        try
        {
            alt = Alt.load( altid );
            if( !alt.getUsername().equals(request.getRemoteUser()) )
            {
                response.sendRedirect("naughty.jsp");
                VasionBot.announce( request.getRemoteUser() + " attempted to log in as " + alt.getName() + " and that's not his character." );
                return;
            }
            Whatzit wazzit = new Whatzit(altid);
            request.getSession().setAttribute( Whatzit.KEY,  wazzit );
            //check if dead
            if( alt.getLocation() == Constants.DEAD_LOCATION || alt.getHp() < 1 )
            {
                response.sendRedirect( WebUtils.BASE + "map/dead.jsp");
                return;
            }
            response.sendRedirect( WebUtils.BASE + "map/index.jsp" );
        }
        catch(Exception e)
        {
            log.throwing(KEY, "Body", e);
            String errFile = WebUtils.dumpError(e);
            VasionBot.announce("Character connection failed for character " + charId + ". Details can be found at " + errFile );
            response.sendRedirect( WebUtils.BASE + "index.jsp" );
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


