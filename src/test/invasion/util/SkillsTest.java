/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package test.invasion.util;

import java.io.StringWriter;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.*;
import java.util.logging.*;
import org.junit.*;
import invasion.dataobjects.*;

public class SkillsTest
{

    //{{{  tests
    @Test
    public void attackChances()
        throws Exception
    {
        double chance = Skills.calculateAttackChance( 0.25, 0, 0 );
        assertTrue( Math.abs( chance - 0.25 ) < 0.0001 );

        chance = Skills.calculateAttackChance( 0.25, 5, 0 );
        double desired = 0.9350d;
        assertTrue( "Chance was supposed to be " + desired + " but was " + chance, Math.abs( chance - desired ) < 0.0001 );

        chance = Skills.calculateAttackChance( 0.25, 0, 5 );
        desired = 0.03349d;
        assertTrue( "Chance was supposed to be " + desired + " but was " + chance, Math.abs( chance - desired ) < 0.0001 );

        chance = Skills.calculateAttackChance( 0.25, 3, 3 );
        desired = 0.30916d;
        assertTrue( "Chance was supposed to be " + desired + " but was " + chance, Math.abs( chance - desired ) < 0.0001 );

    }
    //}}}
}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

