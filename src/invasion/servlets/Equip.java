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
@WebServlet(urlPatterns = { "/map/equip" } )
public class Equip extends HttpServlet
{

    public final static String KEY = Equip.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public Equip()
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
        String itemid = WebUtils.getRequiredParameter(request, "weaponid");
        int id = Integer.parseInt(itemid);
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();
        InvasionConnection conn = null;
        try{
            conn = new InvasionConnection();
            Item i = Item.load( conn, id );
            ItemType it =  i.getItemtype();
            if( i.getLocid() != alt.getId() )
            {
                response.sendRedirect( WebUtils.BASE + "map/index.jsp?error=You do not own that.");
                return;
            }

            if( it.getType().equals( "armor" ) )
            {
                eqiupArmor(conn, alt, i);
            }
            else if( it.getType().equals( "wearable" ) )
            {
                eqiupWearable(conn, alt, i);
            }
            else
            {
                //response.sendRedirect( WebUtils.BASE + "map/index.jsp?error=That item cannot be equipped.");
                eqiupWeaon(conn, alt, i);
            }
            alt.update(conn);
            response.sendRedirect( WebUtils.BASE + "map/index.jsp" );
        }
        catch(Exception e)
        {
            log.throwing(KEY, "Error loading item", e);
        }
        finally
        {
            DatabaseUtility.close(conn);
        }
    }

    /**
     * Equips a weapon.  Assumes that the error checking is done already (character owns it, it's a weapon). Calling function must update
     * the alt to save changes made here.
     */
    protected void eqiupWeaon( InvasionConnection conn, Alt alt, Item item )
    {
        //update the item
        String query = "update item set equipped='f' where locid=? and typeid in (select typeid from itemtype where type not in ('armor', 'wearable')); update item set equipped='t' where itemid = ?";
        int count = conn.psExecuteUpdate(query, "Error equipping weapon in database", alt.getId(), item.getItemid());
        alt.setEquippedWeapon( item );
        //now decrement AP
        alt.decrementAp(conn, 1);
        alt.update(conn);
        new Message( conn, alt.getId(), Message.NORMAL, "You switch your equipped weapon. You will now use your " + item.getItemtype().getName() + ".");
    }

    /**
     * Equip armor or shield.  Assumes that the error checking is done already (character owns it, it's aarmor). Calling function must update
     * the alt to save changes made here.
     */
    protected void eqiupArmor( InvasionConnection conn, Alt alt, Item item )
    {
        //update the item
        String query = "update item set equipped='f' where locid=? and typeid in (select typeid from itemtype where type='armor' and damagetype=?); update item set equipped='t' where itemid = ?";
        int count = conn.psExecuteUpdate(query, "Error equipping armor/shield in database", alt.getId(), item.getItemtype().getDamageType(), item.getItemid());
        if( item.getItemtype().getDamageType() == 'p' )
            alt.setEquippedArmor( item );
        else
            alt.setEquippedShield( item );
        //now decrement AP
        alt.decrementAp(conn, 1);
        alt.update(conn);
        new Message( conn, alt.getId(), Message.NORMAL, "You change into your " + item.getItemtype().getName() + ".");
    }

    /**
     * Equip clothing.  Assumes that the error checking is done already (character owns it, it's something wearable). Calling function must update
     * the alt to save changes made here.
     */
    protected void eqiupWearable( InvasionConnection conn, Alt alt, Item item )
        throws SQLException
    {
        ResultSet rs = null;
        //update the item
        String query = "select count(*) from item i join itemtype it on (i.typeid=it.typeid) where type='wearable' and equipped=true and locid=?";
        rs = conn.psExecuteQuery( query, "", alt.getId() );
        int clothingCount = -1;
        if( rs.next() )
        {
            clothingCount = rs.getInt(1);
        }
        DatabaseUtility.close(rs);
        if( clothingCount >= Constants.MAX_WEARABLE )
        {
            new Message( conn, alt.getId(), Message.SELF, "You try to find somewhere to put your  " + item.getItemtype().getName() + " but fail.");
            return;
        }
        query = "update item set equipped='t' where itemid = ?";
        int count = conn.psExecuteUpdate(query, "Error equipping wearable in database", item.getItemid());
        alt.getClothing().add( item.getItemtype().getName() );
        //now decrement AP
        alt.decrementAp(conn, 1);
        alt.update(conn);
        new Message( conn, alt.getId(), Message.NORMAL, "You don your " + item.getItemtype().getName() + ".");
    }

    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        doGet( request, response );
    }

}


