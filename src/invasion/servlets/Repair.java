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
@WebServlet(urlPatterns = { "/map/repair" } )
public class Repair extends HttpServlet
{

    public final static String KEY = Repair.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the servlet
     *
     * @since
     */
    public Repair()
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
        String itemid = WebUtils.getRequiredParameter(request, "itemid");
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();
        InvasionConnection conn = null;
        JSONArray alerts = null;
        try
        {
            conn = new InvasionConnection();
            Item i = Item.load( conn, Integer.parseInt(itemid) );
            //do the repair
            String error = repairItem( conn, alt, i );
            if( error != null )
            {
                alerts = new JSONArray();
                alerts.put( Poll.createErrorAlert(error) );
                return;
            }
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Error processing repair", e);
            throw new RuntimeException(e);
        }
        finally
        {
            Poll.fullPoll( conn, out, wazzit, alerts );
            conn.close();
        }
    }

    /**
     * Do the repair, including ensuring preconditions are met, applying XP, and decrementing AP
     * @param conn Established connection to the database
     * @param who who's attempting the repair
     * @param what item to be repaired
     * @return  null if everything goes well, otherwise an error message
     *
     */
    public String repairItem( InvasionConnection conn, Alt who, Item what )
    {
        try
        {
            ItemType it =  what.getItemtype();
            log.finer( "Trying to repair type " + it.getTypeid() + " which is a " + it.getName() );
            //check that you own it and can repair that here
            if( what.getLocid() != who.getId() )
            {
                return "You do not own that.";
            }
            else if( what.canRepair() == 'f' )
            {
                return "You cannot repair that.";
            }
            else if( Location.canRepair( who, it ) == 'f' )
            {
                return "You cannnot repair that in this location.";
            }
            else if( what.getCondition() == ( Item.conditions.length - 1 ) )
            {
                return "That item is already in the best condition it's ever been in.  You're a fool if you think you can improve it further.";
            }

            //check for botched repair


            //update item
            what.setCondition( what.getCondition() + 1 );
            what.update( conn );

            //update XP and AP
            who.setAp( who.getAp() - calculateAp(who, what) );
            who.setXp( who.getXp() + calculateXp(who, what) );
            if(who.update(conn))
            {
                new Message( conn, who.getId(), Message.NORMAL, "You repair your " + it.getName() + " using the tools and facilities you find here." );
            }
            else
            {
                new Message( conn, who.getId(), Message.SELF, "Something is amiss.  But you feel energized and ready to try again." );
            }

        }
        catch (Exception e)
        {
            return "Something went horribly wrong.  Good thing you didn't spend too much time working on that.  Unfortunately the laws of physics seem to be ... off ... at the moment.";d
        }
        return null;
    }

    public int calculateXp( Alt alt, Item i )
    {
        return 10;
    }

    public int calculateAp( Alt alt, Item i )
    {
        return 10;
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


