/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import invasion.ui.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
import java.util.*;
import invasion.util.*;

public class Faction
{

    //{{{ Logging
    public final static String KEY = Faction.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}
    //}}}

    //{{{ Members
	protected String name = "Faction";
	protected int id = -1;
	protected String description = "We're a boring mess";
	protected int shloc = -1;
	protected int level = 0;
	protected int type = Constants.HUMAN;
	protected int prestige = 0;
	protected boolean open = true;
	protected Map<String,String> politics = null;
	protected List<String> flagsCaptured = null;
	protected long ammenities = 0;
	protected int station = 0;
	protected int createdby = 0;

	//TODO move these to Constants class
	public final static int AMMENITY1 = 1;
	public final static int AMMENITY2 = 2;
	public final static int AMMENITY3 = 4;
	public final static int AMMENITY4 = 8;

    private static Map<Integer, Faction> byId = new HashMap<Integer, Faction>();

    //}}}

    //{{{ Constuctors
    /**
     * Called at server startup to load up the factions from the database.  Note the politics and flagsCaptured are done lazily.
     *
     */
    public static void loadCache()
    {
        String query = "select * from factions";
        InvasionConnection conn = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();
            rs = conn.executeQuery(query);
            while(rs.next())
            {
                Faction f = new Faction();
                f.setId( rs.getInt("id"));
                f.setName(rs.getString("name"));
                f.type=rs.getInt("type");
                f.shloc = rs.getInt("shloc");
                f.level = rs.getInt("level");
                f.prestige = rs.getInt("prestige");
                f.open = rs.getBoolean("open");
                f.station = rs.getInt("station");
                f.ammenities = rs.getInt("ammenities");
                // f.cansetsh = rs.getInt("cansetsh"):
                f.description = rs.getString("description");
                f.createdby = rs.getInt("createdby");
                byId.put(f.id, f);
                log.finer("Loaded " + f.getName() );
            }
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Error initializing the faction list", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            conn.close();
        }
     }

    /**
     * Private to control faction creation to creating new and loading from the database.
     *
     */
    private Faction() {};

    public static Faction createNew( InvasionConnection conn, Alt creator, String name, String description )
    {
        Faction f = new Faction();
        f.name = name;
        /* check that the name isn't already used */
        String query = "select * from factions where name=?";
        ResultSet rs = null;
        try
        {
            conn.setAutoCommit(false);
            rs = conn.psExecuteQuery( query, "Error checking for duplicate faction name", name );
            if(rs.next())
            {
                throw new RuntimeException("That name is used.");
            }
            DatabaseUtility.close(rs);

            //all good - insert it to the database
            f.description = EscapeChars.forHTML( description );
            f.name = EscapeChars.forHTML( name );
            f.type = creator.getRace();
            f.station = creator.getStation();
            f.createdby = creator.getId();
            query = "insert into factions ( name, description, type, station, createdby ) values ( ?, ?, ?, ?, ? )";
            int count = conn.psExecuteUpdate(query, "Error message", f.name, f.description, creator.getRace(), creator .getStation(), creator.getId() );
            if( count != 1 )
            {
                throw new SQLException( "Faction creation failed.  Error creating the faction.");
            }
            query = "select last_value from faction_id_seq";
            rs = conn.psExecuteQuery( query, "Error retrieving the last faction id assigned" );
            if(rs.next())
            {
                f.id = rs.getInt( 1 );
            }
            else
            {
                log.severe( "On creating faction " + f.name + " the faction ID was not returned from the database and therefore the leader can't be set." );
            }
            DatabaseUtility.close(rs);

            byId.put(f.id, f);
            //set up the creator as a faction leader
            log.finer("Setting creator's faction id to " + f.id );
            creator.setFaction( Faction.getFaction(f.id) );
            creator.setFactionrank( Constants.FACTION_LEADER );
            if(!creator.update(conn))
            {
                throw new SQLException( "Faction creation failed.  Error updating the creating character as the faction leader.");
            }

            new Message( conn, creator.getId(), Message.NORMAL, f.name + " has been created.  Lead it well.");


            return f;
        }
        catch(SQLException e)
        {
            try{ conn.rollback(); } catch (Exception e2) {e2.printStackTrace(System.out);}
            log.throwing( KEY, "Faction creation failed.", e);
            throw new RuntimeException(e);
        }
        finally
        {
            try{ conn.commit(); } catch (Exception e2) {e2.printStackTrace(System.out);}
            DatabaseUtility.close(rs);
            conn.close();
        }
    }

    //}}}

    //{{{ Methods
    /**
     * Returns a textual list of the ammenities a faction has.  In essence this coverts from the encoded representation (long) to text suitable for display in the GUI.
     *
     */
    public List<String> getAmmenityText()
    {
        List<String> ret = new ArrayList<String>();
        //todo populate - needs the ammenitites defined somewhere in a lookup table that is pre-populated at server start time.
        return ret;
    }

    /**
     * Provide a way to get the faction object directly
     *
     */
    public static Faction getFaction(int id)
    {
        if( id == -1 )
        {
            return null;
        }
        return byId.get(id);
    }


    public boolean update( InvasionConnection conn )
    {
        log.entering(KEY, "update");
        String query = "update factions set description=?, ammenities=?, open=? where id=?";

        int count = conn.psExecuteUpdate( query, "Error updating faction in the database", description, ammenities, true, id );
        log.finer("query done");
        if( count != 1 )
        {
            log.warning( "Faction " +  id + " not updated");
            return false;
        }
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

    //}}}

    //{{{ Getters and Setters
	public String getName() { return this.name; }
	public void setName(String name) { this.name = name; }
	public int getId() { return this.id; }
	public void setId(int id) { this.id = id; }
	public String getDescription() { return this.description; }
	public void setDescription(String description) { this.description = description; }
	public int getShloc() { return this.shloc; }
	public void setShloc(int shloc) { this.shloc = shloc; }
	public int getLevel() { return this.level; }
	public void setLevel(int level) { this.level = level; }
	public int getType() { return this.type; }
	public void setType(int type) { this.type = type; }
	public int getPrestige() { return this.prestige; }
	public void setPrestige(int prestige) { this.prestige = prestige; }
	public boolean isOpen() { return this.open; }
	public void setOpen(boolean open) { this.open = open; }
	public void setPolitics(Map<String,String> politics) { this.politics = politics; }
	public void setFlagsCaptured(List<String> flagsCaptured) { this.flagsCaptured = flagsCaptured; }
	public long getAmmenities() { return this.ammenities; }
	public void setAmmenities(long ammenities) { this.ammenities = ammenities; }
    public int getStation() { return this.station; }
	public void setStation(int station) { this.station = station; }
	public int getCreatedby() { return this.createdby; }
	public void setCreatedby(int createdby) { this.createdby = createdby; }
	//TOD make these lazy retrieval
	public Map<String,String> getPolitics()
	{
	    throw new UnsupportedOperationException();
        // return this.politics;
    }
	public List<String> getFlagsCaptured()
	{
	    throw new UnsupportedOperationException();
	    // return this.flagsCaptured;
	}
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

