/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */


package invasion.bot;

import java.io.*;
import java.util.*;

/**
 * This class holds and manages a list of stuff for NexusBot.
 */
public class Inventory
{
    /**
     * DOCUMENT ME!
     */
    private String REPO;

    /**
     * DOCUMENT ME!
     */
    private List<String> stuff = new ArrayList<String>(  );

    /**
     * Creates a new Inventory object.
     */
    private Inventory(  )
    {
    }


    /**
     * Creates a new Inventory object.
     *
     * @param filename DOCUMENT ME!
     */
    public Inventory( String filename )
    {
        REPO = filename;
    }

    /**
     * DOCUMENT ME!
     *
     * @param who DOCUMENT ME!
     * @param message DOCUMENT ME!
     */
    public void addItem( String item )
    {
        stuff.add(item);
        Utils.save( stuff, REPO );
    }


    /**
     * returns a list of messages for the user named
     */
    public String getItem(  )
    {
        double randomValue = Math.random(  );
        int index = (int) ( randomValue * stuff.size() );
        String ret = stuff.get(index);
        stuff.remove(index);
        Utils.save( stuff, REPO );
        return ret;
    }


    /**
     * DOCUMENT ME!
     */
    public void load(  )
    {
        try
        {
            BufferedReader br = new BufferedReader(new FileReader(REPO));
            String thisLine;
            while ((thisLine = br.readLine()) != null)
            {
                stuff.add(thisLine);
            }
        }
        catch ( IOException e1 )
        {
            e1.printStackTrace(  );
        }
    }


    public int getInventoryCount()
    {
        return stuff.size();
    }

    /**
     * DOCUMENT ME!
     *
     * @return DOCUMENT ME!
     */
    // public List reviewAllInventory(  )
    // {
    //     List ret = new ArrayList(  );

    //     for ( String o : messages.keySet(  ) )
    //     {
    //         ret.add( "Inventory for " + o );
    //         ret.addAll( messages.get( o ) );
    //     }

    //     return ret;
    // }
}

