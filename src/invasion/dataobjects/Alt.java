/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import invasion.pets.*;
import invasion.ui.NaughtyException;
import invasion.util.*;
import org.json.*;

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
    private Item equippedWeapon = null;
	protected Item equippedShield = null;
	protected Item equippedArmor = null;
    private boolean autoReload = true;
	protected int id = 0;
	protected String username = null;
	protected int xp = 0;
	protected int factionid = 0;
	protected int level = 0;
	protected int lastHurtBy = 0;
	protected int race = 0;
	protected long humanSkills = 0;
	protected long psiSkills = 0;
	protected long mutateSkills = 0;
	protected int firearmsAttackLevel = 0;
	protected boolean reload = false; //reload the GUI?
    protected List<String> skillsUsed = new ArrayList<String>();
	protected boolean equippedItemsLoaded = false;
	protected List<String> clothing = new ArrayList<String>();
	protected char gender = 'f';

    public final static int ENERGYPISTOL = 26;
    public final static int ENERGYPACK = 28;
    protected static Map<Integer, Alt> altCache = new HashMap<Integer, Alt>();

    //}}}

    //{{{ Methods
    public void unequipWeapon()
    {
        equippedWeapon = null;
    }


    /**
     *  decrements the AP by count
     */
    public void decrementAp( InvasionConnection conn, int count )
    {
        log.entering(KEY, "decrementAp");
        ap=ap-count;
        if( !update() )
            log.severe("Update failed");
        log.exiting(KEY, "decrementAp" );
    }

    /**
     * Convenience method for when you don't already have an InvasionConnection and you still want to kill the alt.  No real work should be done here.
     *
     * @param
     * @return
     *
     */
    public void kill()
    {
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            kill( conn );
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
        }
        finally
        {
            DatabaseUtility.close(conn);
        }
    }


    public boolean update( InvasionConnection conn )
    {
        log.entering(KEY, "update");
        String query = "update alt set ap=?, ip=?, hp=?, xp=?, lasthurtby=?, location=? where id=?";
        int count = conn.psExecuteUpdate(query, "Error updating brood in the database", ap, ip, hp, xp, lastHurtBy, location, id );
        log.finer("query done");
        if( count != 1 )
        {
            log.warning( "Character " +  id + " not updated");
            return false;
        }
        else
            return true;
    }

    public boolean update( )
    {
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            return update( conn );
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            return false;
        }
        finally
        {
            DatabaseUtility.close(conn);
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

    //{{{ For Attacker interface
    public void insertMessage(String message, int type, InvasionConnection conn)
    {
        new Message(conn, id, type, message );
    }


   /**
    * Attack a target
    * @param
    * @return
    *
    */
   public JSONArray attack( Defender defender, InvasionConnection conn )
   {
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
            if( equippedWeapon == null )
            {
                //TODO check for other improvised weapon to use
                alerts = new JSONArray();
                log.finer("No weapon equipped");
                alerts.put( Poll.createErrorAlert("You must equip a weapon before attacking with it.") );
                return alerts;
            }

            if(equippedWeapon.getItemtype().getType().equals("weapon"))
            {
                if( equippedWeapon.getItemtype().getUsesammo() )
                {
                    // //firearms
                    // if( ammo <= 0 )
                    // {
                    //     alerts = new JSONArray();
                    //     alerts.put( Poll.createErrorAlert("There is no ammunition left in your equipped weapon.") );
                    //     return alerts;
                    // }
                    attackWithFirearm( conn, defender );
                }
                else
                {
                    //melee weapon
                    attackWithMelee( conn, defender );
                }
            }

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
     * Attack with a melee weapon
     * @param
     * @return
     *
     */
    public void attackWithMelee( InvasionConnection conn, Defender defender )
        throws SQLException
    {

    }

    /**
     * Fire gun
     * @param
     * @return
     *
     */
    protected void attackWithFirearm(InvasionConnection conn, Defender defender)
        throws SQLException
    {
        int apIncrement = 1;
        int attackLevel = firearmsAttackLevel;
        int damageBounus = 0;
        int damageMultiplier = 1;
        int shots = 1;
        //calc damage bonus
        if( ( humanSkills & Skills.getValue(Skill.FIREARMS1) ) > 0 ) damageBounus += 2;
        if( ( humanSkills & Skills.getValue(Skill.FIREARMS2) ) > 0 ) damageBounus += 3;
        if( ( humanSkills & Skills.getValue(Skill.FIREARMS3) ) > 0 ) damageBounus += 4;
        if( ( humanSkills & Skills.getValue(Skill.FIREARMS4) ) > 0 ) damageBounus += 5;
        if( ( humanSkills & Skills.getValue(Skill.FIREARMS5) ) > 0 ) damageBounus += 6;
        if( skillsUsed.contains( Skill.DOUBLE_SHOT ) && ( humanSkills & Skills.getValue(Skill.FIREARMS4) ) > 0 )
        {
            attackLevel = firearmsAttackLevel - 1;
            shots++;
        }
        else if( skillsUsed.contains( Skill.KILL_SHOT ) && ( humanSkills & Skills.getValue(Skill.FIREARMS5) ) > 0 )
        {
            if( Math.random() < 0.25 )
                damageMultiplier = 5;
            apIncrement = 3;
        }
        for(int i = 0; i < shots; i++)
        {
            equippedWeapon.setAmmoleft( equippedWeapon.getAmmoleft() - 1 );
            //check if reload necessary
            if( equippedWeapon.getAmmoleft() < 1 )
            {
                //TODO:  check for ammo
                log.finer("reloading");
                int capacity = equippedWeapon.getItemtype().getCapacity();
                if( (humanSkills & Skills.getValue(Skill.FIREARMS3)) > 0  )
                {
                    capacity *= 2;
                }
                equippedWeapon.setAmmoleft( capacity );
                new Message( conn, id, Message.NORMAL, "Your weapon is out of ammunition.  You reload your weapon." );
                apIncrement++;
            }
            equippedWeapon.update(conn);
            // check if you hit
            double attackChance = Skills.calculateAttackChance( equippedWeapon.getItemtype().getAccuracy(), attackLevel, defender.getDodgeLevel() );
            if( Math.random() < attackChance )
            {
                //hit;
                int damage = ( equippedWeapon.getItemtype().getDamage() + damageBounus ) * damageMultiplier;
                CombatResult result = defender.hit( this, damage, equippedWeapon.getItemtype().getDamageType(), conn, true );
                StringBuilder ret = new StringBuilder( "You attack " + defender.getName() + " with your " + equippedWeapon.getItemtype().getName() );
                ret.append( " and deal " + result.getDamageDone() + " points of damage.");
                if( result.getArmorSoak() > 0 )
                    ret.append( " Your victim's armor soaked " + result.getArmorSoak()  + " points." );
                if( result.getShieldSoak() > 0 )
                    ret.append( " Your victim's shields soaked " + result.getShieldSoak()  + " points." );
                ret.append( " You earned " + result.getDamageDone() +" XP.");
                new Message( conn, id, Message.NORMAL, ret.toString());
                for(String msg : result.getAttackerMessages())
                    new Message( conn, id, Message.NORMAL, msg );
                xp = xp + result.getDamageDone();
                update(conn);
                Stats.addChange(id, Stats.DAMDONE, result.getDamageDone());
            }
            else
            {
                //miss
                new Message( conn, id, Message.NORMAL, "You attack " + defender.getName() + " with your "  + equippedWeapon.getItemtype().getName() + " and miss.");
                defender.insertMessage(name + " attacked you with a "  + equippedWeapon.getItemtype().getName() + " and missed.", Message.NORMAL, conn);
            }
            //check if defender dead - if so stop here
            if( defender.getHp() < 1 )
                break;
            //if attacker is dead, stop here
            if(hp < 1)
                break;
            defender.notifyAttacked( this, conn );
        }
        decrementAp(conn, apIncrement);
    }
    //}}}

    //{{{ For Defender interface
    public CombatResult hit( Attacker attacker, int rawAmount, char damagetype, InvasionConnection conn, boolean updateNow ) throws SQLException
    {
        CombatResult ret = new CombatResult(rawAmount);
        //check if armor or shileds have any left
        Item armor = getEquippedArmor();
        Item shield = getEquippedShield();
        log.finer( String.valueOf(armor) );
        log.finer( String.valueOf(shield) );
        log.finer( Character.toString(damagetype) );
        if( damagetype == 'p' && armor != null && armor.getAmmoleft() > 0)
        {
            int maxSoak = (int)(0.75 * rawAmount);
            if( maxSoak > armor.getAmmoleft() )
            {
                ret.setArmorSoak( armor.getAmmoleft() );
                armor.setAmmoleft( 0 );
            }
            else
            {
                ret.setArmorSoak( maxSoak );
                armor.setAmmoleft( armor.getAmmoleft() - maxSoak );
            }
            armor.update(conn);
        }
        else if( damagetype == 'e' && shield != null && shield.getAmmoleft() > 0)
        {
            int maxSoak = (int)(0.95 * rawAmount);
            if( maxSoak > shield.getAmmoleft() )
            {
                ret.setShieldSoak( shield.getAmmoleft() );
                shield.setAmmoleft( 0 );
            }
            else
            {
                ret.setShieldSoak( maxSoak );
                shield.setAmmoleft( shield.getAmmoleft() - maxSoak );
            }
            shield.update(conn);
        }

        log.finer( name + " hit for " + ret.getDamageDone() + " dp by " + attacker.getName() );
        hp = hp - ret.getDamageDone();
        lastHurtBy = attacker.getId();
        Stats.addChange(id, Stats.DAMTAKEN, ret.getDamageDone());
        String defenderMessage = attacker.getName() + " attacked you and dealt " + ret.getDamageDone() + " points of damage.";
        if( ret.getArmorSoak() > 0 ) defenderMessage = defenderMessage + "  Your armor soaked " + ret.getArmorSoak()  + " points.";
        if( ret.getShieldSoak() > 0 ) defenderMessage = defenderMessage + "  Your shields soaked " + ret.getShieldSoak()  + " points.";
        insertMessage(defenderMessage, Message.NORMAL, conn);

        if( hp < 1 )
        {
            kill( conn );
            attacker.setReload(true);
        }
        else if( updateNow )
            update( conn );

        return ret;
    }

    public void notifyAttacked( Attacker attacker, InvasionConnection conn ){}

    /**
     *  um....kills off the character.  Sets time till respawn, updates the database, and removes the character from the cache.
     */
    public void kill(InvasionConnection conn)
    {
        int deathLoc = location;
        hp = 0;
        ip = 0;
        location = -57005;
        ap = ap - level;
        int killerid = lastHurtBy;
        lastHurtBy = 0;
        update( conn );
        String query = "update alt set ticksalive=0-level where id=?";
        conn.psExecuteUpdate( query, "err", id );
        LocationCache.decrementChars( deathLoc );

        // update victim's stat
        Stats.addChange( id, Stats.DEATHS, 1);
        if( killerid > 0 )
        {
            //TODO - make sure killerid is always a characdter....not a critter
            Alt killer = Alt.load( killerid );
            killer.setXp( killer.getXp() + level );

            //give kill message to attacker (and ding IP if appropriate)
            int ipHit = 0;
            if( race == killer.getRace() && race > 1)
            {
                ipHit = 10;
            }
            else if( race == 1 )
            {
                ipHit = 2;
            }
            String message = "You have landed the killing blow on " + name + ".  You have been awarded an additional " + level + " XP.";
            if( ipHit > 0 )
            {
                message = message + "  Your actions weigh on your consciousness, however (+" + ipHit + " IP).";
                killer.setIp( killer.getIp() + ipHit);
            }
            killer.update();
            Stats.addChange( killerid, Stats.KILLS, 1);
            new Message(conn, killerid, Message.NORMAL, message );

            //give victim death message
            new Message( conn, id, Message.NORMAL, killer.getName() + " has dealt you a death blow.  You feel the familiar tingle of your consciencousness being uploaded.  The station maintenance bots have removed your body for recycling.  A new body will be started for you soon." );
            //broadcast killer message
            Message.locationBroadcast( conn, deathLoc, Message.NORMAL, killer.getName() + " killed " + name + "!  This weighs heavily on you...so much death.  As the maintenance bots remove the body, you briefly wonder where the recycled material will end up.", killerid);
            //TODO IP adjust if others are of the same race (or faction?)
        }
        else
        {
            //death message with no killer
            new Message( conn, id, Message.SELF, "You have died.  You feel the familiar tingle of your consciencousness being downloaded.  The station maintenance bots have removed your body for recycling.  A new body will be started for you soon." );
            Message.locationBroadcast( conn, deathLoc, Message.NORMAL, name + " died.  Who the hell knows how this happens anymore?");
        }
        altCache.remove( id );
   }


   public int getDodgeLevel()
    {
        return 0;
    }

    public void decrementHp( int damage, Attacker attacker, InvasionConnection conn, boolean updateNow )
    {
        hp = hp - damage;
        if( hp < 1 )
            kill( conn );
        else
            if( updateNow )
                update();
    }
    //}}}

    //{{{ Loading Alts and Alt data
    /*
     *  Load from the database
     */
    public static Alt load( InvasionConnection conn, int id )
    {
        if( altCache.containsKey( id ) )
        {
            log.info( "Alt " + id + " returned from cache.");
            return altCache.get(id);
        }
        Alt ret = new Alt();
        ResultSet rs = null;
        try
        {
            String query = "select * from alt a join location l on (a.location = l.id) where a.id=?";
            rs = conn.psExecuteQuery( query, "Error loading char " + id, id);
            rs.next();
            ret.name = rs.getString("name");
            ret.id = id;
            ret.autoReload = rs.getBoolean("autoreload");
            ret.location = rs.getInt("location");
            ret.locationType = rs.getInt("typeid");
            ret.username = rs.getString("username");
            ret.factionid = rs.getInt("factionid");
            ret.level = rs.getInt("level");
            ret.lastHurtBy = rs.getInt("lastHurtBy");
            ret.race = rs.getInt("race");
            ret.hp = rs.getInt("hp");
            ret.humanSkills = rs.getLong("humanskill");
            ret.psiSkills = rs.getLong("psiskill");
            ret.mutateSkills = rs.getLong("mutateskill");
            ret.xp = rs.getInt("xp");
            ret.cp = rs.getInt("cp");
            ret.ip = rs.getInt("ip");
            log.finer("in Alt.load(), id is " + id);
            DatabaseUtility.close(rs);

            /* Calculate human skill bonuses */
            if( ret.getHumanSkills() > 0 )
            {
                if( (ret.getHumanSkills() & Skills.getValue(Skill.FIREARMS5)) > 0 ) ret.firearmsAttackLevel = 5;
                else if( (ret.getHumanSkills() & Skills.getValue(Skill.FIREARMS4)) > 0 ) ret.firearmsAttackLevel = 4;
                else if( (ret.getHumanSkills() & Skills.getValue(Skill.FIREARMS3)) > 0 ) ret.firearmsAttackLevel = 3;
                else if( (ret.getHumanSkills() & Skills.getValue(Skill.FIREARMS2)) > 0 ) ret.firearmsAttackLevel = 2;
                else if( (ret.getHumanSkills() & Skills.getValue(Skill.FIREARMS1)) > 0 ) ret.firearmsAttackLevel = 1;
                //TODO - make this configurable
                if( (ret.getHumanSkills() & Skills.getValue(Skill.FIREARMS5)) > 0 ) ret.skillsUsed.add(Skill.KILL_SHOT);
            }

            /* load Items */
            loadEquippedItems( conn, ret );

            /* TODO load pets */

            altCache.put( id, ret );
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
            DatabaseUtility.close(conn);
        }
    }

    public static void clearCache()
    {
        altCache.clear();
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
            query = "select * from location where typeid=10 and station=? order by random() limit 1";
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
            new Message( conn, ret.id, Message.NORMAL, "Humanity never found an answer to easy space travel. As science progressed, the hyperdrives and breakthrough wormhole physics never materialized. In the end, mankind put its faith in cold reality. Where superluminal flight had escaped them, cryogenics did not. A man could survive for as long as his equipment did, and by this stage, the equipment could survive for a very long time.");
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
            DatabaseUtility.close(conn);
        }
    }

    protected static void loadEquippedItems( InvasionConnection conn, Alt alt )
    {
        alt.clothing = new ArrayList<String>();
        String query = "select itemid, type, damagetype, name from item i join itemtype t on (i.typeid=t.typeid) where locid=? and equipped=true";
        ResultSet rs = null;
        try
        {
            rs = conn.psExecuteQuery(query, "Error message", alt.id );
            while(rs.next())
            {
                if( rs.getString( "type" ).equals("weapon")  )
                {
                    alt.equippedWeapon = Item.load( conn, rs.getInt( "itemid" ) );
                }
                else if( rs.getString( "type" ).equals("armor") && rs.getString( "damagetype" ).equals( "p" )  )
                {
                    alt.equippedArmor = Item.load( conn, rs.getInt( "itemid" ) );
                }
                else if( rs.getString( "type" ).equals("armor") && rs.getString( "damagetype" ).equals( "e" )  )
                {
                    alt.equippedShield = Item.load( conn, rs.getInt( "itemid" ) );
                }
                else if( rs.getString( "type" ).equals("wearable")   )
                {
                    alt.clothing.add( rs.getString("name") );
                }
                else
                    log.severe("Something ... unusual ... has been equippeed on " + alt.name + " (id=" + alt.id + ").  It's a " + rs.getString("name") + " with the itemid " + rs.getInt("itemid") );
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

    /**
     *  stats: { "ip": 0, "hp":50, "xp": 9001, "ap": 50, "ticksalive": 190, "status": "drunk, dead, encumbered, no body, insane"},
     */
    public static JSONObject getStats( InvasionConnection conn, int altid )
    throws SQLException, JSONException
    {
        String query = "select hp, ip, ap, cp, level, xp, ticksalive from alt where id=?";
        ResultSet rs = conn.psExecuteQuery( query, "Error retrieving character stats", altid );
        JSONObject obj = new JSONObject();
        if(rs.next())
        {
            obj.put("hp", rs.getInt("hp"));
            obj.put("ap", rs.getInt("ap"));
            obj.put("ip", rs.getInt("ip"));
            obj.put("xp", rs.getInt("xp"));
            obj.put("cp", rs.getInt("cp"));
            obj.put("level", rs.getInt("level"));
            obj.put("ticksalive", rs.getInt("ticksalive"));
            if( rs.getInt( "hp" ) < 1 )
            {
                obj.put("reload", true);
            }
        }
        return obj;
    }


    /**
     * Saves alt current state and takes him out of the cache, forcing a reload
     * @param
     * @return
     *
     */
    public static void uncache( int altid )
    {
        if( altCache.keySet().contains( altid ) )
        {
            Alt a = altCache.get(altid);
            a.update();
            altCache.remove( altid );
        }
    }//}}}

    //{{{ Constructors
    private Alt() {}
    //}}}

    //{{{ Getters and Setters
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
    public int getIp() { return this.ip; }
    public void setIp(int ip) { this.ip = ip; }
    public int getHpmax() { return this.hpmax; }
    public void setHpmax(int hpmax) { this.hpmax = hpmax; }
    public Item getEquippedWeapon() { return equippedWeapon; }
    public void setEquippedWeapon(Item item) { equippedWeapon = item; }
    public Item getEquippedArmor(){return equippedArmor;}
    public void setEquippedArmor(Item item) { equippedArmor = item; }
    public Item getEquippedShield(){return equippedShield;}
    public void setEquippedShield(Item item) { equippedShield = item; }
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
    public long getHumanSkills() { return this.humanSkills; }
	public void setHumanSkills(long humanSkills) { this.humanSkills = humanSkills; }
	public long getPsiSkills() { return this.psiSkills; }
	public void setPsiSkills(long psiSkills) { this.psiSkills = psiSkills; }
	public long getMutateSkills() { return this.mutateSkills; }
	public void setMutateSkills(long mutateSkills) { this.mutateSkills = mutateSkills; }
    public int getFirearmsAttackLevel() { return this.firearmsAttackLevel; }
	public void setFirearmsAttackLevel(int firearmsAttackLevel) { this.firearmsAttackLevel = firearmsAttackLevel; }
    public boolean getReload() { return this.reload; }
    public void setReload( boolean reload) { this.reload = reload; }
    public List<String> getSkillsUsed() { return this.skillsUsed; }
    public List<String> getClothing() { return this.clothing; }
	public void setClothing(List<String> clothing) { this.clothing = clothing; }
    public char getGender() { return this.gender; }
	public void setGender(char gender) { this.gender = gender; }
    //}}}

}
// :wrap=none:noTabs=true:collapseFolds=1:maxLineLen=160:mode=java:tabSize=4:indentSize=4:noWordSep=_:folding=explicit:

