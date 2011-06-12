/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */
package test.invasion.servlets;

import java.io.StringWriter;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.*;
import java.util.logging.*;
import org.junit.*;
import invasion.servlets.*;

public class RepairTest
{

    //{{{  tests
    @Test
    public void xpCalc()
        throws Exception
    {
        Repair repair = new Repair();
        assertEquals("Starting condition 4, delta 5", 0, repair.calculateXp(4,5));
        assertEquals("Starting condition 0, delta 1", 35, repair.calculateXp(0,1));
        assertEquals("Starting condition 3, delta 2", 13, repair.calculateXp(3,2));
        assertEquals("Starting condition 2, delta 0", 10, repair.calculateXp(2,0));
    }

    @Test
    public void apCalc()
        throws Exception
    {
        Repair repair = new Repair();
        assertEquals("Starting condition 4, delta 5", 2, repair.calculateAp(4,5));
        assertEquals("Starting condition 0, delta 1", 25, repair.calculateAp(0,1));
        assertEquals("Starting condition 3, delta 2", 10, repair.calculateAp(3,2));
        assertEquals("Starting condition 2, delta 0", 18, repair.calculateAp(2,0));
    }
    //}}}
}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

