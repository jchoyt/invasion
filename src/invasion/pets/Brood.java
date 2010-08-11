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

    //{{{ Common class properties
    public final static int GOAL_SURVIVE = 0;
    public final static int GOAL_PROTECT = 1;
    public final static int GOAL_KILL_PSI = 2;
    public final static int GOAL_KILL_MUT = 3;
    public final static int GOAL_KILL_HUMAN = 4;
    protected List<Critter> members = null;
	protected Alt owner = null;
	protected int[] goals;
	protected int location = 0;
	//}}}

	//{{{ Constructors
	public Brood(int ownerid)
	{

	}
	//}}}

	//{{{ methods
	public void setGoal( int type, int value )
	{
	    if( value < 1 || value > 5 )
        {
            throw new RuntimeException( "Goals must be between 1 and 5, inclusive." );
        }
	    goals[type] = value;
	}

	/**
     *  Deploy the troops
     */
    public void combat()
    {
        List<Target> targets = new ArrayList<Target>();
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
                targets.add(new Target(rs));
            }
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
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
        //rank targets.  Higher attractiveness for lower armor and them dishing out higher damage per "round"

        // max 3 brood members per target

        // figure out best way to defend brood owner
    }


	public void attack()
	{
	    float x = Constants.ARMOR_SOAK_PERCENT;
	}

	public void addMemeber(Critter newCritter)
	{
	    members.add(newCritter);
	}

	public void removeMember( Critter oldCritter)
	{
	    members.remove(oldCritter);
	}


	//}}}

    //{{{  Getters and Setters
    public List<Critter> getMembers() { return this.members; }
    public void setMembers(List<Critter> members) { this.members = members; }
	public Alt getOwner() { return this.owner; }
	public void setOwner(Alt owner) { this.owner = owner; }
	public int[] getGoals() { return this.goals; }
	public void setGoals(int[] goals) { this.goals = goals; }
    public int getLocation() { return this.location; }
	public void setLocation(int location) { this.location = location; }
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
