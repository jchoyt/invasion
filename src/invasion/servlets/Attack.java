/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.pets.*;
import invasion.util.*;
import java.io.*;
import java.util.*;
import java.util.logging.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import org.json.*;
import invasion.dataobjects.*;

/**
 *
 *
 * @author     jchoyt
 */
@WebServlet(urlPatterns = { "/map/attack" } )
public class Attack extends HttpServlet
{

    public final static String KEY = Attack.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public Attack()
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
        PrintWriter out = response.getWriter();
        String target = WebUtils.getRequiredParameter(request, "target");
        int targetid = Integer.parseInt(target.substring(3));
        String targetType = target.substring(0,3);
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        JSONArray alerts = null;
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            Defender defender = null;
            if( targetType.equals("alt" ) )
            {
                log.finer("Attempting to load character " + targetid );
                defender = AltFactory.load( targetid );
            }
            else if( targetType.equals("pet" ) )
            {
                defender = CritterFactory.loadCritter( conn, targetid );
            }
            if( defender == null )
            {
                log.finer("No defender found");
                alerts = new JSONArray();
                alerts.put( Poll.createErrorAlert("Your target no longer exists.") );
                Poll.fullPoll( conn, out, wazzit, alerts );
                return;
            }
            alerts = wazzit.getAlt().attack( defender, conn );
            if( wazzit.getAlt().getReload() )
            {
                Poll.sendReloadCommand(out);
                wazzit.getAlt().setReload(false);
                return;
            }
            Poll.fullPoll( conn, out, wazzit, alerts );
        }
        catch (Exception e)
        {
            log.throwing(KEY, "body", e);
            alerts = new JSONArray();
            alerts.put( Poll.createErrorAlert(e.getMessage()) );
        }
        finally
        {
            DatabaseUtility.close(conn);
        }

    }


    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}


