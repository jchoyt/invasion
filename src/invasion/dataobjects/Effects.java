/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import java.util.Arrays;
import invasion.util.*;
import invasion.dataobjects.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;

public class Effects
{

    //{{{ Logging
    public final static String KEY = Effects.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    //}}}

    //{{{ Members
    private static final String[] names = { "Drunk", "Blacked Out", "Insane", "Healing" };
    public static final int DRUNK = 0;
    public static final int BLACKED_OUT = 1;
    public static final int INSANE = 2;
    public static final int HEALING = 3;
	protected int[] state = null;
    //}}}

    //{{{ Constuctors
    public Effects()
    {
        state = new int[names.length];
    }
    //}}}

    //{{{ Methods
    public String getEffectsString()
    {
        StringBuilder ret = new StringBuilder(  );
        for(int i = 0; i < names.length; i++)
        {
            if( state[i] > 0 )
            {
                ret.append( names[i] );
                ret.append( "(" );
                ret.append( state[i] );
                ret.append( ")" );
                ret.append( ", " );
            }
        }
        if( ret.length() == 0 )
        {
            return "";
        }
        return ret.substring( 0, ret.length() - 2 );
    }

    public int getDuration( int kind )
    {
        return state[kind];
    }

    public void increment( int kind, int amount )
    {
        state[kind] += amount;
        if( state[kind] < 0 )
        {
            state[kind] = 0;
        }
    }

    public void load( InvasionConnection conn, int altid )
    {
        Arrays.fill(state, 0);
        String query = "select * from effects where altid=?";
        ResultSet rs = null;
        try
        {
            rs = conn.psExecuteQuery(query, "Error message", altid );
            while(rs.next())
            {
                state[rs.getInt("effectid")] = rs.getInt("duration");
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

    public boolean update( InvasionConnection conn, int altid )
    {
        String query = "update effects set duration=? where altid=? and effectid=?";
        String query2 = "insert into effects (altid, effectid, duration ) values (?, ?, ?)";
        PreparedStatement ps = null;
        try
        {
            ps = conn.prepareStatement(query);
            for(int i = 0; i < names.length; i++)
            {
                if( state[i] == 0 )
                {
                    continue;
                }
                ps.setInt( 1, state[i] );
                ps.setInt( 2, altid );
                ps.setInt( 3, i );
                int count = ps.executeUpdate();
                if( count == 0 )
                {
                    //nothing there to update, need to do the insert
                    conn.psExecuteUpdate( query2, "Error inserting new status", altid, i, state[i] );
                }
            }
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            return false;
        }
        finally
        {
            DatabaseUtility.close(ps);
        }
        return true;
    }
    //}}}

    //{{{ Getters and Setters
	public int[] getState() { return this.state; }
	public void setState(int[] state) { this.state = state; }
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

