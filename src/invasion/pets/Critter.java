/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.pets;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.*;
import invasion.util.*;
import invasion.dataobjects.*;

public class Critter implements Attacker, Defender
{
    public final static String KEY = Critter.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    //{{{ Constructors
    //}}}

    //{{{ Common class properties
    protected String description = null;
    protected String name = null;
    protected char damageType;
    protected static float attackAccuracy = 0.40f;
    protected static float defendAccuracy = 0.10f;
    protected int ap = 50;
    protected static int  apmax = 50;
    protected int armor = 50;
    protected static int armorMax = 50;
    protected static DiceRoller attackDamage = new DiceRoller("2d5");
    protected int cost = 10;
    protected int hp = 30;
    protected static int hpmax = 0;
    protected int id = 0;
    protected int lasthurtby = 0;
    protected int shield = 0;
    protected static int shieldMax = 0;
	protected Brood brood = null;
	protected int typeid = -1;
	protected int location = 0;
	protected static String[] deathKnells = { "You have landed the killing blow." };
    //}}}

    //{{{ Methods
    /**
     *  If this Critter gets control of a brood, what are his priorities?
     */
    public void setBroodGoals(){}

    public JSONObject toJson()
        throws JSONException
    {
        JSONObject obj = new JSONObject();
        obj.put("name", name);
        obj.put("id", id );
        obj.put("hp", Alt.calcHpCategory( hp, hpmax ) );
        return obj;

    }

