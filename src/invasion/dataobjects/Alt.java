/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import org.json.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.io.*;
import java.util.*;
import java.sql.*;
import invasion.util.*;
import invasion.ui.NaughtyException;

/**
 * Alt generated by hbm2java
 */
public class Alt implements java.io.Serializable, Attacker, Defender {

    //{{{ Logging
    public final static String KEY = Alt.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}
    //}}}

    //{{{ Members
    private int location=-1;
    private int locationType = -1;
    private String name;
    private int ap = 50;
    private int apmax = 50;
    private int ip = 0;
    private int cp = 0;
    private int hp = 50;
    private int hpmax = 50;
    private int speciality;
    private int equippedWeapon = -1;
    private boolean autoReload = true;
	protected int id = 0;
	protected String username = null;
	protected int xp = 0;
	protected int factionid = 0;
	protected int level = 0;
	protected int lastHurtBy = 0;
	protected int race = 0;
    protected ItemType equippedWeaponType = null;
	protected int ammo = 0;


    public final static int ENERGYPISTOL = 26;
    public final static int ENERGYPACK = 28;
    //}}}

    //{{{ Methods
    public void unequipWeapon()
    {
        equippedWeapon = -1;
    }


    /**
     *  decrements the AP by count
     */
    public void decrementAp( InvasionConnection conn, int count )
    {
        try
        {
            int updateCount = conn.executeUpdate( "update alt set ap=ap-" + count + " where id = " + id );
            // log.finer("update alt set ap=ap-" + count + " where id = " + id);
            if( updateCount < 1 )
            {
                throw new RuntimeException("No AP was decremented");
            }
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Error decrementing AP for character " + id, e);
            throw new RuntimeException(e);
        }
    }

    public void insertMessage(String message, int type, InvasionConnection conn)
    {
        new Message(conn, id, type, message );
    }

    public boolean soakingEnergy() { return false; }

    public boolean soakingPhysical() { return false; }

    public int hit( Attacker attacker, int rawAmount, InvasionConnection conn ) throws SQLException
    {
        String query = "update alt set hp = hp-?, lasthurtby=? where id=?";
        int damageDone = rawAmount;
        //TODO apply soaks

        conn.psExecuteUpdate( query, "Error occurred while updating your victim's HP", damageDone, attacker.getId(), id );
        Stats.addChange(id, Stats.DAMTAKEN, damageDone);
        query = "select id from alt where hp < 1 and id=?";
        ResultSet rs = conn.psExecuteQuery( query, "Error occurred while updating damage on the defender", id );
        if( rs.next() )
        {
            System.out.println( "He's dead!");
            Alt.kill( conn, id );
        }
        hp = hp - damageDone;
        return damageDone;
    }

    /**
     *  um....kills off the character
     */
    public static void kill(InvasionConnection conn, int alt)
        throws SQLException
    {
        String query = "select name, lasthurtby, race, level, location from alt where id = ?";  //add race to this
        ResultSet rs = conn.psExecuteQuery( query, "Error retrieving responsible party", alt );
        int whodunnit = 0;
        String name = null;
        int deadRace = 0;
        int level = -1;
        int deathLoc = -1;
        if(rs.next())
        {
            name = rs.getString( 1 );
            whodunnit = rs.getInt( 2 );
            deadRace = rs.getInt( 3 );
            level = rs.getInt( 4 );
            deathLoc = rs.getInt( 5 );
        }
        else
        {
            //error
            return;
        }
        DatabaseUtility.close(rs);
        query = "update alt set hp=0, ip=0, ticksalive=0-level, location=-57005, ap=ap-level where id=?";
        conn.psExecuteUpdate( query, "Error setting death", alt );

        // update victim's stat
        Stats.addChange( alt, Stats.DEATHS, 1);
        String killerName = null;
        log.finer( "Killer ID is " + whodunnit);
        if( whodunnit != 0 )
        {
            query = "update alt set xp=xp+? where id=?";
            conn.psExecuteUpdate( query, "Error awarding killing XP and retrieving killer's race.", level, whodunnit );
            query = "select race, name from alt where id=?";
            rs = conn.psExecuteQuery( query, "Error awarding killing XP and retrieving killer's race.", whodunnit );
            int killerRace = 0;
            if( rs.next() )
            {
                killerRace = rs.getInt( 1 );
                killerName = rs.getString( 2 );
            }
            DatabaseUtility.close(rs);

            //give kill message to attacker (and ding IP if appropriate)
            int ipHit = 0;
            if( deadRace == killerRace && deadRace > 1)
            {
                ipHit = 10;
            }
            else if( deadRace == 1 )
            {
                ipHit = 2;
            }
            String message = "You have landed the killing blow on " + name + ".  You have been awarded an additional " + level + " XP.";
            if( ipHit > 0 )
            {
                message = message + "  Your actions weigh on your consciousness, however (+" + ipHit + " IP).";
                query = "update alt set ip=ip+? where id=?";
                conn.psExecuteUpdate( query, "Error dinging IP", ipHit, whodunnit );
            }
            Stats.addChange( whodunnit, Stats.KILLS, 1);
            new Message(conn, whodunnit, Message.NORMAL, message );

            //give victim death message
            new Message( conn, alt, Message.NORMAL, killerName + " has dealt you a death blow.  You feel the familiar tingle of your consciencousness being uploaded.  The station maintenance bots have removed your body for recycling.  A new body will be started for you soon." );
        }
        else
        {
            //death message with no killer
            new Message( conn, alt, Message.SELF, "You have died.  You feel the familiar tingle of your consciencousness being downloaded.  The station maintenance bots have removed your body for recycling.  A new body will be started for you soon." );
        }
        /// TODO death message to others in the location
        ///use deathLoc
        // X has killed Y.  This weighs heavily on you...so much death.  As the maintenance bots remove the body, you briefly wonder where the recycled material will end up.  (+1/2IP unless opposite)

   }

   public JSONArray attack( Defender defender, InvasionConnection conn )
   {
       int apIncrement = 1;
       JSONArray alerts = null;
        /* check to see if the target ran off */
        try
        {
            if( location != defender.getLocation() )
            {
                log.finer("Defender no longer at the attacker's location");
                alerts = new JSONArray();
                alerts.put( Poll.createErrorAlert("Your target is no longer in the area.") );
                return alerts;
            }
            /* check to see if weapon is equipped */
            if( equippedWeapon == -1 || equippedWeapon == 0 )
            {
                alerts = new JSONArray();
                log.finer("No weapon equipped");
                alerts.put( Poll.createErrorAlert("You must equip a weapon before attacking with it.") );
                return alerts;
            }

            if(equippedWeaponType.getUsesammo())
            {
                //check if char has ammo
                if( ammo <= 0 )
                {
                    alerts = new JSONArray();
                    alerts.put( Poll.createErrorAlert("There is no ammunition left in your equipped weapon.") );
                    return alerts;
                }
                ammo--;  //TODO - adjust this in the database
                //check if reload necessary
                if( ammo == 0 )
                {
                    //TODO:  check for ammo
                    log.finer("reloading");
                    int capacity = equippedWeaponType.getCapacity();
                    String query = "update item i set ammoleft=? where itemid=?";
                    ammo = capacity;
                    int count = conn.psExecuteUpdate( query, "Error occured updating ammunition.", capacity, equippedWeapon );
                    new Message( conn, id, Message.NORMAL, "Your weapon is out of ammunition.  You reload your weapon." );
                    apIncrement++;
                } else {
                    log.finer("decrementing ammo");
                    String query = "update item set ammoleft=ammoleft-1 where itemid=?";
                    int count = conn.psExecuteUpdate( query, "Error occured updating ammunition.", equippedWeapon);
                }
            }

            // check if you hit
            if( Math.random() < 0.5 )
            {
                //hit
                //TODO soaks
                new Message( conn, id, Message.NORMAL, "You attack " + defender.getName() + " with your "  + equippedWeaponType.getName() + " and deal "+equippedWeaponType.getDamage()+" points of damage.  You earned "+equippedWeaponType.getDamage()+" XP.");
                defender.insertMessage(name + " attacked you with a "  + equippedWeaponType.getName() + " and dealt " + equippedWeaponType.getDamage() + " points of damage.", Message.NORMAL, conn);
                int damageDone = defender.hit( this, equippedWeaponType.getDamage(), conn );

                String query="update alt set xp=xp+? where id=?";
                conn.psExecuteUpdate( query, "Error awarding killing XP and retrieving killer's race.", damageDone, id );
                Stats.addChange(id, Stats.DAMDONE, damageDone);
            }
            else
            {
                //miss
                new Message( conn, id, Message.NORMAL, "You attack " + defender.getName() + " with your "  + equippedWeaponType.getName() + " and miss.");
               defender.insertMessage(name + " attacked you with a "  + equippedWeaponType.getName() + " and missed.", Message.NORMAL, conn);
            }
            decrementAp(conn, apIncrement);
            return null;
        }
        catch (Exception e)
        {
            log.throwing(KEY, "body", e);
            alerts = new JSONArray();
            alerts.put( Poll.createErrorAlert(e.getMessage()) );
            return alerts;
        }

    }

    /**
     * Calculates the HP circle that will show
     * @param
     * @return
     *
     */
    public static int calcHpCategory( int hp, int hpmax )
    {
        int hpPercent = 100*hp/hpmax;
        if( hpPercent < 10 )
            return 4;
        else if( hpPercent < 25 )
            return 3;
        else if( hpPercent < 50 )
            return 2;
        else if( hpPercent < 99 )
            return 1;
        else
            return 0;
    }
    //}}}

    //{{{ Loading Alts and Alt data
    /*
     *  Load from the database
     */
    public static Alt load( InvasionConnection conn, int id )
    {
        Alt ret = new Alt();
        ResultSet rs = null;
        try
        {
            String query = "select * from alt a join location l on (a.location = l.id) where a.id=?";
            rs = conn.psExecuteQuery( query, "Error loading char " + id, id);
            rs.next();
            ret.name = rs.getString("name");
            ret.id = id;
            ret.equippedWeapon=rs.getInt("equippedweapon");
            ret.autoReload = rs.getBoolean("autoreload");
            ret.location = rs.getInt("location");
            ret.locationType = rs.getInt("typeid");
            ret.username = rs.getString("username");
            ret.factionid = rs.getInt("factionid");
            ret.level = rs.getInt("level");
            ret.lastHurtBy = rs.getInt("lastHurtBy");
            ret.race = rs.getInt("race");
            ret.hp = rs.getInt("hp");
            log.finer("in Alt.load(), id is " + id);
            DatabaseUtility.close(rs);
            /* load equipped weapon */
            if( ret.equippedWeapon != 0 )
            {
                query = "select * from item i join itemtype t on (i.typeid = t.typeid) where itemid=?";
                rs = conn.psExecuteQuery( query, "Error connecting to " + id, ret.equippedWeapon );
                if(rs.next())
                {
                    int wid = rs.getInt("typeid");
                    ret.equippedWeaponType = ItemType.getItemType( wid );
                    ret.ammo = rs.getInt("ammoleft");
                }
                DatabaseUtility.close(rs);
            }
            /* TODO Load items */

            /* TODO load pets */
            return ret;
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "looks like the player is messing with the inputs", e);
            throw new NaughtyException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
        }
    }


    public static Alt load( int id )
    {
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            return load( conn, id );
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "looks like the player is messing with the inputs", e);
            throw new NaughtyException(e);
        }
        finally
        {
            conn.close();
        }
    }

    /**
     *  create a new character
     */
    public static Alt createNew( String username, String name, int speciality, int skill, int station )
    {
        Alt ret = new Alt();
        ret.name = name;
        ret.speciality = speciality;
        // check that the name isn't used
        String query = "select * from alt where name=?";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(query);
            ps.setString(1,name);
            rs = ps.executeQuery();
            if(rs.next())
            {
                throw new RuntimeException("that name is used.");
            }
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);

            // assign spawn location
            query = "select * from location where typeid=31 and station=? order by random() limit 1";
            ps = conn.prepareStatement(query);
            ps.setInt(1,station);
            rs = ps.executeQuery();
            int loc;
            if(rs.next())
            {
                loc = rs.getInt(1);
            }
            else
            {
                log.warning("Didn't find a cloning facility in station " + station);
                throw new RuntimeException("Don't mess with the inputs.");
            }
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);

            //get the next alt id


            // save him to the database
            query = "insert into alt ( id, username, name, station, location, speciality ) values ( DEFAULT, ?,?,?,?,? )";
            conn.psExecuteUpdate( query, "Error creating the new character", username, name, 0, loc, speciality );
            //get new ID
            query="select max(id) as id from alt";
            rs = conn.executeQuery( query );
            rs.next();
            ret.id = rs.getInt( "id" );

            query="insert into stats (select ?, statid from statstype)";
            conn.psExecuteUpdate( query, "Error entering stats for new alt", ret.id );

            //human intro messages
            new Message( conn, ret.id, Message.NORMAL, "The space between the stars is black and cold. You've been there, in a sleep on the edge of death, for longer than you will ever be awake. Your old life is buried light years away and decades in the past. Whatever you came from, there's no going back.");
            new Message( conn, ret.id, Message.NORMAL, "Humanity never found an answer to easy space travel. As science progressed, the hyperdrives and breakthrough wormhole physics never materialized. In the end, mankind put it's faith in cold reality. Where superluminal flight had escaped them, cryogenics did not. A man could survive for as long as his equipment did, and by this stage, the equipment could survive for a very long time.");
            new Message( conn, ret.id, Message.NORMAL, "Some travelers arrive at their end destination to find that the passage of decades or centuries has created a far different place than they expected. In the last few hours, as your body was pumped with the drugs that would fully revive it from the suspended animation it had been held in for so long, you struggled to remember the dreams you had directly before waking. You stare out the small portal in the airlock door, into the blackness that was your home for so long. The scientists say that you don't dream in cold sleep. Your experience speaks differently.");
            new Message( conn, ret.id, Message.NORMAL, "As you peer out the window, you recall the jumbled confusion of visions - one moment personal the next distant. A world with a sun a few shades redder than you remember. Unfamiliar plants surrounding a cave with dark shapes lurking in the shadows, out of sight. A black moon that seemed to turn a dark reddish color when you stared at it - when seen out of the corner of your eye, it almost seemed to slowly shift, as though its surface were some foul liquid instead of the rock you expect. It filled you with a quiet terror for reasons you can't understand. You remember hunting, being hunted, neither, both, all in a confusing swirl of memories that weren't yours.");
            new Message( conn, ret.id, Message.NORMAL, "Outside the window, the shuttle is already being dismantled for spare parts. With a final hiss of equalizing pressure, the airlock opens. Your new life has just begun. You turn around, and don't look back.");

            //now new guy has a location, give them stuff
            new Item( conn, ENERGYPISTOL, ret.id);
            new Item( conn, ENERGYPISTOL, ret.id);
            new Item( conn, ENERGYPACK, ret.id);
            new Item( conn, ENERGYPACK, ret.id);
            new Item( conn, ENERGYPACK, ret.id);
            new Item( conn, ENERGYPACK, ret.id);
            new Item( conn, ENERGYPACK, ret.id);
            new Item( conn, ENERGYPACK, ret.id);
            return ret;
        }
        catch(SQLException e)
        {
            try{ conn.rollback(); } catch (Exception e2) {e2.printStackTrace(System.out);}
            log.throwing( KEY, "Exception creating character " + name, e);
            throw new RuntimeException(e);
        }
        finally
        {
            try{ conn.commit(); } catch (Exception e2) {e2.printStackTrace(System.out);}
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            conn.close();
        }
    }

    /**
    *  stats: { "ip": 0, "hp":50, "xp": 9001, "ap": 50, "ticksalive": 190, "status": "drunk, dead, encumbered, no body, insane"},
     */
    public static JSONObject getStats( InvasionConnection conn, int altid )
    throws SQLException, JSONException
    {
        String query = "select hp, ip, ap, xp, ticksalive from alt where id=?";
        ResultSet rs = conn.psExecuteQuery( query, "Error retrieving character stats", altid );
        JSONObject obj = new JSONObject();
        if(rs.next())
        {
            obj.put("hp", rs.getInt("hp"));
            obj.put("ap", rs.getInt("ap"));
            obj.put("ip", rs.getInt("ip"));
            obj.put("xp", rs.getInt("xp"));
            obj.put("ticksalive", rs.getInt("ticksalive"));
        }
        return obj;
    } //}}}

    //{{{ Constructors
    private Alt() {}
    //}}}

    //{{{ Getters and Setters
	public ItemType getEquippedWeaponType() { return this.equippedWeaponType; }
	public void setEquippedWeaponType(ItemType equippedWeaponType) { this.equippedWeaponType = equippedWeaponType; }
    public int getLocation() { return this.location; }
    public void setLocation(int location) { this.location = location; }
    public String getName() { return this.name; }
    public void setName(String name) { this.name = name; }
    public int getAp() { return this.ap; }
    public void setAp(int ap) { this.ap = ap; }
    public int getApmax() { return this.apmax; }
    public void setApmax(int apmax) { this.apmax = apmax; }
    public int getCp() { return this.cp; }
    public void setCp(int cp) { this.cp = cp; }
    public int getHp() { return this.hp; }
    public void setHp(int hp) { this.hp = hp; }
    public int getHpmax() { return this.hpmax; }
    public void setHpmax(int hpmax) { this.hpmax = hpmax; }
    public void setEquippedWeapon(int item) { equippedWeapon = item; }
    public int getEquippedWeapon(){ return equippedWeapon; }
    public int getLocationType() { return this.locationType; }
    public void setLocationType(int locationType) { this.locationType = locationType; }
	public int getId() { return this.id; }
	public void setId(int id) { this.id = id; }
	public String getUsername() { return this.username; }
	public void setUsername(String username) { this.username = username; }
	public int getXp() { return this.xp; }
	public void setXp(int xp) { this.xp = xp; }
	public int getFactionid() { return this.factionid; }
	public void setFactionid(int factionid) { this.factionid = factionid; }
	public int getLevel() { return this.level; }
	public void setLevel(int level) { this.level = level; }
	public int getLastHurtBy() { return this.lastHurtBy; }
	public void setLastHurtBy(int lastHurtBy) { this.lastHurtBy = lastHurtBy; }
	public int getRace() { return this.race; }
	public void setRace(int race) { this.race = race; }
	public int getAmmo() { return this.ammo; }
	public void setAmmo(int ammo) { this.ammo = ammo; }
    //}}}

}
// :wrap=none:noTabs=true:collapseFolds=1:maxLineLen=160:mode=java:tabSize=4:indentSize=4:noWordSep=_:folding=explicit:

