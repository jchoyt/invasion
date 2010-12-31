/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.pets;

import java.util.logging.Level;
import java.util.logging.Logger;
import invasion.dataobjects.*;
import invasion.util.*;

public class Dalek extends Critter
{

    public final static String KEY = Dalek.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}
    //{{{ Constructors

   /**
     * Bare constructor - used by CritterFactory to load from the database
     * @param
     * @return
     *
     */
    public Dalek()
    {
        init();
    }

    /**
     * Constructor to add a new Dalek to an existing Brood
     * @param
     * @return
     *
     */
    public Dalek( Brood brood )
    {
        if( brood == null )
        {
            throw new RuntimeException("Can't create a new Dalek in a non-existant brood");
        }
        setBrood(brood);
        init();
        insert();
    }

    /**
     * Constructor for a Brood-less Dalek - a new Brood will be created with this guy as the sole member
     * @param
     * @return
     *
     */
    public Dalek( int station )
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
        log.finer("Finished creating Dalek " + id + " at location " + b.getLocation() );
    }

    public void init()
    {
        ap = 75;
        apmax = 75;
        hp = 50;
        hpmax = 50;
        attackDamage = new DiceRoller("2d7");
        cost = -1;
        armor = 40;
        armorMax = 40;
        shield = 40;
        shieldMax = 40;
        name = "Dalek " + id;
        typeid = 1;
        if(Math.random() < 0.01) name = "I peed on the doctor";
        deathKnells = new String[] { "You have landed the killing blow.",
            "With a final blow, the lights on the Dalek slowly dim.",
            "Sparks fly from your target's caraprice and it finally lies motionless."
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
    //}}}

    //{{{  Getters and setters
    public int getId() { return -1; }
    //}}}

}
// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit: