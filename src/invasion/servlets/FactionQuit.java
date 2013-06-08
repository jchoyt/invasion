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
@WebServlet(urlPatterns = { "/map/quitFaction" } )
public class FactionQuit extends HttpServlet
{

    public final static String KEY = FactionQuit.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    public FactionQuit()
    {
        super();
    }

    /**
     *  Standard get method.  doPost redirects here.
     *
     */
    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();
        if( alt.getFaction() == null )
        {
            response.sendRedirect("index.jsp?error=You do not belong to a faction.  Nitwit.  Stop messing with URLs." );
            return;
        }

        String name = alt.getFaction().getName();

        //do the join and provide feedback
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            alt.setFaction( null );
            alt.setFactionrank(-1);
            alt.update( conn );
            new Message( conn, alt.getId(), Message.SELF, "You have left " + name + "." );
        }
        catch(SQLException e)
        {
            response.sendRedirect("index.jsp?error=Error occurred while attempting to remove you from the faction.  Report this on the <a href=\"/issues\" target=\"_blank\">bug tracker</a> if a bug doesn't exist already." );
            return;
        }
        finally
        {
            conn.close();
        }


        // JSONArray alerts = null;

        response.sendRedirect("index.jsp" );
    }


    /**
     *  Redirect to doGet()
     *
     */
    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}


