/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.pets;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import invasion.dataobjects.*;
import invasion.util.*;

public class Gremlin extends Critter
{

    public final static String KEY = Gremlin.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}
    //{{{ Constructors

   /**
     * Bare constructor - used by CritterFactory to load from the database
     *
     */
    public Gremlin()
    {
        init();

    }

    /**
     * Constructor to add a new Gremlin to an existing Brood
     *
     */
    public Gremlin( Brood brood )
    {
        if( brood == null )
        {
            throw new RuntimeException("Can't create a new Gremlin in a non-existant brood");
        }
        setBrood(brood);
        init();
        insert();

    }

    /**
     * Constructor for a Brood-less Gremlin - a new Brood will be created with this guy as the sole member
     *
     */
    public Gremlin( int station )
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

        log.finer("Finished creating Gremlin " + id + " at location " + b.getLocation() );
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
        name = "Gremlin " + ( (int) ( Math.random() * 2500 ) );
        typeid = 2;
        damageType = 'p';
        if(Math.random() < 0.01) name = "What's corky doing here, anyway?";
        deathKnells = new String[] { "You have landed the killing blow.",
            "You knocked the little fella's head clean off!  You're mean.",
            "You're aim was good, but cruel.  Knees aren't supposed to bend that way.  As the gremlin careens head-first into the wall, you hear a sickening splat.  Heads should not be at that angle, either.",
            "A clean shot!  Very nice. But you can't help but think that this may be too easy. ",
            "Really?  Arent' these a little easy for you?  Go hunt something more challenging."
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
     *
     */
    public void kill(Attacker attacker, InvasionConnection conn, CombatResult result) throws SQLException
    {
        super.kill(attacker, conn, result);
        if( Math.random() < 0.1 )  //TODO - change back to .25
        {
            Message.locationBroadcast(conn, location, Message.EFFECT, "You watch in horror as the larger gremlin bits start to twitch and pulsate." +
                "They morph into smaller versions of the parent creature and stand up to join their bretheren." );
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
                new Gremlin(brood);
            }
        }
    }
    //}}}

    //{{{  Getters and setters
    public int getId() { return -1; }
    //}}}

}
// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:
