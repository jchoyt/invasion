/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

/**
 *  a collection of pets working together
 */

package invasion.pets;

import invasion.servlets.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.*;
import invasion.util.*;
import invasion.dataobjects.*;
import java.sql.*;
import java.beans.*;


public class Brood
{

    public final static String KEY = Brood.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     * The pet database name - for now, leave it as postgres
     */
    public final static String PETDB = "postgres";  //"critterdb";

    //{{{ Common class properties
    public final static PropertyChangeSupport pcs = new PropertyChangeSupport(KEY);

    public final static int GOAL_SURVIVE = 0;
    public final static int GOAL_PROTECT = 1;
    public final static int GOAL_KILL_PSI = 2;
    public final static int GOAL_KILL_MUT = 3;
    public final static int GOAL_KILL_HUMAN = 4;

	public final static int PLAYER_CONTROLLED = 128;
	public final static int FERAL_PSION = 129;
	public final static int FERAL_MUTATE = 130;
	public final static int INVADING = 131;

    protected List<Critter> members = new ArrayList<Critter>();
	protected int ownerId = -1;
	protected int[] goals= new int[5];
	protected int location = 0;
	protected int type = 0;
	protected int id = 0;
	protected List<Defender> targetList = new ArrayList<Defender>();
	protected boolean active = false;
	//}}}

	//{{{ Constructors
	public Brood(int ownerId)
	{
	    this.ownerId = ownerId;
	    insert();
	}

	public Brood(){}
	//}}}

	//{{{ methods
	public void setGoal( int type, int value )
	{
	    if( type < 0 || type > 4 )
        {
            throw new RuntimeException( "Goals must be between 0 and 4, inclusive." );
        }
	    goals[type] = value;
	}

