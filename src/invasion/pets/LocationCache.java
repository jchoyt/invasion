/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.pets;

import java.util.ArrayList;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.List;
import invasion.servlets.*;
import invasion.util.*;

public class LocationCache implements PropertyChangeListener
{

    public final static String KEY = LocationCache.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    //{{{ Members
	protected static int[] charactersAtLoc = null;
	protected static int[] crittersAtLoc = null;
	protected static int[] itemsAtLoc = null;
	protected static int offset = 0;
    //}}}

    //{{{ Constuctors
    //}}}

    //{{{ Methods
    /**
     * Run at webapp start to pre-load the cache with whatever is in the database
     *
     */
    public static void load()
    {
        // subscribe to events
        MoveServlet.pcs.addPropertyChangeListener(new LocationCache());
        Brood.pcs.addPropertyChangeListener(new LocationCache());
        String query = "select min(id), max(id) - min(id) from location where id >= 1000000";
        InvasionConnection conn = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();
            rs = conn.executeQuery(query);
            if(rs.next())
            {
                init(rs.getInt(1), rs.getInt(2));
            }
            else
                throw new RuntimeException("Could not initialize LocationCache");
            DatabaseUtility.close(rs);

            //character count per location
            query = "select location, count(*) from alt where location >= 1000000 and ticksalive > 0 group by location order by location";
            rs = conn.executeQuery(query);
            while(rs.next())
            {
                log.finer( "Setting location " + rs.getString(1) + " to " + rs.getString(2) );
                setCharactersAtLoc(rs.getInt(1), rs.getInt(2));
            }
            DatabaseUtility.close(rs);

            //critter count per location
            query = "select location, count(c.id) from brood b join critters c on (b.id=c.brood) group by location";
            rs = conn.executeQuery(query);
            while(rs.next())
                setCrittersAtLoc(rs.getInt(1), rs.getInt(2));
            DatabaseUtility.close(rs);

            //items count per location
            query = "select locid, count(itemid) from item where locid >= 1000000 and locid < 2000000 group by locid order by locid";
            rs = conn.executeQuery(query);
            while(rs.next())
                setItemsAtLoc(rs.getInt(1), rs.getInt(2));
            DatabaseUtility.close(rs);
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            conn.close();
        }

    }

    /**
     * Check to make sure the Cache matches the database
     *
     */
    public static List<String> verify()
    {
        String query = "select min(id), max(id) - min(id) from location where id > 999999";
        InvasionConnection conn = null;
        ResultSet rs = null;
        List<String> ret = null;
        try
        {
            ret = new ArrayList<String>();
            conn = new InvasionConnection();
            //character count per location
            query = "select location, count(*) from alt where location > 999999 and ticksalive > 0 group by location order by location";
            rs = conn.executeQuery(query);
            while(rs.next())
            {
                if( getCharactersAtLoc( rs.getInt(1) ) != rs.getInt(2) )
                {
                    ret.add( "Character count for location " + rs.getInt(1) + " does not match.  Cache says " + getCharactersAtLoc( rs.getInt(1) ) + " while the database has " + rs.getInt(2) + ".  Correcting." );
                    setCharactersAtLoc(rs.getInt(1), rs.getInt(2));
                }
                // else ret.add("Location " + rs.getInt(1) + " verified correct.");
            }
            DatabaseUtility.close(rs);

            //critter count per location
            query = "select location, count(c.id) from brood b join critters c on (b.id=c.brood) group by location";
            rs = conn.executeQuery(query);
            while(rs.next())
            {
                int loc = rs.getInt(1);
                int count = rs.getInt(2);
                if( getBroodsAtLoc( loc ) != count )
                {
                    ret.add( "Critter count for location " + loc + " does not match.  Cache says " + getCharactersAtLoc( loc ) + " while the database has " + count + ".  Correcting." );
                    setCrittersAtLoc(rs.getInt(1), rs.getInt(2));
                }
            }
            DatabaseUtility.close(rs);

        //     //items count per location
        //     query = "select locid, count(itemid) from item where locid >= 1000000 group by locid order by locid";
        //     rs = conn.executeQuery(query);
        //     while(rs.next())
        //         setItemsAtLoc(rs.getInt(1), rs.getInt(2));
        //     DatabaseUtility.close(rs);
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            conn.close();
        }
        return ret;

    }


    protected static void init( int shift, int span )
    {
        offset = shift;
        charactersAtLoc = new int[span];
        crittersAtLoc = new int[span];
        itemsAtLoc = new int[span];
        log.finer("Offset initialized to " + offset + " and each array initialized to size " + span );
    }

    public void propertyChange(PropertyChangeEvent evt)
    {
        if( evt.getPropertyName().equals( MoveServlet.KEY ) )
        {
            log.finer("Adjusting location counts. " + evt );
            incrementChars( (Integer)evt.getNewValue() );
            decrementChars( (Integer)evt.getOldValue() );
        }
        else if( evt.getPropertyName().equals( Brood.KEY ) )
        {
            log.finer("Adjusting location counts. " + evt);
            Brood b = (Brood)evt.getNewValue();
            incrementCritters( b.getLocation(), b.getSize() );
            decrementCritters( (Integer)evt.getOldValue(), b.getSize() );
        }
    }

    public static void logCounts()
    {
        for(int i = 0; i < charactersAtLoc.length; i++)
        {
            // log.finer( "checking " + i );
            if( charactersAtLoc[i] != 0 )
            {
                log.finer( "There are " + charactersAtLoc[i] + " characters at location " + ( i + offset ) + " which should equal " + getCharactersAtLoc( i + offset ));
            }
        }
    }

	public static int getCharactersAtLoc( int locid ) { return charactersAtLoc[locid - offset]; }
	public static int getBroodsAtLoc( int locid ) { return crittersAtLoc[locid - offset]; }
	public static int getItemsAtLoc( int locid ) { return itemsAtLoc[locid - offset]; }
	public static void setCharactersAtLoc(int locid, int count) { charactersAtLoc[locid - offset] = count; }
	public static void setCrittersAtLoc(int locid, int count) { crittersAtLoc[locid - offset] = count; }
	public static void setItemsAtLoc(int locid, int count) { itemsAtLoc[locid - offset] = count; }
    public static void decrementChars( int locid ) { charactersAtLoc[locid - offset]--; }
    public static void decrementCritters( int locid ) { crittersAtLoc[locid - offset]--; }
    public static void decrementCritters( int locid, int count ) { crittersAtLoc[locid - offset] = crittersAtLoc[locid - offset] - count; }
    public static void decrementItems( int locid ) { itemsAtLoc[locid - offset]--; }
    public static void incrementChars( int locid ) { charactersAtLoc[locid - offset]++; }
    public static void incrementCritters( int locid ) { crittersAtLoc[locid - offset]++; }
    public static void incrementCritters( int locid, int count ) { crittersAtLoc[locid - offset] = crittersAtLoc[locid - offset] + count; }
    public static void incrementItems( int locid ) { itemsAtLoc[locid - offset]++; }
    public static int getSize() { return charactersAtLoc.length; }
    //}}}

    //{{{ Getters and Setters
	public int getOffset() { return this.offset; }
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

