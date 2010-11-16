/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.util;

import java.util.*;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class DiceRoller
{

    //{{{ Members
        protected List<Integer> dicelist = new ArrayList<Integer>();
        protected List<Integer> modlist = new ArrayList<Integer>();
        private final String DIE_REGEX="(\\d+)d(\\d+)(\\+\\d+)?";  //matches 5d4, 5d4+4, and 123d54
    //}}}

    //{{{ Constuctors
    public DiceRoller( String config )
    {
        parse(config);
    }

    //hide this constructor
    private DiceRoller(){}
    //}}}

    //{{{ Methods

    public int roll()
    {
        int sum = 0;
        for( int die : dicelist )
        {
            sum += roll(die);
        }
        for( int mod : modlist )
        {
            sum += mod;
        }
        return sum;
    }

    /**
     * pulls out the dice and sets up the arrays for use
     * @param
     * @return
     *
     */
    protected void parse( String config )
    {
        Pattern diePattern = Pattern.compile( DIE_REGEX );
        String[] dice = config.split(" ");
        for( String die : dice )
        {
            Matcher m = diePattern.matcher( die );
            if( !m.matches() ) return;
            int count = Integer.parseInt( m.group(1) );
            int max = Integer.parseInt( m.group(2) );
            if( m.group(3) != null )
            {
                modlist.add( Integer.parseInt( m.group(3).substring(1) ) );
            }
            for(int i = 0; i < count; i++)
            {
                dicelist.add(max);
            }
        }
    }

    /**
     * Function to roll a single die of arbitray size and return an random number in the range
     * @param
     * @return
     *
     */
     protected int roll( int maxValue )
     {
         return (int)(maxValue*Math.random() + 1);
     }
    //}}}

    //{{{ Getters and Setters
    public List<Integer> getDicelist(){ return dicelist; }
    public List<Integer> getModlist(){ return modlist; }
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

