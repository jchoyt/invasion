/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.pets;

import java.util.logging.Level;
import java.util.logging.Logger;
import invasion.util.*;
import invasion.servlets.*;
import java.beans.*;
import java.sql.*;
public class LocationCache implements PropertyChangeListener
{

    public final static String KEY = LocationCache.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}

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
     * @param
     * @return
     *
     */
    public static void load()
    {
        // subscribe to events
        MoveServlet.subscribe(new LocationCache());
        // Brood.subscribe(this);
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
            query = "select location, count(*) from alt where location >= 1000000 group by location order by location";
            rs = conn.executeQuery(query);
            while(rs.next())
            {
                log.finer( "Setting location " + rs.getString(1) + " to " + rs.getString(2) );
                setCharactersAtLoc(rs.getInt(1), rs.getInt(2));
            }
            DatabaseUtility.close(rs);

            //brood count per location
            query = "select location, count(id) from brood group by location order by location";
            rs = conn.executeQuery(query);
            while(rs.next())
                setCrittersAtLoc(rs.getInt(1), rs.getInt(2));
            DatabaseUtility.close(rs);

            //items count per location
            query = "select locid, count(itemid) from item where locid >= 1000000 group by locid order by locid";
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
        log.finer( "Event received: " + String.valueOf(evt) + ".  Property name is " + evt.getPropertyName());
        if( evt.getPropertyName().equals( MoveServlet.KEY ) )
        {
            log.finer("Adjusting location counts.");
            incrementChars( (Integer)evt.getNewValue() );
            decrementChars( (Integer)evt.getOldValue() );
        }
        //else if
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
	public static int getCrittersAtLoc( int locid ) { return crittersAtLoc[locid - offset]; }
	public static int getItemsAtLoc( int locid ) { return itemsAtLoc[locid - offset]; }
	public static void setCharactersAtLoc(int locid, int count) { charactersAtLoc[locid - offset] = count; }
	public static void setCrittersAtLoc(int locid, int count) { crittersAtLoc[locid - offset] = count; }
	public static void setItemsAtLoc(int locid, int count) { itemsAtLoc[locid - offset] = count; }
    public static void decrementChars( int locid ) { charactersAtLoc[locid - offset]--; }
    public static void decrementCritters( int locid ) { crittersAtLoc[locid - offset]--; }
    public static void decrementItems( int locid ) { itemsAtLoc[locid - offset]--; }
    public static void incrementChars( int locid ) { charactersAtLoc[locid - offset]++; }
    public static void incrementCritters( int locid ) { crittersAtLoc[locid - offset]++; }
    public static void incrementItems( int locid ) { itemsAtLoc[locid - offset]++; }
    //}}}

    //{{{ Getters and Setters
	public int getOffset() { return this.offset; }
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

