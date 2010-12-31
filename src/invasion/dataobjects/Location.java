/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.HashSet;
import java.util.Set;
import org.json.*;
import invasion.util.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * Location generated by hbm2java
 */
public class Location  implements java.io.Serializable {

    //{{{ Logging
    public final static String KEY = Location.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}
    //}}}

    private int id;
    private int locationtype;
    private Integer station;
    private Integer level;
    private Integer x;
    private Integer y;
    private String name;
    private String description;
    private Set<Alt> alts = new HashSet<Alt>(0);

    //{{{ Constructors
    public Location() { }

    public Location(int id) {
        this.id = id; }
    //}}}

    //{{{ Methods
    /**
     * Returns all the occupants.  See Poll.fullPoll() for data format returned.
     * @see Poll.fullPoll()
     * @param
     * @return  JSONArray full of occupants
     *
     */
    public static JSONArray getOccupants(InvasionConnection conn, int locid, int you)
    {
        String query = "select * from alt where location = ? and id != ? and ticksalive > 0";
        // InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        JSONArray root = new JSONArray();
        try
        {
            // conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1,locid);
            ps.setInt(2,you);
            rs = ps.executeQuery();
            while(rs.next())
            {
                JSONObject obj = new JSONObject();
                obj.put("name", rs.getString("name"));
                obj.put("id", rs.getInt("id"));
                obj.put("level", rs.getInt("level"));
                obj.put( "hp", Alt.calcHpCategory( rs.getInt("hp"), rs.getInt("hpmax") ) );
                root.put(obj);
            }
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Error forming the message queue", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            // conn.close();
            return root;
        }
    }

    /**
     * Returns all the information about a location
     * @param
     * @return JSONObject with all known information about a location
     *
     */
    public static JSONObject getSummary(InvasionConnection conn, int locid)
    {
        String query = "select t.name as basetype, s.name as station, l.name as tilename, x, y, level, description, l.id as locid from location l join locationtype t on l.typeid=t.typeid join station s on l.station=s.id where l.id=?";
        ResultSet rs = null;
        JSONObject mainobj = new JSONObject();
        try
        {
            conn = new InvasionConnection();
            rs = conn.psExecuteQuery(query, "Error retrieving basic location information.", locid);
            if(rs.next())
            {
                mainobj.put("type", rs.getString("basetype"));
                mainobj.put("station", rs.getString("station"));
                mainobj.put("level", rs.getString("level"));
                mainobj.put("locid", rs.getString("locid"));
                mainobj.put("x", rs.getInt("x"));
                mainobj.put("y", rs.getInt("y"));
                mainobj.put("name", rs.getString("tilename"));
                mainobj.put("description", rs.getString("description"));
            }
            else
                return null;
            DatabaseUtility.close(rs);
            //TODO get items
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
            mainobj.toString();
            return mainobj;
        }
    }
    //}}}

    //{{{ Getters and Setters
    public int getId() { return this.id; }
    public void setId(int id) { this.id = id; }
    public int getLocationtype() { return this.locationtype; }
    public void setLocationtype(int locationtype) { this.locationtype = locationtype; }
    public Integer getStation() { return this.station; }
    public void setStation(Integer station) { this.station = station; }
    public Integer getLevel() { return this.level; }
    public void setLevel(Integer level) { this.level = level; }
    public Integer getX() { return this.x; }
    public void setX(Integer x) { this.x = x; }
    public Integer getY() { return this.y; }
    public void setY(Integer y) { this.y = y; }
    public String getName() { return this.name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return this.description; }
    public void setDescription(String description) { this.description = description; }
    public Set<Alt> getAlts() { return this.alts; }
    public void setAlts(Set<Alt> alts) { this.alts = alts; }
    //}}}


}
// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

