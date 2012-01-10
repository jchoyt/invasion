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

    public static final String[] deepSpaceDeaths = {"The abyssal cold of deep space freezes you instantly and robs you of all sensations but pain and sight. You watch your flesh bloat under negative pressure until your vision blurs and darkens. Asphyxiating, your lungs scream silently for oxygen as you slip into eternal darkness.",
        "You miss your step and find yourself where you don't want to be. You drift away from the space station as you body begins to freeze. As you take a breath, there is none and as a false sense of warmth overtakes you, you die. No one heard your screams, you didn't make a sound.",
        "You made a bad move. You knew it was wrong and you know you will pay for it. You are caught in the stations exhaust system and the toxic gas eats into you. Your screams go unheard as your body slowly melts into pieces. You knew something terrible would happen. And it did.",
        "As you drift away from the station, you are left with a few lingering impressions as you start to suffocate. First, maybe you shouldn't have tried to take that last step where you weren't supposed to be. The air in your lungs starts to rush to your brain. Second, maybe you should have listened to your mother when she said never to go where you don't belong. The leftover saliva on your tongue starts to boil, causing you to cry a stifled scream. Third, maybe you should have listened to the warning of the station head when he said not to do things you aren't supposed to. The unblocked sun rays start to give you a major sun burn, while the unpressurized air in your body starts to seep into your blood, giving you a serious case of the bends. All this happens to you in 15 seconds, giving a very fast but very painful death. Your lifeless husk drifts away from the station, spinning gently into the dark abyss.",
        "A klaxon goes off indicating the hull breach in sector 7 that YOU just created.  Knowing what is coming you take a huge gulp of air, hoping that it will buy you a few extra seconds when you get flushed out into deep space. As you get sucked out of the now gaping hole in the side of the station you feel a burning in your lungs as the air inside suddenly increases in volume and you realise you made a horrible mistake"
    };

    public static final String[] drowningDeaths = {
        "You frantically try to reach the surface, but the weight of all your gear and your clothing pulls you down, and not knowing how to swim doesn't help. As you frantically pull up at the water, trying to break the surface, your lungs start to burn and the sides of your vision starts to blacken. Darkness approaches; you find your desparate movements becoming sluggish, and it's harder than ever to see. With your lungs on fire, you slowly lose your grip on reality, and your eyes slowly, slowly lose their light as you drift into the enveloping darkness."
    };

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
                //TODO if new location is water, drown
                a.setLocation(rs.getInt("id"));
                a.setLocationType( rs.getInt("typeid") );
                a.update(conn);

                ActionLog.addAction( a.getId(), ActionLog.ENTERED, a.getLocation() );

                if( a.getLocationType() == LocationType.CORRIDOR )
                {
                    moveCost = 0;
                }
                else if( a.getLocationType() == LocationType.DEEP_SPACE )
                {
                    new Message( conn, a.getId(), Message.SELF, RandomUtilities.pickRandom( deepSpaceDeaths ) );
                    a.setLastHurtBy( 0 );
                    a.kill( conn, null );
                    a.setLocation( -1337 );
                    a.update( conn );
                }
                else if( a.getLocationType() == LocationType.WATER )
                {
                    new Message( conn, a.getId(), Message.SELF, RandomUtilities.pickRandom( drowningDeaths ) );
                    a.setLastHurtBy( 0 );
                    a.kill( conn, null );
                    a.setLocation( -1337 );
                    a.update( conn );
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
                response.sendRedirect("naughty.jsp");
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
        response.sendRedirect("naughty.jsp");
    }
}
