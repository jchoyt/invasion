/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import java.util.logging.Level;
import java.util.logging.Logger;
import invasion.util.*;
import java.sql.*;

public class Station
{

    public final static String KEY = Station.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    //{{{ Members
    //}}}

    //{{{ Constuctors
    //}}}

    //{{{ Methods
    public static int getRandomLocation(int station)
    {
        String query = "select * from location where typeid!=0 and station=? order by random() limit 1";
        InvasionConnection conn = null;
        ResultSet rs = null;
        int newloc = -1;
        try
        {
            conn = new InvasionConnection();
            rs = conn.psExecuteQuery( query, "Error location anything on station " + station, station );
            if(rs.next())
            {
                newloc = rs.getInt("id");
            }
            else
            {
                log.warning("Didn't find a location on in station " + station);
                throw new RuntimeException("Don't mess with the inputs.");
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
        return newloc;

    }
    //}}}

    //{{{ Getters and Setters
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

