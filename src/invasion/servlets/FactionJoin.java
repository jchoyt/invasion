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
@WebServlet(urlPatterns = { "/map/joinFaction" } )
public class FactionJoin extends HttpServlet
{

    public final static String KEY = FactionJoin.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    public FactionJoin()
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
        String factionidstring = WebUtils.getRequiredParameter(request, "factionid");
        int factionid = Integer.parseInt( factionidstring );
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();
        if( alt.getFaction() != null )
        {
            response.sendRedirect("index.jsp?error=You already belong to a faction.  You must quit " +
                alt.getFaction().getName() +
                " before you can join " +
                Faction.getFaction( factionid ).getName() );
            return;
        }
        Faction factionJoined = Faction.getFaction( factionid );
        if( factionJoined == null )
        {
            response.sendRedirect("naughty.jsp");
        }

        //check for proper alignment between race and faction - humans can join all, aliens can join only their own type
        if( ( alt.getRace() != Constants.HUMAN ) && ( factionJoined.getType() != alt.getRace() ) )
        {
            response.sendRedirect("index.jsp?error=Joining that faction would be a bad idea; they'd eat you alive.  Request denied." );
            return;
        }  // else

        //do the join and provide feedback
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            alt.setFaction( factionJoined );
            alt.update( conn );
            new Message( conn, alt.getId(), Message.SELF, "You have successfully joined " + factionJoined.getName() );
        }
        catch(SQLException e)
        {
            response.sendRedirect("index.jsp?error=Error occurred while attempting to add you to the faction.  Report this on the <a href=\"/issues\" target=\"_blank\">bug tracker</a> if a bug doesn't exist already." );
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


