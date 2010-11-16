/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.pets;

import java.util.*;


public class OffensiveComparator implements Comparator
{

    //{{{ Members
    //}}}

    //{{{ Constuctors
    //}}}

    //{{{ Methods

    public int compare(Object o1, Object o2)
    {
        Critter c1 = (Critter)o1;
        Critter c2 = (Critter)o2;
        return compare(c1, c2);
    }

    public int compare(Critter o1, Critter o2)
    {
        float o1DamagePerAp = o1.getAttackAccuracy(); //* o1.getAttackDamage();
        float o2DamagePerAp = o2.getAttackAccuracy(); //* o2.getAttackDamage();
        return ( (int)( ( o2DamagePerAp - o1DamagePerAp ) * 10 )  );
    }

    public boolean equals(Object obj)
    {
        if( obj instanceof OffensiveComparator )
        {
            return true;
        }
        return false;
    }

    //}}}

    //{{{ Getters and Setters
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

