/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.dataobjects.*;
import org.json.*;
import invasion.util.*;
import java.io.*;
import java.util.*;
import java.util.logging.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

/**
 *
 *
 * @author     jchoyt
 * @created
 */
@WebServlet(urlPatterns = { "/map/unequip" } )
public class Unequip extends HttpServlet
{

    public final static String KEY = Unequip.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public Unequip()
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
        PrintWriter out = response.getWriter();
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
            }

            if( it.getType().equals( "weapon" ) )
            {
                uneqiupWeaon(conn, alt, i);
            }
            else if( it.getType().equals( "armor" ) )
            {
                uneqiupArmor(conn, alt, i);
            }
            else if( it.getType().equals( "wearable" ) )
            {
                uneqiupWearable(conn, alt, i);
            }
            else
                response.sendRedirect( WebUtils.BASE + "map/index.jsp?error=That item cannot be unequipped.");
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
     * Unequips a weapon.  Assumes that the error checking is done already (character owns it, it's a weapon). Calling function must update
     * the alt to save changes made here.
     *   @param
     */
    protected void uneqiupWeaon( InvasionConnection conn, Alt alt, Item item )
    {
        //update the item
        String query = "update item set equipped='f' where itemid = ?";
        int count = conn.psExecuteUpdate(query, "Error unequipping weapon in database", item.getItemid());
        alt.setEquippedWeapon( null );
        //now decrement AP
        alt.decrementAp(conn, 1);
        alt.update(conn);
        new Message( conn, alt.getId(), Message.NORMAL, "You put your " + item.getItemtype().getName() + " away.");
    }

    /**
     * Unequip armor or shield.  Assumes that the error checking is done already (character owns it, it's aarmor). Calling function must update
     * the alt to save changes made here.
     *   @param
     */
    protected void uneqiupArmor( InvasionConnection conn, Alt alt, Item item )
    {
        //update the item
        String query = "update item set equipped='f' where itemid = ?";
        int count = conn.psExecuteUpdate(query, "Error unequipping armor/shield in database", item.getItemid());
        alt.setEquippedArmor( null );
        //now decrement AP
        alt.decrementAp(conn, 1);
        alt.update(conn);
        new Message( conn, alt.getId(), Message.NORMAL, "You remove your " + item.getItemtype().getName() + ".");
    }

    /**
     * Unequip clothing.  Assumes that the error checking is done already (character owns it, it's something wearable). Calling function must update
     * the alt to save changes made here.
     *   @param
     */
    protected void uneqiupWearable( InvasionConnection conn, Alt alt, Item item )
    {

        //update the item
        String query = "update item set equipped='f' where itemid = ?";
        int count = conn.psExecuteUpdate(query, "Error unequipping wearable in database", item.getItemid());
        alt.getClothing().remove( item.getItemtype().getName() );
        //now decrement AP
        alt.decrementAp(conn, 1);
        alt.update(conn);
        new Message( conn, alt.getId(), Message.NORMAL, "You revmoe your " + item.getItemtype().getName() + ".");
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


