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

    public final static String KEY = Location.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}


    private int id;
    private int locationtype;
    private Integer station;
    private Integer level;
    private Integer x;
    private Integer y;
    private String name;
    private String description;
    private Set<Alt> alts = new HashSet<Alt>(0);

    public Location() { }


    public Location(int id) {
        this.id = id; }


    public static JSONArray getOccupants(InvasionConnection conn, int locid, int you)
    {
        String query = "select * from alt where location = ? and id != ? ";
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
            int hp;
            int hpmax;
            int hpPercent;
            while(rs.next())
            {
                JSONObject obj = new JSONObject();
                obj.put("name", rs.getString("name"));
                obj.put("id", rs.getInt("id"));
                obj.put("level", rs.getInt("level"));
                hp = rs.getInt("hp");
                hpmax = rs.getInt("hpmax");
                hpPercent = 100*hp/hpmax;
                if( hpPercent < 10 )
                    obj.put("hp", 4);
                else if( hpPercent < 25 )
                     obj.put("hp", 3 );
                else if( hpPercent < 50 )
                     obj.put("hp", 2 );
                else if( hpPercent < 99 )
                    obj.put("hp", 1 );
                else
                    obj.put("hp", 0 );
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




}


