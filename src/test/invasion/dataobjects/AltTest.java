/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package test.invasion.dataobjects;

import java.io.StringWriter;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.*;
import java.util.logging.*;
import org.junit.*;
import invasion.dataobjects.*;

public class AltTest
{

    //{{{
    Alt testee = new Alt();
    //}}}

    //{{{ Setup
    /**
     * Sets up the test fixture.
     * (Called before every test case method.)
     */
    @Before
    public void setUp() throws Exception {

    } //}}}

     //{{{  tests
    @Test
    public void testHealIp()
        throws Exception
    {
        //check regular heal
        testee.setIp( 45 );
        testee.healIp(5);
        assertEquals( 40, testee.getIp() );
        //test heal to zero
        testee.setIp( 5 );
        testee.healIp(5);
        assertEquals( 0, testee.getIp() );
        //test zero lower bound
        testee.setIp( 5 );
        testee.healIp(15);
        assertEquals( 0, testee.getIp() );
        //test starting at zero
        testee.setIp( 0 );
        testee.healIp( 5 );
        testee.healIp( 0 );
        assertEquals( 0, testee.getIp() );
    }
    //}}}

    @Test
    public void testSkillLevelExtract()
        throws Exception
    {
        //test extraction algoritm
        testee.setHumanSkills( 4063232L ); ///set skills to all and only melee levels
        assertEquals( 5.0, Math.log(Long.highestOneBit((testee.getHumanSkills() & 4063232L ) >> 16) ) / Math.log(2.0), 0.0001); //Math.log(x)/Math.log(2) =? log base 2 of the number
        testee.setHumanSkills( 917504L ); ///set skills to all and only melee levels
        assertEquals( 3.0, Math.log(Long.highestOneBit((testee.getHumanSkills() & 4063232L ) >> 16) ) / Math.log(2.0), 0.0001); //Math.log(x)/Math.log(2) =? log base 2 of the number
        testee.setHumanSkills( 131072L ); ///set skills to all and only melee levels
        assertEquals( 1.0, Math.log(Long.highestOneBit((testee.getHumanSkills() & 4063232L ) >> 16) ) / Math.log(2.0), 0.0001); //Math.log(x)/Math.log(2) =? log base 2 of the number

    }
}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

