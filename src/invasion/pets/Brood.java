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
import invasion.bot.*;
import invasion.dataobjects.*;
import java.sql.*;
import java.beans.*;


public class Brood  implements PropertyChangeListener
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
	protected boolean active = true;
	//}}}

	//{{{ Constructors
	public Brood(int ownerId)
	{
	    this.ownerId = ownerId;
	    insert();
	}

	public Brood()
	{
        MoveServlet.pcs.addPropertyChangeListener(this);
	}
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
            MoveServlet.pcs.addPropertyChangeListener(this);
        }

    }

    /**
     * Updates the brood in the database.  Note this uses the critter database rather than the main one.
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
     * General movement, combining, etc.
     *
     * @param conn Connection to the main database
     * @param pConn Connection to the pet database
     *
     */
    public void act( InvasionConnection conn, InvasionConnection pConn )
    {
        log.entering(KEY, "Brood " + id + " acting");
        //move
        ResultSet rs = null;
        String query = null;
        buildTargetList( conn );
        if( ownerId < 1 && targetList.size() == 0 ) //move feral broods (not player broods) if no targets to attack
        {
            //TODO only move to valid destinations
            query = "select l.typeid, l.id from location l join location l2 on (l.station=l2.station and l.x between l2.x-1 and l2.x+1 and l.y between l2.y-1 and l2.y+1 and l.id!=l2.id) where l2.id=? order by random()";
            int oldloc = location;
            try
            {
                rs = pConn.psExecuteQuery(query, "Brood movmement not updated", location);
                while(rs.next())
                {
                    if( Constants.DISALLOWED_LOCATIONS.contains(rs.getInt("typeid") ) )
                    {
                        continue;
                    }
                    location = rs.getInt("id");
                    break;
                }
                DatabaseUtility.close(rs);
                if(update( pConn ))
                {
                    pcs.firePropertyChange( KEY, oldloc, this );
                }
                else
                {
                    log.severe("Failed to update the brood after movement.  Resyncing.");
                    List<String> list = LocationCache.verify();
                    VasionBot.announce("Failed to update the brood after movement.  I had to resync the cache and found " + list.size() + " thing(s) wrong." );
                    for( String s : list )
                    {
                        log.info( s );
                    }
                    return;
                }
            }
            catch(SQLException e)
            {
                log.throwing( KEY, "a useful message", e);
                throw new RuntimeException(e);
            }
            finally
            {
                DatabaseUtility.close(rs);
            }
        }

        //combine if possible
        if( ownerId < 1 && LocationCache.getBroodsAtLoc(location) > 1 ) // if feral and other ferals exist
        {
            try
            {
                query = "select b.id from brood b where owner is null and location = ? and id != ?";
                rs = pConn.psExecuteQuery(query, "Error grabbing list of feral broods to merge with", location, id);
                while(rs.next())
                {
                    int broodId = rs.getInt(1);
                    Brood b = BroodManager.getFeralBrood( broodId );
                    if( b == null )  //this should never happen.  Just trying to protect the code - TODO add an announcement by the bot
                    {
                        b = BroodManager.getFeralBrood( broodId );
                        BroodManager.addBrood( b );
                    }

                    //merge if total size will be < 4-7
                    if( ( b.members.size() + members.size() + (Math.random()*3 ) ) < 8 )
                    {
                        if( b.getPowerRating() > this.getPowerRating() )
                        {
                            this.mergeInto(pConn, b);
                            //break;
                        }
                        else  //merge the new brood into this one
                        {
                            b.mergeInto(pConn, this);
                        }
                    }
                    else
                        log.finer("Not merging broods " + id + " and " + b.id + " because the size would be " + (b.members.size() + members.size()));
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
            }
        }
        //rebuild target list to see if there's someone to attack in the *new* location
        buildTargetList( conn );

        //attack will happenon the pet tick
        log.exiting(KEY, "act");
    }

    public void attack( InvasionConnection conn )
    {
        buildTargetList(conn);
        log.finer( "Brood " + id + " preparing to attack - there are " + targetList.size() + " targets.");
        if( targetList.size() == 0 )
        {
            active=false;
            return;
        }
        int randomTarget = -1;
        for( Critter c : members )
        {
            //TODO - make these focused attacks
            //TODO - stop attacking when the target is dead - maybe - check Critter attack and if it's smart enough to stop attacking when someone is dead
            randomTarget = (int) (Math.random() * targetList.size() );
            Defender target = targetList.get(randomTarget);
            c.attack( target, conn );
            if( target.getLocation() != location )
            {
                targetList.remove(target);
                if( targetList.size() < 1 )
                {
                    active = false;
                    return;
                }
            }
        }
    }


    /**
     * bulids a list of potential targets
     *
     *
     */
    public void buildTargetList( InvasionConnection conn )
    {
        targetList.clear();
        //find targets
        String query = "select id from alt where location = ? and ticksalive > 0";
        //TODO - faction check
        ResultSet rs = null;
        try
        {
            if( LocationCache.getCharactersAtLoc(location) > 1 || (LocationCache.getCharactersAtLoc(location) > 0 && ownerId < 1 ) )  // more than one character or feral and any characters
            {
                log.finer("Checking for targets for brood " + id + " at location " + location );
                rs = conn.psExecuteQuery( query, "Error", location );
                while(rs.next())
                {
                    //TODO - determine if enemy
                    targetList.add(Alt.load(conn, rs.getInt("id")));
                    log.finer("Adding a target to the list for brood " + id );
                }
                DatabaseUtility.close(rs);
            }

            /* if( LocationCache.getBroodsAtLoc(location) > 1 )
            {
                query = "select * from brood b join critters c on b.id=c.brood where b.id != ? and location = ?";
                rs = conn.psExecuteQuery( query, "Error", id, location );
                while(rs.next())
                {
                    //TODO - determine if enemy
                    targetList.add(Alt.load(conn, rs.getInt("id")));
                }
                DatabaseUtility.close(rs);
            } */
            // TODO rank targets.  Higher attractiveness for lower armor and them dishing out higher damage per "round"

            // TODO max 3 brood members per target

            // TODO figure out best way to defend brood owner
            // log.finer("Brood " + id + " has a list of " + targetList.size() + " targets to choose from." );

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
        }
    }

    /**
     * Moves critters from this brood into another in the database
     * @param conn The pet database
     *
     */
    public void mergeInto( InvasionConnection conn, Brood b )
    {
        b.getMembers().addAll( this.members );
        String query = "update critters set brood = ?  where brood = ?";
        conn.psExecuteUpdate(query, "Failure merging broods", b.getId(), id);
        delete( conn );
        this.members = new ArrayList<Critter>();
    }

    /**
     * Deletes the brood from the database and the BroodManager
     *
     */
    protected boolean delete(InvasionConnection conn)
    {
        BroodManager.removeBrood(this);
        String query = "delete from brood where id=?";
        return 1 == conn.psExecuteUpdate(query, "Deleting merged brood", id);
    }


    /**
     * Adds a new critter to the List in this Brood object - does not make any database changes.
     *
     */
	public void addMember(Critter newCritter)
	{
	    members.add(newCritter);
	}

    /**
     * Removes a specific critter from the List in this Brood object - does not make any database changes.
     *
     */
	public void removeMember( Critter oldCritter, InvasionConnection conn )
	{
	    members.remove(oldCritter);
	    if( members.size() == 0 )
        {
            //remove from MoveServelet PCS
            MoveServlet.pcs.removePropertyChangeListener(this);
            //delete brood from database
            String query = "delete from brood where id=" + id;
            try
            {
                conn.executeUpdate(query);
            }
            catch(SQLException e)
            {
                log.throwing( KEY, "Failed to remove brood " + id + " from the database." , e);
                throw new RuntimeException(e);
            }
            //delete from BroodManager
            BroodManager.removeBrood(this);
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

	//{{{ for PropertyChangeListener
    public void propertyChange(PropertyChangeEvent evt)
    {
        // log.finer("Receive PCE " + evt.toString() );
        if( evt.getPropertyName().equals( MoveServlet.KEY ) )
        {
            Integer i = (Integer)evt.getNewValue();
            if( location == i.intValue() )
            {
                // log.finer("A target entered our tile!  Get 'em");
                active = true;
            }
        }
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
	public int getSize() { return this.members.size(); }
    //}}}

}
 // :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:`
