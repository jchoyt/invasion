/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.pets;

public class Dalek extends Critter
{
    //{{{ Constructor
    public Dalek()
    {
        ap = 75;
        apmax = 75;
        hp = 50;
        hpmax = 50;
        attackDamage = 7;
        cost = -1;
        armor = 40;
        armorMax = 40;
        shield = 40;
        shieldMax = 40;
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

}
// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:
