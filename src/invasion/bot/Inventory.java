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
    private String REPO;
    private List<String> stuff = new ArrayList<String>(  );

    /**
     * Creates a new Inventory object.
     */
    private Inventory(  )
    {
    }

    public Inventory( String filename )
    {
        REPO = filename;
    }

    public void addItem( String item )
    {
        stuff.add(item);
        Utils.save( stuff, REPO );
    }

    public String getItem(  )
    {
        double randomValue = Math.random(  );
        int index = (int) ( randomValue * stuff.size() );
        String ret = stuff.get(index);
        stuff.remove(index);
        Utils.save( stuff, REPO );
        return ret;
    }

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
}

