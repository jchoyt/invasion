/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

/**
 *  a collection of pets working together
 */

package invasion.pets;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.*;
import invasion.util.*;
import invasion.dataobjects.*;
import java.sql.*;


public class Brood
{

    public final static String KEY = Brood.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}

    /**
     * The pet database name - for now, leave it as postgres
     */
    public final static String PETDB = "postgres";  //"critterdb";

    //{{{ Common class properties
    public final static int GOAL_SURVIVE = 0;
    public final static int GOAL_PROTECT = 1;
    public final static int GOAL_KILL_PSI = 2;
    public final static int GOAL_KILL_MUT = 3;
    public final static int GOAL_KILL_HUMAN = 4;
    protected List<Critter> members = new ArrayList<Critter>();
	protected int ownerId = -1;
	protected int[] goals= new int[5];
	protected int location = 0;
	public final static int PLAYER_CONTROLLED = 128;
	public final static int FERAL_PSION = 129;
	public final static int FERAL_MUTATE = 130;
	public final static int INVADING = 131;
	protected int type = 0;
	protected int id = 0;
	//}}}

	//{{{ Constructors
	public Brood(int ownerId)
	{
	    this.ownerId = ownerId;
	    insert();
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
     *  Deploy the troops
     */
    public void combat()
    {
        List<Defender> targets = new ArrayList<Defender>();
        //find targets
        String query = "select * from alt where location = ? and ticksalive > 0";
        //TODO - faction check
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, location );
            rs = ps.executeQuery();
            while(rs.next())
            {
                targets.add(Alt.load(conn, rs.getInt("id")));
            }
            if( targets.size() == 0 )
            {
                return;
            }
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);

            // rank targets.  Higher attractiveness for lower armor and them dishing out higher damage per "round"

            // max 3 brood members per target

            // figure out best way to defend brood owner

            // do attacks
            for( Critter c : members )
            {
                //TODO - make these focused attacks
                int randomTarget = (int) (Math.random() * targets.size() );
                c.attack( targets.get(randomTarget), conn );
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
            DatabaseUtility.close(ps);
            conn.close();
        }
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
    public boolean update()
    {
        String query = "update brood set location=?, type=?, goal_survive=?, goal_protect=?, goal_killpsi=?, goal_killmut=?, goal_killhuman=? where id=?";
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection( PETDB );
            int count = conn.psExecuteUpdate(query, "Error updating brood in the database", location, type, goals[GOAL_SURVIVE], goals[GOAL_PROTECT], goals[GOAL_KILL_PSI], goals[GOAL_KILL_MUT], goals[GOAL_KILL_HUMAN], id );
            if( count != 1 )
            {
                log.warning( "Brood " +  id + " not updated.  Count was " + count);
                return false;
            }
            else
                return true;
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            return false;
        }
        finally
        {
            conn.close();
        }

    }

    public void act()
    {
        //move

        //combine if possible

        //attack
        combat();
    }

	public void addMember(Critter newCritter)
	{
	    members.add(newCritter);
	}

	public void removeMember( Critter oldCritter)
	{
	    members.remove(oldCritter);
	}

	public int getPowerRating()
	{
	    //TODO - do something smart here
	    return members.size();
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
    //}}}

}

class Target
{
    //{{{ Members
	protected int id = 0;
	protected float attackAvg = 5.0f;
	protected boolean soakingPhysical = true;
	protected boolean soakingEnergy = true;
	protected int hpLeft = 0;
	protected int level = 0;
	protected int maxHp = 0;
    //}}}

    //{{{ Constructors
    public Target( ResultSet rs )
        throws SQLException
    {
        id = rs.getInt("id");
        level = rs.getInt("level");
        attackAvg = level;  //assume "level" damage per attack
        int hp = rs.getInt("hp");
        maxHp = rs.getInt("hpmax");
        int hpPercent = 100*hp/maxHp;
        if( hpPercent < 10 )
            hpLeft =  4;
        else if( hpPercent < 25 )
             hpLeft = 3;
        else if( hpPercent < 50 )
             hpLeft = 2;
        else if( hpPercent < 99 )
            hpLeft = 1;
        else
            hpLeft = 0;
    }
    //}}}

    //{{{ Methods
    public int getTargetAttractivness()
    {
        return 1;
    }
    //}}}

	//{{{ Setters and Getters
	public int getId() { return this.id; }
	public void setId(int id) { this.id = id; }
	public float getAttackAvg() { return this.attackAvg; }
	public void setAttackAvg(float attackAvg) { this.attackAvg = attackAvg; }
	public boolean isSoakingPhysical() { return this.soakingPhysical; }
	public void setSoakingPhysical(boolean soakingPhysical) { this.soakingPhysical = soakingPhysical; }
	public boolean isSoakingEnergy() { return this.soakingEnergy; }
	public void setSoakingEnergy(boolean soakingEnergy) { this.soakingEnergy = soakingEnergy; }
	public int getHpLeft() { return this.hpLeft; }
	public void setHpLeft(int hpLeft) { this.hpLeft = hpLeft; }
	public int getLevel() { return this.level; }
	public void setLevel(int level) { this.level = level; }
	public int getMaxHp() { return this.maxHp; }
	public void setMaxHp(int maxHp) { this.maxHp = maxHp; }
	//}}}


}
// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:
