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
@WebServlet(urlPatterns = { "/map/recharge" } )
public class Recharge extends HttpServlet
{

    public final static String KEY = Recharge.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the PqmServlet object
     *
     * @since
     */
    public Recharge()
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
            ItemType it =  i.getItemtype();
            log.finer( "Trying to recharge type " + it.getTypeid() + " which is a " + it.getName() );
            if( it.getTypeid() == 49 )
            {
                //recharge empty energy pack
                if( Location.canRecharge( alt ) == 'f' )
                {
                    alerts = new JSONArray();
                    alerts.put( Poll.createErrorAlert("You cannnot recharge an empty energy pack in this location.") );
                    return;
                }
                else if( i.getLocid() != alt.getId() )
                {
                    alerts = new JSONArray();
                    alerts.put( Poll.createErrorAlert("You do not own that.") );
                    return;
                }
                String query = "update item set typeid=? where itemid=?"; //change it to a full energy pack
                int count = conn.psExecuteUpdate( query, "Error changing the empty energy pack in the database", 28, i.getItemid() );
                new Message( conn, alt.getId(), Message.NORMAL, "You recharge your energy pack using one of dedicated the ports here." );
            }
            else
            {
                String error = rechargeItem( conn, alt, i );
                if( error != null )
                {
                    alerts = new JSONArray();
                    alerts.put( Poll.createErrorAlert(error) );
                    return;
                }
                alt.decrementAp(conn, 1);
            }
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            Poll.fullPoll( conn, out, wazzit, alerts );
            conn.close();
        }
    }

    /**
     * Performs the recharge
     * @param
     * @return  null if successful, otherwise return an error message suitable for the user to see
     *
     */
    public synchronized static String rechargeItem( InvasionConnection conn, Alt alt, Item i )
        throws SQLException
    {
        ItemType it = i.getItemtype();
        String query = "select count(*) as count, min(itemid) as useme from item where locid=? and typeid=28";
        ResultSet rs = null;
        try
        {
            rs = conn.psExecuteQuery(query, "How the hell did I screw up getting a simple count?", alt.getId());
            rs.next();
            int count = rs.getInt("count");
            if( count == 0 )
            {
                return "You have no full Energy Packs.  Find some, or recharge some empties and try again.";
            }
            //we're OK to go
            int packToUse = rs.getInt( "useme" );
            DatabaseUtility.close(rs);

            if( it.getType().equals("weapon") )
            {
                int capacity = it.getCapacity();
                if( (alt.getHumanSkills() & Skills.getValue(Skill.FIREARMS3)) > 0  )
                {
                    capacity *= 2;
                }

                //set ammo to capacity
                i.setAmmoleft( capacity );
            }
            else if( it.getType().equals("armor") && it.getDamageType() == 'e' )
            {
                //it's a shield....+10 ammo
                i.setAmmoleft( i.getAmmoleft() + 10 );
                if( i.getAmmoleft() > (it.getCapacity() ) )
                {
                    i.setAmmoleft( it.getCapacity()  );
                }
            }
            else
                return "You can't figure out how to attach the energy pack to that.";
            i.update( conn );
            new Message( conn, alt.getId(), Message.NORMAL, "You recharge your " + i.getItemtype().getName().toLowerCase()  + " using one of your energy packs.  It'll have to be recharged now." );


            //empty the pack
            query = "update item set typeid=? where itemid=?"; //change it to a full energy pack
            count = conn.psExecuteUpdate(query, "Error changing the empty energy pack in the database", 49, packToUse );
        }
        catch(SQLException e)
        {
            throw e;
        }
        finally
        {
            DatabaseUtility.close(rs);
        }
        return null;
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


