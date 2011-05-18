/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import java.beans.*;
import java.io.*;
import java.util.*;
import java.util.logging.*;
import invasion.dataobjects.*;
import invasion.util.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;


@WebServlet(urlPatterns = { "/map/move" })
public class MoveServlet extends HttpServlet
{
    public final static String KEY = "MoveServlet";  //change to MoveServlet eventually
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    public final static PropertyChangeSupport pcs = new PropertyChangeSupport(KEY);

    //movement direction 1 through 9 like a telephone keypad
    public static final int[] xdelta = { -1, 0, 1, -1, 0, 1, -1, 0, 1};
    public static final int[] ydelta = { -1, -1, -1, 0, 0, 0, 1, 1, 1};

    public static final String[] deepSpaceDeaths = {"Your head explodes in a flash decompresssion event. Some of your brains smash against the station...the rest will float forever in the depths of space."};

    /**
     *  Description of the Method
     *
     *@param  req                   Description of the Parameter
     *@param  resp                  Description of the Parameter
     *@exception  ServletException  Description of the Exception
     *@exception  IOException       Description of the Exception
     */
    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws ServletException, IOException
    {
        String direction = WebUtils.getRequiredParameter(request, "dir");
        int dir = Integer.parseInt(direction);
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt a = wazzit.getAlt();
        int oldloc = a.getLocation();

        log.finer("old location: " + oldloc);
        boolean valid = true;

        String query = "select * from location l where (station, level, x, y) in (select station, level, x + " + xdelta[dir] + ", y + " + ydelta[dir] + " from location s where id=?)";
        log.finer( query );

        InvasionConnection conn = null;
        ResultSet rs = null;
        int moveCost = 1;
        try{
            conn = new InvasionConnection();

            //if existing locaiton is bulkhead or window, you can't move - this is here to utilize the database connection
            if( a.getLocationType() == LocationType.BULKHEAD || a.getLocationType() == LocationType.WINDOW )
            {
                new Message( conn, a.getId(), Message.SELF, "You try to move, but find that the phenomenon that let you INTO this location is now working against you.  You could be stuck here until the star you are orbiting expands to engulf the station and claims what rigthfully belongs to it." );
                response.sendRedirect("index.jsp");
                return;
            }

            rs = conn.psExecuteQuery(query, "Error getting new location.", a.getLocation());
            if(rs.next())
            {
                //DO CHECKS FOR VALID destinations here
                //if new location is in deep space, kill character horrifically
                //if new location is bulkhead, give message
                //if new location is water, drown
                a.setLocation(rs.getInt("id"));
                a.setLocationType( rs.getInt("typeid") );
                a.update(conn);

                if( a.getLocationType() == LocationType.CORRIDOR )
                {
                    moveCost = 0;
                }
                // notify the listeners
                pcs.firePropertyChange(KEY, oldloc, a.getLocation());
                if( moveCost > 0 )
                {
                    wazzit.getAlt().decrementAp(conn, moveCost);
                }
            }
            else
            {
                log.severe("Location not found!");
                response.sendRedirect("/naughty.jsp");
                return;
            }
        }
        catch(Exception e)
        {
            log.throwing(KEY, "body", e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            conn.close();
        }
        response.sendRedirect("index.jsp");
    }


    /**
     *  Description of the Method
     *
     *@param  req                   Description of the Parameter
     *@param  resp                  Description of the Parameter
     *@exception  ServletException  Description of the Exception
     *@exception  IOException       Description of the Exception
     */
    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws ServletException, IOException
    {
        response.sendRedirect("/naughty.jsp");
    }
}
