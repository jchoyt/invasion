/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

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
@WebServlet(urlPatterns = { "/respawn" } )
public class Respawn extends HttpServlet
{

    public final static String KEY = Respawn.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public Respawn()
    {
        super();
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
        int altid = Integer.parseInt(charId);
        Alt.uncache( altid );
        Alt alt = null;

        String query = "update alt set hp=hpmax, ip=0, lasthurtby=null, ticksalive=1 where id=? and ticksalive=0;";
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            int count = conn.psExecuteUpdate( query, "Error respawning alt " + altid, altid );
            if( count == 0 )
            {
                //ticksalive is not 0, so someone is trying to cheat and respawn early
                response.sendRedirect("naughty.jsp");
                return;
            }
            alt = Alt.load(altid);
            if( !alt.getUsername().equals(request.getRemoteUser()) )
            {
                response.sendRedirect("naughty.jsp");
                return;
            }
            Whatzit wazzit = new Whatzit( altid );
            request.getSession().setAttribute( Whatzit.KEY,  wazzit );

            new Message( conn, altid, Message.SELF, "You step out of the cloning chamber and look around with your new old eyes.  You see rows of identical chambers around the room.  Moving around experimentally, you determine everything appears to be as it should be.");
            response.sendRedirect( WebUtils.BASE + "map/index.jsp" );
        }
        catch(Exception e)
        {
            log.throwing(KEY, "Body", e);
            response.sendRedirect( WebUtils.BASE + "index.jsp" );
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


