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
@WebServlet(urlPatterns = { "/factionMessage" } )
public class FactionMessage extends HttpServlet
{

    public final static String KEY = FactionMessage.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    public FactionMessage()
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
        String message = WebUtils.getRequiredParameter(request, "words");
        PrintWriter out = response.getWriter();
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();
        if( alt == null )
        {
            response.sendRedirect("index.jsp?error=You need to be logged in to a character to send a faction message...else I have no idea who to send it to.");
            return;
        }
        else if( alt.getFactionrank() < Constants.FACTION_LT )
        {
            response.sendRedirect("index.jsp?error=You have been weighed and measured and found wanting.  Stop futzing with the urls..I'm watching you.");
            return;
        }
        else if( message.length() == 0 )
            message = alt.getName() + " sent " + Constants.getHisHer( alt.getGender(), false ) + " deepest thought. " + Constants.getHeShe( alt.getGender(), true ) + " says: ";
        else
            message = alt.getName() + " sent the faction the following message: " + message;

        // Check for permission
        InvasionConnection conn = null;
        JSONArray alerts = null;
        try
        {
            conn = new InvasionConnection();
            Message.stationBroadcast( conn, alt.getFactionId(), message );
            response.sendRedirect( WebUtils.BASE + "map/index.jsp" );
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            conn.close();
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


