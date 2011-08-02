/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.bot.VasionBot;
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
 *  Class to do transfers of times from one location to another.  Char <-> char, char <-> safe/locker, and char <-> ground are all supported.  Items can be transferred one at a time, or en masse.
 *
 * @author     jchoyt
 * @created Fri Jul 22 22:25:39 EDT 2011 @142 /Internet Time/
 */
@WebServlet(urlPatterns = { "/map/transferItem" } )
public class TransferItem extends HttpServlet
{

    public final static String KEY = TransferItem.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    public TransferItem()
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
        InvasionConnection conn = null;
        Whatzit wazzit = null;
        JSONArray alerts = new JSONArray();
        PrintWriter out = null;
        int itemid = -1;
        try
        {
            conn = new InvasionConnection();
            out = response.getWriter();
            String[] itemid_strings = null;
            int src = -1;
            int dest = -1;
            try
            {
                itemid_strings = WebUtils.getRequiredParameterValues(request, "itemid");
                // String typeid = WebUtils.getOptionalParameter(request, "typeid", null);
                src = Integer.parseInt( WebUtils.getRequiredParameter(request, "src") );
                dest = Integer.parseInt( WebUtils.getRequiredParameter(request, "dest") );
            }
            catch (NullPointerException e)
            {
                alerts.put( Poll.createErrorAlert("Request error. " + e.getMessage() ) );
                Poll.fullPoll( conn, out, wazzit, alerts );
                return;
            }
            wazzit = (Whatzit) request.getSession().getAttribute(Whatzit.KEY);
            Alt alt = wazzit.getAlt();
            for( String s: itemid_strings )
            {
                try
                {
                    itemid = Integer.parseInt( s );
                }
                catch (NumberFormatException e)
                {
                    alerts.put( Poll.createErrorAlert("You need to make up your mind and choose what to move.") );
                    return;
                }

                alerts = doTransfer( conn, itemid, src, dest, alt );
                if( alerts.length() > 0 ) break;
            }
        }
        catch (Throwable t)
        {
            log.throwing( KEY, "a useful message", t);
            throw new RuntimeException();
        }
        finally
        {
            Poll.fullPoll( conn, out, wazzit, alerts );
            conn.close();
        }

    }


    /**
     * Does the transfer of a single item from source to destination, including all appropriate checks
     * @param
     * @return
     *
     */
    protected JSONArray doTransfer( InvasionConnection conn, int itemid, int src, int dest, Alt alt )
    {
        JSONArray alerts = new JSONArray();
        try
        {
            Item item = Item.load( conn, itemid );

            if( item==null )
            {
                alerts.put( Poll.createErrorAlert("That item doesn't exist.") );
                return alerts;
            }

            // check if you're in the right location
            boolean stillThere = false;
            if( src == alt.getId() )
                stillThere = checkCoincidingLocation( conn, alt.getLocation(), dest );
            else
                stillThere = checkCoincidingLocation( conn, src, alt.getLocation() );

            if( !stillThere )
            {
                alerts.put( Poll.createErrorAlert("You are no longer in the same location as your trading partner!") );
                return alerts;
            }

            // check for hacking  src is where the object is coming from, dest where it's going to (made with http://www.asciiflow.com/)
            //                   +----------+
            //                   |   src?   |
            //                   +-----+----+
            //       +--------+        |      +------------+
            //       |   me   | <------+------|   not me   |
            //       +---+----+               |    dest?   |
            //           |                    +---------+--+
            //           |            +--------+        |
            //           |            + locker |<-------+
            // +---------v---+        |--------+        |
            // |     OK!     | <------+ safe   |<-------+
            // +-------------+        |--------+        |
            //                        + ground |<-------+
            //                        +--------+        |
            //                                          |
            //  +------------+    +------------+        |
            //  |  naughty!  | <--+   other    |<-------+
            //  +------------+    +------------+

            int count=0;
            String query = null;
            //TODO - check AP

            //do transfer of item FROM character
            if( src == alt.getId() )
            {
                if( dest < Constants.MIN_LOCATION_ID ) //transfer to another character
                {
                    //TODO check that you won't over-burden them
                    item.setLocid( dest );
                    if( !item.update( conn ) )
                    {
                        item.setLocid( src );
                        alerts.put( Poll.createErrorAlert( "Item transfer failed." ) );
                        return alerts;
                    }
                    Alt recipient = Alt.load( conn, dest );
                    new Message( conn, alt.getId(), Message.NORMAL, "You give your " + item.getItemtype().getName() + " to " + recipient.getName() +".");
                    alt.decrementAp( conn, 1 );
                }
                else if( dest < Constants.MIN_FACTION_ID ) //transfer to the ground
                {
                    item.setLocid( alt.getLocation() );
                    if( !item.update( conn ) )
                    {
                        item.setLocid( alt.getId() );
                        alerts.put( Poll.createErrorAlert( "Item transfer failed." ) );
                        return alerts;
                    }
                    new Message( conn, alt.getId(), Message.NORMAL, "You set your " + item.getItemtype().getName() + " on the ground.");
                    alt.decrementAp( conn, 1 );
                }
                else if( dest < Constants.MIN_LOCKER_ID ) //transfer to faction save
                {
                    alerts.put( Poll.createErrorAlert("What are you playing at?  Factions aren't even implemented yet. ") );
                }
                else  //transfer to locker
                {
                    //check locker open and do the transfer
                    query = "update item set locid=? where itemid=? and 't'=(select open from locker where id=?);" ;
                    //TODO check that you won't over-burden them
                    count = conn.psExecuteUpdate( query, "Processing transfer of item from character to locker.", dest, itemid, src );
                    if( count != 1 )
                    {
                        alerts.put( Poll.createErrorAlert( "That locker has not been opened." ) );
                        return alerts;
                    }
                    item.setLocid( dest );
                    alt.decrementAp( conn, 1 );
                }
            }
            else //do transfer of item TO characters
            {
                if( src < Constants.MIN_LOCATION_ID ) //transfer from another character?  I don't think so.
                {
                    VasionBot.announce( alt.getUsername() + " is trying to steal an item for " + dest + " from " + src );
                    alerts = new JSONArray();
                    alerts.put( Poll.createErrorAlert("You seem to be trying to steal something.  I've taken notice.") );
                    return alerts;
                }
                else if( src < Constants.MIN_FACTION_ID ) //transfer from the ground to the character
                {
                    item.setLocid( alt.getId() );
                    if( !item.update( conn ) )
                    {
                        item.setLocid( alt.getLocation() );
                        alerts.put( Poll.createErrorAlert( "Item transfer failed." ) );
                        return alerts;
                    }
                    new Message( conn, alt.getId(), Message.NORMAL, "You pick up a " + item.getItemtype().getName() + " from the ground.");
                    alt.decrementAp( conn, 1 );
                }
                else if( src < Constants.MIN_LOCKER_ID ) //transfer from faction safe to the character
                {
                    alerts.put( Poll.createErrorAlert("What are you playing at?  Factions aren't even implemented yet. ") );
                    return alerts;
                }
                else  //transfer to locker
                {
                    //check locker open and do the transfer
                    query = "update item set locid=? where itemid=? and 't'=(select open from locker where id=?);" ;
                    //TODO check that you won't over-burden them
                    count = conn.psExecuteUpdate( query, "Processing transfer of item from locker to character.", dest, itemid, src );
                    if( count != 1 )
                    {
                        alerts.put( Poll.createErrorAlert( "That locker has not been opened." ) );
                        return alerts;
                    }
                    item.setLocid( dest );
                    alt.decrementAp( conn, 1 );
                }
            }
            //alt.decrementAp(conn, 1);
        }
        catch(Exception e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            return alerts;
        }
    }

    /**
     * Checks to see if the "other" location (that is the one that's not the character initiating the transfer), is in the same place.
     * @param   altLoc - location id of the tile the character is sitting in
     * @param   otherLoc - ID of one of: Character, tile, faction (for safes), locker.   For all but
     * @return
     *
     */
    protected boolean checkCoincidingLocation( InvasionConnection conn, int altLoc, int otherLoc )
    {
        if( otherLoc < Constants.MIN_LOCATION_ID ) //dest is a character
        {
            Alt giftee = Alt.load( conn, otherLoc );
            return giftee.getId() == altLoc;
        }
        else if( otherLoc < Constants.MIN_FACTION_ID ) //dest is tile
        {
            return otherLoc == altLoc;
        }
        else if( otherLoc < Constants.MIN_LOCKER_ID )  //dest is faction safe
        {
            //TODO check faction SH up and whereaw.
            return false;
        }
        else  //dest is a locker
        {
            String query = "select id from locker where id=? and location=?";
            //TODO pass in alerts so we can add them :)
            ResultSet rs = null;
            boolean found = false;
            try
            {
                rs = conn.psExecuteQuery(query, "Validating that the locker in question is, in fact, in the same location as the character accessing it.", otherLoc, altLoc);
                if(rs.next())
                {
                    found = true;
                }
                DatabaseUtility.close(rs);
            }
            catch(SQLException e)
            {
                log.throwing( KEY, "a useful message", e);
                throw new RuntimeException(e);
            }
            finally
            {
                DatabaseUtility.close(rs);
            }
            return found;
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


