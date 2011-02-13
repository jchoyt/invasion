/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.pets.*;
import invasion.dataobjects.*;
import invasion.util.*;
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
@WebServlet(urlPatterns = { "/map/attackPet" } )
public class AttackPet extends HttpServlet
{

    public final static String KEY = AttackPet.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the PqmServlet object
     *
     * @since
     */
    public AttackPet()
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
        String target = WebUtils.getRequiredParameter(request, "target");
        int targetid = Integer.parseInt(target);
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        JSONArray alerts = null;
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            Defender defender = CritterFactory.loadCritter( conn, targetid );
            if( defender == null )
            {
                log.finer("No defender found");
                alerts = new JSONArray();
                alerts.put( Poll.createErrorAlert("Your target is no longer in this location.") );
                return;
            }
            log.finer("Character " + wazzit.getAlt().getId() + " about to attack pet " + target );
            alerts = wazzit.getAlt().attack( defender, conn );
            if( wazzit.getAlt().getReload() )
            {
                Poll.sendReloadCommand(out);
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


