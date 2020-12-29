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
@WebServlet(urlPatterns = { "/map/search" } )
public class SearchServlet extends HttpServlet
{

    public final static String KEY = SearchServlet.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    public final static String[] nothing = { "You search and find nothing.",
        "You search and find a small hole in the wall. It's empty.",
        "You search and find a handful of wet fish scales. You shake them off your hand in disgust.",
        "As you search in a dark recess, you think you feel a breath on your hand.",
        "You search and find not a damn thing.",
        "You search and find yourself and nothing else.",
        "You have a look and come up empty-handed.",
        "You look around and find nothing useful.",
        "You take a look around and still cant find what you are looking for.",
        "You search and find that someone was already here and found all the good stuff."};

    public final static String[] nothingSpecial = {
        "You search and find the droids you were looking for.",
        "You search and find a fleeting image of hope in a lost and forlorn world, a small ray of light shining in the dark abyss, a feeble bright light announcing it's presence in a world of blackness...",
        "You search and find something so horrific you throw up in your mouth a little."};

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public SearchServlet()
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
        String count = WebUtils.getRequiredParameter(request, "count");
        int reps = Integer.parseInt(count);
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();
        InvasionConnection conn = null;
        try{
            conn = new InvasionConnection();
            conn.setAutoCommit(false);
            String message = null;
            for(int i = 0; i < reps; i++)
            {
                int itemFound = Search.performSearch(alt.getLocationType());
                log.finer("Found " + itemFound );
                if( itemFound == -1 )
                {
                    double rand = Math.random();
                    if( rand < 0.99 )
                    {
                        message = "You search and find nothing.";
                    }
                    else if( rand < 0.9999 )
                    {
                        message = RandomUtilities.pickRandom( nothing );
                    }
                    else
                        message = RandomUtilities.pickRandom( nothingSpecial );
                }
                else
                {
                    new Item(conn, itemFound, alt.getId());
                    message = "You search and find a " + ItemType.getItemType(itemFound).getName() + ".";
                }
                new Message( conn, alt.getId(), Message.NORMAL, message );
            }
            conn.commit();
            conn.setAutoCommit(true);
            alt.decrementAp(conn, reps);
        }
        catch(Exception e)
        {
            try
            {
                conn.rollback();
            }
            catch (SQLException se)
            {
                log.throwing( KEY, "doGet", se );
                log.throwing( KEY, "doGet - rollback failed, original error:", e);
            }
            log.throwing( KEY, "doGet", e);
        }
        finally
        {
            Poll.fullPoll( conn, out, wazzit, null );
            conn.close();
        }
    }


    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}
