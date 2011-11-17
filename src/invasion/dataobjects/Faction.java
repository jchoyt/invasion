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
    static{log.setLevel(Level.FINER);}
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

	public final static int AMMENITY1 = 1;
	public final static int AMMENITY2 = 2;
	public final static int AMMENITY3 = 4;
	public final static int AMMENITY4 = 8;
    //}}}

    //{{{ Constuctors

    /**
     * Loads a faction from the database.  Note the politics and flagsCaptured are done lazily.
     * @param
     * @return
     *
     */
    public static Faction load( InvasionConnection conn, int id )
    {
        String query = "select * from faction where id = ?";
        ResultSet rs = null;
        Faction ret = new Faction();
        try
        {
            rs = conn.psExecuteQuery(query, "Failure loading Faction " + id, id);
            while(rs.next())
            {

                //process
            }
            DatabaseUtility.close(rs);
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Failure loading Faction " + id, e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
        }
        return ret;
    }

    public static Faction load( int id )
    {
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            return load( conn, id );
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Failure loading Faction " + id, e);
            throw new NaughtyException(e);
        }
        finally
        {
            DatabaseUtility.close(conn);
        }
    }
    //}}}

    //{{{ Methods
    /**
     * Returns a textual list of the ammenities a faction has.  In essence this coverts from the encoded representation (long) to text suitable for display in the GUI.
     * @param
     * @return
     *
     */
    public List<String> getAmmenityText()
    {
        List<String> ret = new ArrayList<String>();
        //todo populate - needs the ammenitites defined somewhere in a lookup table that is pre-populated at server start time.
        return ret;
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

