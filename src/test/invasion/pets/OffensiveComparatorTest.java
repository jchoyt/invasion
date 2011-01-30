/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package test.invasion.pets;

import java.io.StringWriter;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.*;
import java.util.logging.*;
import org.junit.*;
import invasion.pets.*;

public class OffensiveComparatorTest
{

    //{{{
    private Critter c1;
    private Critter c2;
    OffensiveComparator testee = new OffensiveComparator();
    //}}}

    //{{{ Setup
    /**
     * Sets up the test fixture.
     * (Called before every test case method.)
     */
    @Before
    public void setUp() throws Exception {
        c2 = new Dalek();

        c1 = new Critter(){
            public void setBroodGoals( Brood brood ) {}
        };
    } //}}}


    //{{{  tests
    @Test
    public void testCompare()
        throws Exception
    {
        List<Critter> critters = new ArrayList<Critter>();
        critters.add(c1);
        critters.add(c2);
        assertFalse( critters.get(0) instanceof Dalek );
        Collections.sort( critters, new OffensiveComparator());
        assertTrue( critters.get(1) instanceof Dalek );
    } //}}}


}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

