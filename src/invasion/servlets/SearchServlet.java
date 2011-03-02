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
@WebServlet(urlPatterns = { "/map/search" } )
public class SearchServlet extends HttpServlet
{

    public final static String KEY = SearchServlet.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the PqmServlet object
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


    /**
     *  Description of the Method
     *
     */
    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        log.entering(KEY, "doGet");
        PrintWriter out = response.getWriter();
        String count = WebUtils.getRequiredParameter(request, "count");
        int reps = Integer.parseInt(count);
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();
        InvasionConnection conn = null;
        try{
            conn = new InvasionConnection();
            conn.setAutoCommit(false);
            for(int i = 0; i < reps; i++)
            {
                int itemFound = Search.performSearch(alt.getLocation());
                if( itemFound == -1 )
                {
                    new Message( conn, alt.getId(), Message.NORMAL, "You search and find nothing.");
                }
                else
                {
                    new Item(conn, itemFound, alt.getId());
                    new Message( conn, alt.getId(), Message.NORMAL, "You search and find a " + ItemType.getItemType(itemFound).getName() + ".");
                }
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
            DatabaseUtility.close(conn);
            log.exiting(KEY, "doGet");
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


