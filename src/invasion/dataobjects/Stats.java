/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.*;
import java.util.*;
import java.sql.*;
import invasion.util.*;
import invasion.ui.NaughtyException;


public class Stats {

    public static final String KEY = Stats .class.getName();
    public static final Logger log = Logger.getLogger(KEY);
    // static { log.setLevel(Level.FINER); }
    private static List<StatAdjustment> queue = new ArrayList<StatAdjustment>();

    //TODO read this directly from the DB
    private static final String[] names = { "Locations Hacked", "Alcohol Consumed", "Food Consumed", "Damage Inflicted", "Damage Suffered",
        "Survival Streak", "Books Read", "Items Repaired", "Items Crafted", "Kills", "Deaths", "Drunkenness", "Black Outs" };
    public static final int HACK = 0;
    public static final int BOOZE = 1;
    public static final int FOOD = 2;
    public static final int DAMDONE = 3;
    public static final int DAMTAKEN = 4;
    public static final int SURVIVE = 5;
    public static final int BOOKS = 6;
    public static final int REPAIRS = 7;
    public static final int CRAFTED = 8;
    public static final int KILLS = 9;
    public static final int DEATHS = 10;
    public static final int MOST_DRUNK = 11;
    public static final int BLACK_OUTS = 12;

    public static synchronized void addChange(int altid, int statid, int increment)
    {
        queue.add(new StatAdjustment( altid, statid, increment ));
    }

    public static String getStatName( int index )
    {
        return names[index];
    }

    public static void writeLog( java.io.Writer out )
    {
        try{
            for(StatAdjustment a : queue)
            {
                out.write( a.toString() );
                out.write( "\n" );
            }
        }
        catch (IOException e)
        {
            //do nothing
            log.throwing( KEY, "Error writing out stats log", e );
        }
    }

    public static void process( InvasionConnection conn )
    throws SQLException
    {
        //Move new adjustments over to a new List in a way that is safe
        List<StatAdjustment> newqueue = new ArrayList<StatAdjustment>();
        List<StatAdjustment> toProcess = queue;
        queue = newqueue;
        //process
        String line = "";
        String query = "update stats set count=count+? where altid=? and statid=?";
        long start = System.currentTimeMillis();
        PreparedStatement ps = conn.prepareStatement(query);
        for(StatAdjustment s : toProcess)
        {
            String[] parts = line.split("\t");
            ps.setInt(1, s.getAdjustment());
            ps.setInt(2, s.getAltid());
            ps.setInt(3, s.getStatid());
            ps.addBatch();
        }
        ps.executeBatch();
        log.info( "Total time to process "+toProcess.size()+" adjustments was " + (System.currentTimeMillis() - start) + "ms");
        DatabaseUtility.close(ps);
    }
}