    /**
     * Puts a new brood into the database and sets the Brood ID that's returned from the database.  Note this uses the critter database rather than the main one.
     * @param
     * @return
     *
     */
    public boolean insert()
    {
        String query = "insert into brood (location, type, goal_survive, goal_protect, goal_killpsi,goal_killmut,goal_killhuman) values (?,?,?,?,?,?,?)";
        InvasionConnection conn = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection( PETDB );
            conn.setAutoCommit(false);
            conn.psExecuteInsert(query, "Error adding new brood to the database", location, type, goals[GOAL_SURVIVE], goals[GOAL_PROTECT], goals[GOAL_KILL_PSI], goals[GOAL_KILL_MUT], goals[GOAL_KILL_HUMAN] );
            //get the new brood id
            query="select max(id) as id from brood";
            rs = conn.executeQuery( query );
            rs.next();
            this.id = rs.getInt( "id" );
            return true;
        }
        catch(SQLException e)
        {
            try{ conn.rollback(); } catch (Exception e2) {e2.printStackTrace(System.out);}
            log.throwing( KEY, "a useful message", e);
            return false;
        }
        finally
        {
            try{ conn.commit(); } catch (Exception e2) {e2.printStackTrace(System.out);}
            DatabaseUtility.close(rs);
            conn.close();
        }

    }

    /**
     * Updates the brood in the database.  Note this uses the critter database rather than the main one.
     * @param
     * @return
     *
     */
    public boolean update( InvasionConnection conn )
    {
        String query = "update brood set location=?, type=?, goal_survive=?, goal_protect=?, goal_killpsi=?, goal_killmut=?, goal_killhuman=? where id=?";
        int count = conn.psExecuteUpdate(query, "Error updating brood in the database", location, type, goals[GOAL_SURVIVE], goals[GOAL_PROTECT], goals[GOAL_KILL_PSI], goals[GOAL_KILL_MUT], goals[GOAL_KILL_HUMAN], id );
        if( count != 1 )
        {
            log.severe( "Brood " +  id + " not updated.  Count was " + count);
            return false;
        }
        else
            return true;
    }


    /**
     * General movement, attacking, etc.
     *
     * @param
     * @return
     *
     */
    public void act()
    {
        log.entering(KEY, "act");
        //move
        InvasionConnection conn = null;
        ResultSet rs = null;
        String query = null;
        buildTargetList();
        if( targetList.size() == 0 )
        {
            int dir = (int)(Math.random() * 8);
            query = "select id from location l where (station, level, x, y) in (select station, level, x + " + MoveServlet.xdelta[dir] + ", y + " + MoveServlet.ydelta[dir] + " from location s where id=?)";
            int oldloc = location;
            try
            {
                conn = new InvasionConnection( PETDB );
                rs = conn.psExecuteQuery(query, "Brood movmement not updated", location);
                if(rs.next())
                {
                    location = rs.getInt(1);
                }
                DatabaseUtility.close(rs);
                if(!update( conn ))
                {
                    log.severe("Failed to update the brood after movement.  Things will be ... inconsistent.");
                    return;
                }
                else
                    pcs.firePropertyChange(KEY, oldloc, location);
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

        //combine if possible
        if( ownerId == -1 ) // if feral
        {
            //check for other ferals
            if( LocationCache.getBroodsAtLoc(location) > 1 )
            {
                try
                {
                    //if(conn == null)
                    conn = new InvasionConnection( PETDB );
                    query = "select b.id from brood b where owner = -1 and location = ? and id != ?";
                    rs = conn.psExecuteQuery(query, "Error grabbing list of feral broods to merge with", location, id);
                    while(rs.next())
                    {
                        int broodId = rs.getInt(1);
                        Brood b = BroodManager.getFeralBrood( broodId );
                        if( b == null )
                        {
                            b = BroodManager.getFeralBrood( broodId );
                            BroodManager.addBrood( b );
                        }
                        if( b.getPowerRating() > this.getPowerRating() )
                        {
                            this.mergeInto(conn, b);
                            this.delete(conn);
                            break;
                        }
                        else  //merge the new brood into this one
                        {
                            b.mergeInto(conn, this);
                            b.delete(conn);
                        }
                    }
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
        }
        //rebuild target list to see if there's someone to attack in the *new* location
        buildTargetList();
        //check for stuff to attack
        if( targetList.size() > 0 )
        {
            for( Critter c : members )
            {
                //TODO - make these focused attacks
                int randomTarget = (int) (Math.random() * targetList.size() );
                c.attack( targetList.get(randomTarget), conn );
            }
        }
        else
            active = false;
        //attack
        log.exiting(KEY, "act");
    }


    /**
     * bulids a list of potential targets
     *
     * @param
     * @return
     *
     */
    public void buildTargetList()
    {
        targetList.clear();
        //find targets
        String query = "select * from alt where location = ? and ticksalive > 0";
        //TODO - faction check
        InvasionConnection conn = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();

            if( LocationCache.getCharactersAtLoc(location) > 1 || (LocationCache.getCharactersAtLoc(location) > 0 && ownerId == -1 ) )  // more than one character or feral and any characters
            {
                rs = conn.psExecuteQuery( query, "Error", location );
                while(rs.next())
                {
                    //TODO - determine if enemy
                    targetList.add(Alt.load(conn, rs.getInt("id")));
                }
                DatabaseUtility.close(rs);
            }

            if( LocationCache.getBroodsAtLoc(location) > 1 )
            {
                query = "select * from brood b join critters c on b.id=c.brood where b.id != ? and location = ?";
                rs = conn.psExecuteQuery( query, "Error", id, location );
                while(rs.next())
                {
                    //TODO - determine if enemy
                    targetList.add(Alt.load(conn, rs.getInt("id")));
                }
                DatabaseUtility.close(rs);
            }
            // rank targets.  Higher attractiveness for lower armor and them dishing out higher damage per "round"

            // max 3 brood members per target

            // figure out best way to defend brood owner

        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            if( targetList.size() == 0 )
                active=false;
            else
                active=true;
            conn.close();
        }
    }

    /**
     * Moves critters from this brood into another both in the database and in the BroodManager
     * @param
     * @return
     *
     */
    public void mergeInto( InvasionConnection conn, Brood b )
    {
        b.getMembers().addAll( this.members );
        String query = "update critters set brood = ?  where brood = ?";
        conn.psExecuteUpdate(query, "Failure merging broods", b.getId(), id);
        this.members = null;
    }

    /**
     * Deletes the brood from the database
     * @param
     * @return
     *
     */
    public void delete(InvasionConnection conn)
    {
        BroodManager.removeBrood(this);
        String query = "delete from brood where id=?";
        conn.psExecuteUpdate(query, "Deleting merged brood", id);
    }


    /**
     * Adds a new critter to the List in this Brood object - does not make any database changes.
     * @param
     * @return
     *
     */
	public void addMember(Critter newCritter)
	{
	    members.add(newCritter);
	}

    /**
     * Removes a specific critter from the List in this Brood object - does not make any database changes.
     * @param
     * @return
     *
     */
	public void removeMember( Critter oldCritter)
	{
	    members.remove(oldCritter);
	    if( members.size() == 0 )
        {

        }
	}

	public int getPowerRating()
	{
	    //TODO - do something smart here
	    return members.size();
	}

	public boolean equals(Object o)
	{
	    if( o instanceof Brood )
        {
            return id == ((Brood)o).getId();
        }
        return false;
	}

	public int hashcode(Object o)
	{
	    return id;
	}

	//}}}

    //{{{  Getters and Setters
    public List<Critter> getMembers() { return this.members; }
    public void setMembers(List<Critter> members) { this.members = members; }
	public int getOwnerId() { return this.ownerId; }
	public void setOwnerId(int ownerId) { this.ownerId = ownerId; }
	public int[] getGoals() { return this.goals; }
	public void setGoals(int[] goals) { this.goals = goals; }
    public int getLocation() { return this.location; }
	public void setLocation(int location) { this.location = location; }
	public int getType() { return this.type; }
	public void setType(int type) { this.type = type; }
    public int getId() { return this.id; }
	public void setId(int id) { this.id = id; }
	public List<Defender> getTargetList() { return this.targetList; }
	public void setTargetList(List<Defender> targetList) { this.targetList = targetList; }
	public boolean getActive() { return this.active; }
	public void setActive(boolean active) { this.active = active; }
    //}}}

}
 // :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:`
