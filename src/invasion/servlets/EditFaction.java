/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.util.*;
import invasion.ui.*;
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
@WebServlet(urlPatterns = { "/editFaction" } )
public class EditFaction extends HttpServlet
{

    public final static String KEY = EditFaction.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    public EditFaction()
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
        String description = WebUtils.getOptionalParameter( request, "description", null);
        String newAmmenity = WebUtils.getOptionalParameter( request, "ammenity", null );
        PrintWriter out = response.getWriter();
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();

        if( alt == null || alt.getFaction() == null )
        {
            throw new NaughtyException(request.getRemoteUser() + " is trying to edit a faction without being logged in to a character or is logged in to a character without a faction.");
        }

        InvasionConnection conn = null;
        try
        {
            int ammenity = Integer.parseInt( newAmmenity );
            if( description != null )
            {
                alt.getFaction().setDescription( description );
            }
            else if( newAmmenity != null )
            {
                //TODO check for prestige to pay for it
                //TODO check to make sure you don't already HAVE it
                //TODO loookup ammenity and fix cost (4) below
                alt.getFaction().setAmmenities( alt.getFaction().getAmmenities() + 4  );
            }
            else
                response.sendRedirect( "editFaction.jsp?error=This action requires that you actually want to change something." );

            conn = new InvasionConnection();
            alt.getFaction().update(conn);
            //  TODO -give appropriate feedback - page reload here, or use Poll.fullPoll in the finally block below - don't use both
            // new Message( conn, id, Message.EFFECT, "As you swing the weapon, something feels terribly wrong and it takes you off-balance; you miss." );
            response.sendRedirect( "editFaction.jsp?info=Faction updated." );

        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(conn);
        }
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