    /**
     * Puts a new critter into the database and sets the  ID that's returned from the database.  Note this uses the critter database rather than the main one.
     * @param
     * @return
     *
     */
    public boolean insert()
    {
        String query = "insert into critters (brood, typeid, name, ap, hp,armor, shield) values (?,?,?,?,?,?,?)";
        InvasionConnection conn = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection( Brood.PETDB );
            conn.setAutoCommit(false);
            conn.psExecuteInsert(query, "Error adding new brood to the database", brood.getId(), typeid, name, ap, hp, armor, shield );
            //get the new brood id
            query="select max(id) as id from critters";
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

    public boolean update()
    {
        String query = "update critters set name=?, ap=?, hp=?, armor=?, shield=? where id=?";
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection( Brood.PETDB );
            int count = conn.psExecuteUpdate(query, "Error updating brood in the database", name, ap, hp, armor, shield, id );
            if( count != 1 )
            {
                log.warning( "Critter " +  id + " not updated");
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

    public static JSONArray petsAtLocation( int locid )
        throws JSONException
    {
        JSONArray ret = new JSONArray();
        String query = "select c.name, c.id, hp, hpmax from critters c join brood b on c.brood = b.id join crittertype t on t.id=c.typeid where b.location =?";
        InvasionConnection conn = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection( Brood.PETDB );
            rs = conn.psExecuteQuery(query, "Error message", locid);
            while(rs.next())
            {
                JSONObject obj = new JSONObject();
                obj.put("name", rs.getString("name"));
                obj.put("id", rs.getString("id") );
                obj.put("hp", Alt.calcHpCategory( rs.getInt("hp"), rs.getInt("hpmax") ) );
                ret.put(obj);
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

        return ret;
    }
    //}}}

    //{{{ For Defender interface
    public void insertMessage(String message, int type, InvasionConnection conn){}

    /**
     *
     * @param  conn - don't use - need to use the petdb.  This is the connection for the attacker
     * @return
     *
     */
    public int hit( Attacker attacker, int rawAmount, InvasionConnection conn ){
        log.finer( "Critter " + id + " getting hit for " + rawAmount + " damage." );
        int damageDone = rawAmount;
        //TODO apply soaks

        if( attacker instanceof Alt )
            lasthurtby = ((Alt)attacker).getId();
        else
            lasthurtby = 0;
        hp = hp - damageDone;

        if( hp < 1 )
        {
            die( conn, lasthurtby );
            attacker.setReload();
        }
        else
        {
            update();
        }
        return damageDone;
    }

    /**
     * Notify the defender that they've been attacked.  Allows for reprisals.
     *
     * @param
     * @return
     *
     */
    public void notifyAttacked( Attacker attacker, InvasionConnection conn )
    {
        Defender defender = (Defender) attacker;
        attack( defender, conn );
        //WARNING - this will cause an lethal loop of attacking and counter attacking if one pet attacks another
    }

    /**
     * Kills off a pet
     *
     * @param  conn Connection to use for attacker only (assuming it's a character)
     * @param  whodunnit The id of the last entity to attack
     * @return
     *
     */
    public void die(InvasionConnection conn, int whodunnit)
    {
        if( whodunnit > 0 )
        {
            String query = "update alt set xp=xp+10 where id=?";
            conn.psExecuteUpdate( query, "Error awarding killing XP and retrieving killer's race.", whodunnit );
            /*         This is for when we care about what kind of pet it was
            query = "select race, name from alt where id=?";
            rs = conn.psExecuteQuery( query, "Error awarding killing XP and retrieving killer's race.", whodunnit );
            int killerRace = 0;
            if( rs.next() )
            {
                killerRace = rs.getInt( 1 );
            }
            DatabaseUtility.close(rs);
            */
            //give kill message to attacker (and ding IP if appropriate)
            int ipHit = 2;
            // if( deadRace == killerRace && deadRace > 1)
            // {
            //     ipHit = 10;
            // }
            // else if( deadRace == 1 )
            // {
            //     ipHit = 2;
            // }
            String message = getRandomKillMessage() + "  You have been awarded an additional 10 XP.";
            if( ipHit > 0 )
            {
                message = message + "  As you view the remanants of your slaughter, your stomach churns (+" + ipHit + " IP).";
                query = "update alt set ip=ip+? where id=?";
                conn.psExecuteUpdate( query, "Error dinging IP", ipHit, whodunnit );
            }
            Stats.addChange( whodunnit, Stats.KILLS, 1);
            new Message(conn, whodunnit, Message.NORMAL, message );
            //TODO - broadcast the kill message

        }
        //remove it from the PET database
        String query = "delete from critters where id=" + id;
        InvasionConnection petConn = null;
        if( brood != null )
        {
            brood.removeMember( this );
            LocationCache.decrementCritters( brood.getLocation() );
        }
        try
        {
            petConn = new InvasionConnection();
            conn.executeUpdate(query);
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            petConn.close();
        }
    }

    public String getRandomKillMessage()
    {
        int i = (int)(Math.random() * deathKnells.length);
        return deathKnells[i];
    }
    //}}}

    //{{{ For Attacker interface
    public JSONArray attack(Defender defender, InvasionConnection conn ){
        /* check to see if the target ran off */
        try
        {
            // check if you hit
            if( Math.random() < attackAccuracy )
            {
                int dmg = attackDamage.roll();
                //TODO soaks
                defender.insertMessage(name + " attacked you and dealt " + dmg + " points of damage.", Message.NORMAL, conn);
                //X was absorbed by armor
                //Y was absorbed by shields
                String query = "update alt set hp = hp-?, lasthurtby=? where id=?";
                conn.psExecuteUpdate( query, "Error occurred while updating your victim's HP", dmg, getId(), defender.getId());  //TODO - getId should be  this the brood master's ID
                query = "select id from alt where hp < 1 and id=?";
                ResultSet rs = conn.psExecuteQuery( query, "Error occurred while updating your victim's HP", defender.getId() );
                if( rs.next() )
                {
                    System.out.println( " He's dead!");
                    Alt.kill( conn, defender.getId() );
                }
                //method should do all soaks and return final damage done
                Stats.addChange(id, Stats.DAMDONE, dmg);
                if( defender instanceof Alt )
                {
                    Stats.addChange(defender.getId(), Stats.DAMTAKEN, dmg);
                }
                DatabaseUtility.close(rs);
            }
            else
            {
                //miss
               defender.insertMessage(name + " attacked you and missed.", Message.NORMAL, conn);
            }
        }
        catch (Exception e)
        {
            log.throwing(KEY, "body", e);
        }
        finally
        {
            return null;
        }
    }

	public boolean getReload() { return false; }
	public void setReload() { }
    //}}}

    //{{{  Getters and setters
    public String getDescription() { return this.description; }
    public String getName() { return this.name; }
    public char getDamageType() { return this.damageType; }
    public float getAttackAccuracy() { return this.attackAccuracy; }
    public float getDefendAccuracy() { return this.defendAccuracy; }
    public int getAp() { return this.ap; }
    public int getApmax() { return this.apmax; }
    public int getArmor() { return this.armor; }
    public int getCost() { return this.cost; }
    public int getHp() { return this.hp; }
    public int getHpmax() { return this.hpmax; }
    public int getId() { return this.id; }
    public int getLasthurtby() { return this.lasthurtby; }
    public int getShield() { return this.shield; }
    public void setAp(int ap) { this.ap = ap; }
    public void setApmax(int apmax) { this.apmax = apmax; }
    public void setArmor(int armor) { this.armor = armor; }
    public void setAttackAccuracy(float attackAccuracy) { this.attackAccuracy = attackAccuracy; }
    public void setCost(int cost) { this.cost = cost; }
    public void setDamageType(char damageType) { this.damageType = damageType; }
    public void setDefendAccuracy(float defendAccuracy) { this.defendAccuracy = defendAccuracy; }
    public void setDescription(String description) { this.description = description; }
    public void setHp(int hp) { this.hp = hp; }
    public void setHpmax(int hpmax) { this.hpmax = hpmax; }
    public void setId(int id) { this.id = id; }
    public void setLasthurtby(int lasthurtby) { this.lasthurtby = lasthurtby; }
    public void setName(String name) { this.name = name; }
    public void setShield(int shield) { this.shield = shield; }
    public Brood getBrood() { return this.brood; }
	public void setBrood(Brood brood) { this.brood = brood; }
	public int getTypeid() { return this.typeid; }
	public void setTypeid(int typeid) { this.typeid = typeid; }
	public int getLocation() { return this.location; }
	public void setLocation(int location) { this.location = location; }
//}}}

}
// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:
