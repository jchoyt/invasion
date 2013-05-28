/*
 *  Copyright 2013s Jeffrey Hoyt.  All rights reserved.
 */
package invasion.servlets;

import invasion.bot.VasionBot;
import invasion.dataobjects.Alt;
import invasion.dataobjects.Message;
import invasion.pets.Brood;
import invasion.pets.BroodManager;
import invasion.pets.Critter;
import invasion.util.Constants;
import invasion.util.DatabaseUtility;
import invasion.util.InvasionConnection;
import invasion.util.Poll;
import invasion.util.RandomUtilities;
import invasion.util.WebUtils;
import invasion.util.Whatzit;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

@WebServlet( urlPatterns = {"/summon"} )
public class SummonPet extends HttpServlet
{
    public static final String KEY = SummonPet.class.getName();
    public static final Logger log = Logger.getLogger( KEY );

    public void doGet( HttpServletRequest request, HttpServletResponse response ) throws IOException, ServletException
    {
        PrintWriter out = response.getWriter();
        Whatzit wazzit = ( Whatzit ) request.getSession().getAttribute( Whatzit.KEY );
        Alt alt = wazzit.getAlt();
        if ( alt == null )
        {
            response.sendRedirect( "index.jsp?error=You are not currently logged in to a character.  " );
            return;
        }

        String typeid_string = WebUtils.getRequiredParameter( request, "typeid" );
        int typeid = -1;
        try
        {
            typeid = Integer.parseInt( typeid_string );
        }
        catch ( NumberFormatException e )
        {
            response.sendRedirect( "index.jsp?error=A beast by that name does not exist." );
        }

        if ( !alt.isPetmaster() )
        {
            VasionBot.announce( request.getRemoteUser() + " tried to summon a pet with " + alt.getName() + " but that character is not a petmaster." );
            WebUtils.moveToChaos( response, alt.getId() );
            return;
        }

        InvasionConnection conn = null;
        JSONArray alerts = null;
        String type = "unset";
        try
        {
            conn = new InvasionConnection();

            type = Critter.getCritterClass( typeid );

            if ( type == null )
            {
                response.sendRedirect( "index.jsp?error=There are no pangolins in space." );

            }
            else
            {
                Brood b = BroodManager.getPlayerBrood( alt.getId() );
                if ( b == null )
                {

                    b = new Brood( alt.getId() );
                    b.setLocation( alt.getLocation() );
                    b.setType(128 );
                    if ( !b.insert() )
                    {
                        log.warning( "Brood not inserted." );
                    }
                    BroodManager.addBrood( b );
                }

                Class clazz = Class.forName( type );
                Critter newCritter = ( Critter ) clazz.newInstance();

                if ( !newCritter.checkSummoner( alt ) )
                {
                    VasionBot.announce( request.getRemoteUser() + " tried to summon a " + newCritter.getName() + " with " + alt.getName() + " but that character can't do that." );
                    WebUtils.moveToChaos( response, alt.getId() );

                }
                else
                {
                    newCritter.setBrood( b );
                    newCritter.init();
                    newCritter.insert();
                    b.addMember( newCritter );
                    alt.decrementAp( conn, 1 );
                    if ( alt.getHp() <= newCritter.getHpCost() )
                    {
                        Message.locationBroadcast( conn, alt.getLocation(), 0, alt.getName() + " screams as a pet forms on " + Constants.getHisHer( alt.getGender(), false ) + " body and rips free.  It's too much for " + Constants.getHimHer( alt.getGender(), false ) + ".  " + Constants.getHeShe( alt.getGender(), true ) + " collapses to the ground, dead.", alt.getId() );

                        alt.kill( null, conn, null );
                        alt.update( conn );
                        Poll.sendReloadCommand( out );
                    }
                    else
                    {
                        alt.setIp( alt.getIp() + newCritter.getCost() );
                        alt.decrementHp( newCritter.getHpCost(), null, conn, true );
                        new Message( conn, alt.getId(), 4, RandomUtilities.pickRandom( newCritter.getSummonMessages() ) );
                    }
                }
            }
        }
        catch ( SQLException e )
        {
            log.throwing( KEY, "a useful message", e );
            throw new RuntimeException( e );
        }
        catch ( ClassNotFoundException e )
        {
            log.throwing( KEY, "Classloader issues?  Class of type " + type, e );
            throw new RuntimeException( e );
        }
        catch ( InstantiationException e )
        {
            log.throwing( KEY, "Classloader issues?  Couldn't instantiate a " + type, e );
            throw new RuntimeException( e );
        }
        catch ( Exception e )
        {
            throw new RuntimeException( e );
        }
        finally
        {
            Poll.fullPoll( conn, out, wazzit, alerts );
            DatabaseUtility.close( conn );
        }
    }

    public void doPost( HttpServletRequest request, HttpServletResponse response ) throws IOException, ServletException
    {
        // doGet( request, response );
    }
}
