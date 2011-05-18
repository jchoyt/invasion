/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.util;

public class RandomUtilities
{

    public static String pickRandom( String[] list )
    {
        if ( list.length == 0 )
        {
            return null;
        }
        int i = (int)(Math.random() * list.length);
        return list[i];
    }
}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

