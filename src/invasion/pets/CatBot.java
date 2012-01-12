/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.pets;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import invasion.dataobjects.*;
import invasion.util.*;

public class CatBot extends Critter
{

    public final static String KEY = CatBot.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}
    //{{{ Constructors

   /**
     * Bare constructor - used by CritterFactory to load from the database
     * @param
     * @return
     *
     */
    public CatBot()
    {
        init();
    }

    /**
     * Constructor to add a new CatBot to an existing Brood
     * @param
     * @return
     *
     */
    public CatBot( Brood brood )
    {
        if( brood == null )
        {
            throw new RuntimeException("Can't create a new CatBot in a non-existant brood");
        }
        setBrood(brood);
        init();
        insert();
    }

    /**
     * Constructor for a Brood-less CatBot - a new Brood will be created with this guy as the sole member
     * @param
     * @return
     *
     */
    public CatBot( int station )
    {
        //no brood yet, so create one
        Brood b = new Brood(-1);
        b.addMember(this);
        b.setLocation( Station.getRandomLocation( station ) );
        setBroodGoals( b );
        b.setType( Brood.INVADING );
        if( !b.insert() )
        {
            log.warning("Brood not inserted.");
        }

        //now create the pet
        setBrood( b );
        init();
        insert();
        log.finer("Finished creating CatBot " + id + " at location " + b.getLocation() );
    }

    public void init()
    {
        ap = 75;
        apmax = 75;
        hp = 20;
        hpmax = 20;
        attackDamage = new DiceRoller("2d5");
        cost = -1;
        armor = 15;
        armorMax = 15;
        shield = 15;
        shieldMax = 15;
        name = "CatBot " + ( (int) ( Math.random() * 2500 ) );
        typeid = 2;
        damageType = 'p';
        if(Math.random() < 0.01) name = "All Hail Mistress Cy!";
        deathKnells = new String[] { "You have landed the killing blow.",
            "Its last, loud screach of pain echo through the area. You feel kinda bad now."
            };
    }
    //}}}

    //{{{ Methods

    /**
     * see @Critter
     */
    public void setBroodGoals( Brood brood )
    {
        brood.setGoal( Brood.GOAL_SURVIVE, 2 );
        brood.setGoal( Brood.GOAL_PROTECT, 1 );
        brood.setGoal( Brood.GOAL_KILL_PSI, 5 );
        brood.setGoal( Brood.GOAL_KILL_HUMAN , 5 );
        brood.setGoal( Brood.GOAL_KILL_MUT , 5 );
    }

    /**
     * when you kill them...just make more!!
     * @param
     * @return
     *
     */
    public void kill(Attacker attacker, InvasionConnection conn, CombatResult result) throws SQLException
    {
        super.kill(attacker, conn, result);
        if( Math.random() < 0.1 )  //TODO - change back to .25
        {
            Message.locationBroadcast(conn, location, Message.EFFECT, "You watch in horror as the larger CatBot bits start to twitch and shuffle towards one another." +
                "They reassemble into smaller versions of the parent bot and stand up to join their bretheren.  MEOW!" );
            //get the station
            // int station = -1;
            // String query = "select station from location where id=?";
            // ResultSet rs = null;
            // try
            // {
            //     log.finer("Adding gremlins to station beloinging to location " + location );
            //     conn = new InvasionConnection();
            //     rs = conn.psExecuteQuery(query, "Error message", location);
            //     while(rs.next())
            //     {
            //         station = rs.getInt("station");
            //     }
            //     log.finer("Station looked up is " + station );
            //     DatabaseUtility.close(rs);
            // }
            // catch(SQLException e)
            // {
            //     log.throwing( KEY, "a useful message", e);
            //     throw new RuntimeException(e);
            // }
            // finally
            // {
            //     DatabaseUtility.close(rs);
            // }

            for(int i = 0; i < 6; i++)
            {
                new CatBot(brood);
            }
        }
    }
    //}}}

    //{{{  Getters and setters
    public int getId() { return -1; }
    //}}}

}
// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:
