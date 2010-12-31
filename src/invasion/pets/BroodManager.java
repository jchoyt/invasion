/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.pets;

import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.*;
import java.io.*;
import java.util.*;
import invasion.util.*;
import java.sql.*;

/**
 * Objects for having "active" broods working.  An active Brood is one that is in combat, or was recently in combat.
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
    /**
     * Everyone acts on the tick
     * @param
     * @return
     *
     */
    public static void workBroodsForTick()
    {
        log.entering(KEY, "workBroodsForTick");
       //cycle through and initiate each one
       for( Integer key : playerBroods.keySet() )
           playerBroods.get(key).act();

       for( Brood b : feralBroods )
           b.act();
        log.exiting(KEY, "workBroodsForTick");
    }

    /**
     * use for every X second activity
     * @param
     * @return
     *
     */
    public static void workBroods()
    {
       //cycle through and initiate each one
       for( Integer key : playerBroods.keySet() )
           if( playerBroods.get(key).getActive() )
               playerBroods.get(key).act();
       for( Brood b : feralBroods )
           if( b.getActive() )
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
     * Loads the broods
     */
    public static void load( )
    {
        InvasionConnection conn = null;
        //Load
        Brood ret;
        String query = "select * from brood";
        ResultSet rs = null;
        ResultSet rs2 = null;
        //load up basic data
        try
        {
            conn = new InvasionConnection( Brood.PETDB );
            rs = conn.executeQuery(query);
            while(rs.next())
            {
                ret = new Brood();
                ret.setLocation( rs.getInt("location") );
                ret.setType( rs.getInt("type") );
                ret.setGoal( Brood.GOAL_SURVIVE, rs.getInt("goal_survive") );
                ret.setGoal( Brood.GOAL_PROTECT, rs.getInt("goal_protect") );
                ret.setGoal( Brood.GOAL_KILL_PSI, rs.getInt("goal_killpsi") );
                ret.setGoal( Brood.GOAL_KILL_MUT, rs.getInt("goal_killmut") );
                ret.setGoal( Brood.GOAL_KILL_HUMAN, rs.getInt("goal_killhuman") );
                ret.setOwnerId( rs.getInt("owner") );
                ret.setId( rs.getInt("id") );
                //process
                query = "select id from critters where brood = ?";
                rs2 = conn.psExecuteQuery(query, "Error message", ret.getId());
                while(rs2.next())
                    ret.addMember( CritterFactory.loadCritter( conn, rs2.getInt("id" ) ) );
                DatabaseUtility.close(rs2);
                if( ret.getOwnerId() == -1 )
                    feralBroods.add(ret);
                else
                    playerBroods.put( ret.getOwnerId(), ret );
            }
            DatabaseUtility.close(rs);
            //load up members
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            log.finer("Loaded " + feralBroods.size() + " feral broods and " + playerBroods.size() + " player broods.");
            DatabaseUtility.close(rs);
        }
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
            feralBroods.add(b);
        else
            playerBroods.put( b.getOwnerId(), b );
    }

    /**
     * Removes a Brood from the manager.  What actually happens is it's added to a list of Broods to be removed
     * at the end of the next action cycle
     * @param b the Brood to remove
     */
    public static void removeBrood( Brood b )
    {
        if( b.getOwnerId() == -1 )
            feralBroods.remove( b );
        else
            playerBroods.remove( b.getOwnerId() );
    }

    public static Brood getFeralBrood( int id )
    {
        for(Brood b : feralBroods)
            if( b.getId() == id )
                return b;
        return null;
    }
    //}}}

    //{{{ Getters and Setters
    public static List<Brood> getFeralBroods() { return feralBroods; }
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:
