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
import invasion.util.*;

public class DiceRollerTest
{

    //{{{  tests
    @Test
    public void parseTest()
        throws Exception
    {
        DiceRoller roller = new DiceRoller("2d6");
        assertEquals("Number of dice does not match", 2, roller.getDicelist().size());
        assertEquals("Number of modifiers does not match", 0, roller.getModlist().size());

        roller = new DiceRoller("210d6+1000");
        assertEquals("Number of dice does not match", 210, roller.getDicelist().size());
        assertEquals("Number of modifiers does not match", 1, roller.getModlist().size());

        roller = new DiceRoller("2d6 1d10+1");
        assertEquals("Number of dice does not match", 3, roller.getDicelist().size());
        assertEquals("Number of modifiers does not match", 1, roller.getModlist().size());
    }



    @Test
    public void monteCarlo()
        throws Exception
    {
        DiceRoller roller = new DiceRoller("2d6");
        int result;
        for(int i = 0; i < 10000; i++)
        {
            result = roller.roll();
            assertTrue("Value was outside lower bound (" + result + ")", result > 1);
            assertTrue("Value was outside upper bound (" + result + ")", result < 13);
        }

        roller = new DiceRoller("2d6 2d100");
        for(int i = 0; i < 10000; i++)
        {
            result = roller.roll();
            assertTrue("Value was outside lower bound (" + result + ")", result > 3);
            assertTrue("Value was outside upper bound (" + result + ")", result < 213);
        }
    }

    @Test
    public void testModifiers()
    {
        DiceRoller roller = new DiceRoller("1d1+9");
        assertEquals( 10, roller.roll() );

        roller = new DiceRoller("1d1+9 1d1+9");
        assertEquals( 20, roller.roll() );
    }
    //}}}
}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

