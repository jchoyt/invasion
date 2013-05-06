package invasion.util;

import invasion.dataobjects.Alt;
import invasion.dataobjects.Effects;
import invasion.dataobjects.Item;
import invasion.dataobjects.Message;
import invasion.dataobjects.Skills;
import invasion.dataobjects.Tikkun;
import invasion.dataobjects.Tohu;
import invasion.ui.NaughtyException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AltFactory
{
    public static final String KEY = AltFactory.class.getName();
    public static final Logger log = Logger.getLogger( KEY );
    static
    { log.setLevel( Level.FINER ); }

    protected static Map<Integer, Alt> altCache = new ConcurrentHashMap();

    public static Alt load( InvasionConnection conn, int id )
    {
        if ( altCache.containsKey( Integer.valueOf( id ) ) )
        {
            log.finest( "Alt " + id + " returned from cache." );
            return ( Alt ) altCache.get( Integer.valueOf( id ) );
        }
        ResultSet rs = null;
        try
        {
            String query = "select a.name as charname, f.name as factionname, * from alt a join location l on (a.location = l.id) join factions f on (a.factionid = f.id) where a.id=?";
            rs = conn.psExecuteQuery( query, "Error loading char " + id, new Object[]
            { Integer.valueOf( id ) } );
            rs.next();
            int race = rs.getInt( "race" );
            Alt ret = null;
            switch ( race )
            {
                case 1:
                    log.finer( "Loading Human" );
                    ret = new Alt();
                    break;
                case 2:
                    log.finer( "Loading Tohu" );
                    ret = new Tohu();
                    break;
                case 3:
                    log.finer( "Loading Tikkun" );
                    ret = new Tikkun();
                    break;
                default:
                    log.finer( "Loading Human by default - race number unknown: " + race );
                    ret = new Alt();
            }

            ret.setName( rs.getString( "charname" ) );
            ret.setId( id );
            ret.setReload( rs.getBoolean( "autoreload" ) );
            ret.setLocation( rs.getInt( "location" ) );
            ret.setLocationType( rs.getInt( "typeid" ) );
            ret.setUsername( rs.getString( "username" ) );
            ret.setFaction( invasion.dataobjects.Faction.getFaction( rs.getInt( "factionid" ) ) );
            ret.setFactionrank( rs.getInt( "factionrank" ) );
            ret.setLevel( rs.getInt( "level" ) );
            ret.setLastHurtBy( rs.getInt( "lastHurtBy" ) );
            ret.setRace( race );
            ret.setHp( rs.getInt( "hp" ) );
            ret.setHpmax( rs.getInt( "hpmax" ) );
            ret.setHumanSkills( rs.getLong( "humanskill" ) );
            ret.setTohuSkills( rs.getLong( "tohuskill" ) );
            ret.setTikkunSkills( rs.getLong( "tikkunskill" ) );
            ret.setStation( rs.getInt( "station" ) );
            ret.setXp( rs.getInt( "xp" ) );
            ret.setCp( rs.getInt( "cp" ) );
            ret.setIp( rs.getInt( "ip" ) );
            ret.setAp( rs.getInt( "ap" ) );
            ret.setApmax( rs.getInt( "apmax" ) );
            ret.setTicksalive( rs.getInt( "ticksalive" ) );
            log.finer( "in AltFactory.load(), id is " + id );
            DatabaseUtility.close( rs );

            setSkillLevels( ret );

            loadEquippedItems( conn, ret );

            ret.getEffects().load( conn, id );

            altCache.put( Integer.valueOf( id ), ret );
            return ret;
        }
        catch ( SQLException e )
        {
            log.throwing( KEY, "looks like the player is messing with the inputs", e );
            throw new NaughtyException( e );
        }
        finally
        {
            DatabaseUtility.close( rs );
        }
    }

    public static void setSkillLevels( Alt ret )
    {
        if ( ret.getHumanSkills() > 0L )
        {
            if ( ( ret.getHumanSkills() & Skills.getValue( "Firearms 5" ).longValue() ) > 0L )
            { ret.setFirearmsAttackLevel(5 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Firearms 4" ).longValue() ) > 0L )
            { ret.setFirearmsAttackLevel(4 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Firearms 3" ).longValue() ) > 0L )
            { ret.setFirearmsAttackLevel(3 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Firearms 2" ).longValue() ) > 0L )
            { ret.setFirearmsAttackLevel(2 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Firearms 1" ).longValue() ) > 0L )
            {
                ret.setFirearmsAttackLevel(1 );
            }

            if ( ( ret.getHumanSkills() & Skills.getValue( "Melee 5" ).longValue() ) > 0L )
            { ret.setMeleeAttackLevel(5 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Melee 4" ).longValue() ) > 0L )
            { ret.setMeleeAttackLevel(4 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Melee 3" ).longValue() ) > 0L )
            { ret.setMeleeAttackLevel(3 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Melee 2" ).longValue() ) > 0L )
            { ret.setMeleeAttackLevel(2 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Melee 1" ).longValue() ) > 0L )
            {
                ret.setMeleeAttackLevel(1 );
            }

            if ( ( ret.getHumanSkills() & Skills.getValue( "Tinkerer 5" ).longValue() ) > 0L )
            { ret.setTinkererLevel(5 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Tinkerer 4" ).longValue() ) > 0L )
            { ret.setTinkererLevel(4 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Tinkerer 3" ).longValue() ) > 0L )
            { ret.setTinkererLevel(3 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Tinkerer 2" ).longValue() ) > 0L )
            { ret.setTinkererLevel(2 );
            }
            else if ( ( ret.getHumanSkills() & Skills.getValue( "Tinkerer 1" ).longValue() ) > 0L )
            {
                ret.setTinkererLevel(1 );
            }
        }

        if ( ret.getTohuSkills() > 0L )
        {
            Tohu tohu = ( Tohu ) ret;

            if ( ( tohu.getTohuSkills() & Skills.getValue( "Summoner 5" ).longValue() ) > 0L )
            { tohu.setSummonerLevel(5 );
            }
            else if ( ( tohu.getTohuSkills() & Skills.getValue( "Summoner 4" ).longValue() ) > 0L )
            { tohu.setSummonerLevel(4 );
            }
            else if ( ( tohu.getTohuSkills() & Skills.getValue( "Summoner 3" ).longValue() ) > 0L )
            { tohu.setSummonerLevel(3 );
            }
            else if ( ( tohu.getTohuSkills() & Skills.getValue( "Summoner 2" ).longValue() ) > 0L )
            { tohu.setSummonerLevel(2 );
            }
            else if ( ( tohu.getTohuSkills() & Skills.getValue( "Summoner 1" ).longValue() ) > 0L )
            {
                tohu.setSummonerLevel(1 );
            }
        }
        else if ( ret.getTikkunSkills() <= 0L )
        { }
    }

    public static Alt load( int id )
    {
        if ( altCache.containsKey( Integer.valueOf( id ) ) )
        {
            log.finest( "Alt " + id + " returned from cache." );
            return ( Alt ) altCache.get( Integer.valueOf( id ) );
        }

        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            return load( conn, id );
        }
        catch ( SQLException e )
        {
            log.throwing( KEY, "looks like the player is messing with the inputs", e );
            throw new NaughtyException( e );
        }
        finally
        {
            DatabaseUtility.close( conn );
        }
    }

    public static void clearCache()
    {
        altCache.clear();
    }

    public static Alt createNew( String username, String name, int station, int race )
    {
        Alt ret = new Alt();
        ret.setName(name);
        ret.setRace(race);
        ret.setStation(station);
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
            query = "insert into alt ( id, username, name, station, location ) values ( DEFAULT, ?,?,?,? )";
            conn.psExecuteUpdate( query, "Error creating the new character", username, name, station, loc );
            //get new ID
            query="select max(id) as id from alt";
            rs = conn.executeQuery( query );
            rs.next();
            ret.setId(rs.getInt( "id" ));

            query="insert into stats (select ?, statid from statstype)";
            conn.psExecuteUpdate( query, "Error entering stats for new alt", ret.getId() );

            if( race == 1 )
            {
                //human intro messages
                new Message( conn, ret.getId(), Message.NORMAL, "The space between the stars is black and cold. You've been there, in a sleep on the edge of death, for longer than you will ever be awake. Your old life is buried light years away and decades in the past. Whatever you came from, there's no going back.");
                new Message( conn, ret.getId(), Message.NORMAL, "Humanity never found an answer to easy space travel. As science progressed, the hyperdrives and breakthrough wormhole physics never materialized. In the end, mankind put its faith in cold reality. Where superluminal flight had escaped them, cryogenics did not. A man could survive for as long as his equipment did, and by this stage, the equipment could survive for a very long time.");
                new Message( conn, ret.getId(), Message.NORMAL, "Some travelers arrive at their end destination to find that the passage of decades or centuries has created a far different place than they expected. In the last few hours, as your body was pumped with the drugs that would fully revive it from the suspended animation it had been held in for so long, you struggled to remember the dreams you had directly before waking. You stare out the small portal in the airlock door, into the blackness that was your home for so long. The scientists say that you don't dream in cold sleep. Your experience speaks differently.");
                new Message( conn, ret.getId(), Message.NORMAL, "As you peer out the window, you recall the jumbled confusion of visions - one moment personal the next distant. A world with a sun a few shades redder than you remember. Unfamiliar plants surrounding a cave with dark shapes lurking in the shadows, out of sight. A black moon that seemed to turn a dark reddish color when you stared at it - when seen out of the corner of your eye, it almost seemed to slowly shift, as though its surface were some foul liquid instead of the rock you expect. It filled you with a quiet terror for reasons you can't understand. You remember hunting, being hunted, neither, both, all in a confusing swirl of memories that weren't yours.");
                new Message( conn, ret.getId(), Message.NORMAL, "Outside the window, the shuttle is already being dismantled for spare parts. With a final hiss of equalizing pressure, the airlock opens. Your new life has just begun. You turn around, and don't look back.");
            }
            //else this is fucked up

            //now new guy has a location, give them stuff
            new Item( conn, 26, ret.getId());
            new Item( conn, 26, ret.getId());
            new Item( conn, 28, ret.getId());
            new Item( conn, 28, ret.getId());
            new Item( conn, 28, ret.getId());
            new Item( conn, 28, ret.getId());
            new Item( conn, 34, ret.getId());
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
        ArrayList clothing = new ArrayList();
        String query = "select itemid, type, damagetype, name from item i join itemtype t on (i.typeid=t.typeid) where locid=? and equipped=true";
        ResultSet rs = null;
        try
        {
            rs = conn.psExecuteQuery( query, "Error message", new Object[]
            { Integer.valueOf( alt.getId() ) } );
            while ( rs.next() )
            {
                if ( ( rs.getString( "type" ).equals( "armor" ) ) && ( rs.getString( "damagetype" ).equals( "p" ) ) )
                {
                    alt.setEquippedArmor( Item.load( conn, rs.getInt( "itemid" ) ) );
                }
                else if ( ( rs.getString( "type" ).equals( "armor" ) ) && ( rs.getString( "damagetype" ).equals( "e" ) ) )
                {
                    alt.setEquippedShield( Item.load( conn, rs.getInt( "itemid" ) ) );
                }
                else if ( rs.getString( "type" ).equals( "wearable" ) )
                {
                    clothing.add( rs.getString( "name" ) );
                }
                else
                {
                    alt.setEquippedWeapon( Item.load( conn, rs.getInt( "itemid" ) ) );
                }
            }

            alt.setClothing( clothing );
            DatabaseUtility.close( rs );
        }
        catch ( SQLException e )
        {
            log.throwing( KEY, "a useful message", e );
            throw new RuntimeException( e );
        }
        finally
        {
            DatabaseUtility.close( rs );
        }
    }

    public static void uncache( int altid )
    {
        if ( altCache.keySet().contains( Integer.valueOf( altid ) ) )
        {
            Alt a = ( Alt ) altCache.get( Integer.valueOf( altid ) );
            a.update();
            altCache.remove( Integer.valueOf( altid ) );
        }
    }
}
