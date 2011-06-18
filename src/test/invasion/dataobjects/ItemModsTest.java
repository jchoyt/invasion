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

public class ItemModsTest
{

    //{{{
    ItemMods testee = new ItemMods();
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
    public void testAjustScale()
        throws Exception
    {
        assertEquals( 0.9f, testee.adjustScale( 1.0f, 0.1f), 0.0001 );
        assertEquals( 0.81f, testee.adjustScale( 0.9f, 0.1f), 0.0001 );
        assertEquals( 0.5f, testee.adjustScale( 1.0f, 0.5f), 0.0001 );
        assertEquals( 0.25f, testee.adjustScale( 0.5f, 0.5f), 0.0001 );
        assertEquals( 0.0f, testee.adjustScale( 0.0f, 1.0f), 0.0001 );
    }

    @Test
    public void testMisfireRate()
    {
        float base = 0.0f;
        assertEquals( 0.5f, 1-testee.adjustScale( 1.0f-base, 0.5f), 0.0001  );
        base = 0.5f;
        assertEquals( 0.75f, 1-testee.adjustScale( 1.0f-base, 0.5f), 0.0001  );
        base = 0.1f;
        assertEquals( 0.19f, 1-testee.adjustScale( 1.0f-base, 0.1f), 0.0001  );
        base = 0.1f;
        assertEquals( 0.37f, 1-testee.adjustScale( 1.0f-base, 0.3f), 0.0001  );
        base = 0.37f;
        assertEquals( 0.685f, 1-testee.adjustScale( 1.0f-base, 0.5f), 0.0001  );
    }

    //}}}


}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

