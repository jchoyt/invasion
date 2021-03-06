/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.bot.*;
import invasion.pets.*;
import invasion.util.*;
import invasion.ui.Poll;
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
@WebServlet(urlPatterns = { "/map/throw" } )
public class ThrowItem extends HttpServlet
{

    public final static String KEY = ThrowItem.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    public ThrowItem()
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
        PrintWriter out = response.getWriter();
        String target = WebUtils.getRequiredParameter(request, "target");
        int targetid = Integer.parseInt(target.substring(3));
        String targetType = target.substring(0,3);
        String missile = WebUtils.getRequiredParameter(request, "missile");
        int missileid = Integer.parseInt(missile);
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();
        JSONArray alerts = null;
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            Defender defender = null;
            if( targetType.equals("alt" ) )
            {
                log.finer("Attempting to load character " + targetid );
                defender = AltFactory.load( targetid );
            }
            else if( targetType.equals("pet" ) )
            {
                defender = CritterFactory.loadCritter( conn, targetid );
            }

            /* check to see if the target ran off */
            if( alt.getLocation() != defender.getLocation() )
            {
                log.finer("Defender no longer at the attacker's location");
                alerts = new JSONArray();
                alerts.put( Poll.createErrorAlert("Your target is no longer in the area.") );
            }
            else
            {
                //TODO check to see if this is a large item, the player has it, and it's not equipped.
                Item i = Item.load( conn, missileid );
                if( i.getItemtype().getSize().equals("l") )
                {  //someone's messing about
                    response.sendRedirect("naughty.jsp");
                    VasionBot.announce( request.getRemoteUser() + " attempted to throw a large object.  This is not allowed" );
                    return;
                }
                else if( i.isEquipped() )
                {  //someone's messing about
                    response.sendRedirect("naughty.jsp");
                    VasionBot.announce( request.getRemoteUser() + " attempted to throw an item that's currently equipped.  This is not allowed" );
                    return;
                }
                else if( i.getLocation() != alt.getId() )
                {  //someone's messing about
                    response.sendRedirect("naughty.jsp");
                    VasionBot.announce( request.getRemoteUser() + " attempted to throw an item they don't own.  This is not allowed" );
                    return;
                }

                alerts = alt.throwAttack( conn, defender, i );
                //TODO move to ground, destroy, or whatever.
                boolean itemDestroyed = false;
                //on a miss, destroy the itme 95% of the time if it's consumable, 5% of the time if it's not
                if( ( i.getItemtype().isConsumable() && Math.random() < 0.95 ) || Math.random() < 0.05 )
                {
                    Item.delete( conn, missileid );
                }
                else
                {
                    String query = "update item set locid=? where itemid=?";
                    int count = conn.psExecuteUpdate( query, "Error moving item to ground.",  alt.getLocation(), missileid );
                    if( count==0 )
                    {
                         throw new BotReportException( "After " + alt.getName() + " threw a " + i.getItemtype().getName() + " the attempt to put it on the ground failed." );
                    }
                }
            }
            response.sendRedirect("index.jsp");
        }
        catch (Exception e)
        {
            log.throwing(KEY, "body", e);
            alerts = new JSONArray();
            alerts.put( Poll.createErrorAlert(e.getMessage()) );
        }
        finally
        {
            DatabaseUtility.close(conn);
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


