/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.pets;

import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.*;
import java.io.*;
import java.util.*;

/**
 * @deprecated  Failed experiment, but I may have to come back to it
 *
 * @see #Critter(static methods)
 */
public class BroodManager
{

    public final static String KEY = BroodManager.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}

    //{{{ Members
	protected static Map<Integer, Brood> playerBroods = new HashMap<Integer, Brood>();
	protected static List<Brood> feralBroods = new ArrayList<Brood>();
	protected static File serializedFileLocation = null;
	protected static Map<Integer, Brood> playerAddBuffer = new HashMap<Integer, Brood>();
	protected static List<Brood> feralAddBuffer = new ArrayList<Brood>();
	protected static List<Integer> playerRemoveBuffer = new ArrayList<Integer>();
	protected static List<Brood> feralRemoveBuffer = new ArrayList<Brood>();
    //}}}

    //{{{ Constuctors
    /**
     * Constructor that tells the manager where to find/serialize the broods to disk
     * @param  file path to where the file should be found/kept
     *
     */
    public BroodManager(String file)
    {
        serializedFileLocation = new File( file );
    }

    private BroodManager(){}

    //}}}

    //{{{ Methods
    public static void workBroods()

    {
       //remove all marked for removal
       List<Integer> temp1 = playerRemoveBuffer;
       playerRemoveBuffer = new ArrayList<Integer>();
       for( Integer i : temp1 )
           playerBroods.remove( i );
       List<Brood> temp2 = feralRemoveBuffer;
       feralRemoveBuffer = new ArrayList<Brood>();
       for( Brood b : temp2 )
           feralBroods.remove( b );

       //add all new
       Map<Integer, Brood> temp3 = playerBroods;
       playerBroods = new HashMap<Integer, Brood>();
       playerBroods.putAll( temp3 );

       List<Brood> temp4 = feralAddBuffer;
       feralAddBuffer = new ArrayList<Brood>();
       feralBroods.addAll( temp4 );

       //cycle through and initiate each one
       for( Integer key : playerBroods.keySet() )
           playerBroods.get(key).act();

       for( Brood b : feralBroods )
           b.act();
    }

    public static Critter getCritter( int id, JSONArray alerts )
    {
        for(Brood b : feralBroods)
            for(Critter c : b.getMembers() )
                if(c.getId() == id) return c;
        for(Brood b : playerBroods.values())
            for(Critter c : b.getMembers() )
                if(c.getId() == id) return c;
        return null;
    }

    /**
     * Returns a JSON object with a list of all the critters at a specific location
     * @param
     * @return
     *
     */
    public static JSONArray petsAtLocation( int locid )
        throws JSONException
    {
        JSONArray ret = new JSONArray();
        //TODO iterate and check feral and player broods
        for(Brood b : feralBroods)
            if( b.getLocation() == locid )
                for(Critter c : b.getMembers() )
                    ret.put(c.toJson());
        for(Brood b : playerBroods.values())
            if( b.getLocation() == locid )
                for(Critter c : b.getMembers() )
                    ret.put(c.toJson());
        return ret;
    }

    /**
     * Loads a serialized set of broods from a file on disk
     */
    public static void load( )
    {
        //TODO simple serialzation
    }

    /**
     *  Serializes the broods to a file on disk
     */
    public static void save( )
    {
        //TODO simple serialization
    }

    /**
     * Adds a new Brood to the manager.  What actually happens is it's added to a buffer which is then merged
     * when all the actions for all broods are done.
     *
     * @param b the brood to add
     */
    public static void addBrood( Brood b )
    {
        log.finer("new brood is owned by " + b.getOwnerId() );
        if( b.getOwnerId() == -1 )
            feralAddBuffer.add(b);
        else
            playerAddBuffer.put( b.getOwnerId(), b );
    }

    /**
     * Removes a Brood from the manager.  What actually happens is it's added to a list of Broods to be removed
     * at the end of the next action cycle
     * @param b the Brood to remove
     */
    public static void removeBrood( Brood b )
    {
        if( b.getOwnerId() == -1 )
            feralRemoveBuffer.add( b );
        else
            playerRemoveBuffer.add( b.getOwnerId() );
    }
    //}}}

    //{{{ Getters and Setters
    public static List<Brood> getFeralBroods() { return feralBroods; }
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

