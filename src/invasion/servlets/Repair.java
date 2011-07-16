/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.bot.*;
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
     * Base XP for repairing from <i>index</i> condition.  Indexes conform to indexes of Item.conditions.
     */
    public final static double[] xp = { 35, 30, 20, 15, 10 };
    /**
     * Base AP for repairing from <i>index</i> condition.  Indexes conform to indexes of Item.conditions.
     */
    public final static double[] ap = { 25, 20, 15, 12, 10 };
    /**
     * Scaling factor for XP - less XP for repairs you really aren't qualified to do and almost none for stuff that's "old hat".  Indexes are the "delta" between
     * the Tinker skill level and the condition of the item calculated as follows:  Tinker Level - (4 - Condition)
     */
    public final static double[] xpFactor = { 0.5, 1.0, .9, .6, .2, 0 };
    /**
     * Scaling factor for AP - it's easier to do repairs that are "old hat" and harder for stuff you probably shouldn't be doing anyway.
     * Indexes are the "delta" between the Tinkerer skill level and the condition of the item calculated as follows:  <br/>
     *  Tinkerer Level - (4 - Condition)
     * <br/>  Example - Tinker level is 3 and item is 3 (Operational):  delta is 4  and the repair would take 30% of the full AP and the character would get 20%
     * of the full amount for the repair.
     */
     public final static double[] apFactor = { 1.25, 1, 0.9, 0.7, 0.3, 0.25 };

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
            log.throwing( KEY, "Error repairing item", e);
            throw new BotReportException(e);
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
        /*
         * delta is used to figure XP and AP scaling as well as what you are able to repair.  It's a measure of the difference between the character's skill
         * and the difficulty of the repair.  A negative delta means it's too hard.  0 is above your pay grade, but you can give it a shot.
         */
        int delta = who.getTinkererLevel() - ( 4 - what.getCondition() );
        try
        {
            ItemType it =  what.getItemtype();
            log.finer( "Trying to repair type " + it.getTypeid() + " which is a " + it.getName() );
            //check that you own it and can repair that here
            if( what.getLocid() != who.getId() )
            {
                return "You do not own that.";
            }
            else if( !what.canRepair() )
            {
                return "You cannot repair that.";
            }
            else if( !Location.canRepair( who, it ) )
            {
                return "You cannnot repair that in this location.";
            }
            else if( what.getCondition() == ( Item.conditions.length - 1 ) )
            {
                return "That item is already in the best condition it's ever been in.  You're a fool if you think you can improve it further.";
            }
            else if( delta < 0 ) //it's too hard to repair
            {
                return "You ponder the job for some time, but decide it's far beyond your skillset.";
            }

            //check for botched repair
            if( delta == 0 && Math.random() < 0.15 )
            {
                what.addDefect( conn );
            }
            else if (Math.random() < 0.02)
            {
                new Message( conn, who.getId(), Message.NORMAL, Item.DEFECT_MESSAGE );
            }

            //update item
            what.setCondition( what.getCondition() + 1 );
            //update XP and AP
            who.setAp( who.getAp() - calculateAp(what.getCondition(), delta) );
            who.setXp( who.getXp() + calculateXp(what.getCondition(), delta) );
            if(who.update(conn) && what.update( conn ))
            {
                new Message( conn, who.getId(), Message.NORMAL, "You repair your " + it.getName() + " using the tools and facilities you find here." );
            }
            else
            {
                new Message( conn, who.getId(), Message.SELF, "Something is amiss.  That didn't seem to work.  But you feel ready to try again." );
            }

        }
        catch (Exception e)
        {
            log.throwing(KEY, "repairItem", e );
            String errFile = WebUtils.dumpError(e);
            VasionBot.announce("Error processing a repair for " + who.getName() + ". Details can be found at " + errFile );
            return "Something went horribly wrong.  Good thing you didn't spend too much time working on that.  Unfortunately the laws of physics seem to be ... off ... at the moment.";
        }
        return null;
    }

    /**
     * Method to calculate the XP gain for a given item condition and delta.  I'd precalculate this, but using it this wasy is easier to understand.
     * @param
     * @return
     *
     */
    public int calculateXp( int itemCondition, int delta )
    {
        return (int)(xp[itemCondition] * xpFactor[delta]);
    }

    /**
     * Method to calculate the AP cost for a given item condition and delta.  I"d precalculate this, but using it this wasy is easeri to understand.
     * @param
     * @return
     *
     */
    public int calculateAp( int itemCondition, int delta )
    {
        return (int)(ap[itemCondition] * apFactor[delta]);
    }


    /**
     *  Redirect to doGet().
     *
     */
    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}


