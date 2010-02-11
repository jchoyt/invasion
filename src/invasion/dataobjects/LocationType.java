package invasion.dataobjects;

import invasion.util.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.*;


/**
 * Primarily to load the default info at server startup so we don't have to keep looking it up.
 */
public class LocationType  implements java.io.Serializable {

    public final static String KEY = LocationType.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}


    protected int typeid  = -1;
    protected String name = null;
    protected String cssname = null;
    protected double searchrate = 0.2;

    protected static Map<Integer, LocationType> locationTypes = new HashMap<Integer, LocationType>();


    public LocationType() {}

    public LocationType(int typeid) { this.typeid = typeid; }

    public LocationType(int typeid, String name, String cssname, double searchrate) {
       this.typeid = typeid;
       this.name = name;
       this.cssname = cssname;
       this.searchrate = searchrate;
    }

    public static void load()
    {

        String query = "select * from locationtype";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            LocationType type = null;
            while(rs.next())
            {
                type = new LocationType(rs.getInt("typeid"),
                rs.getString("name"),
                rs.getString("cssname"),
                rs.getDouble("searchrate"));
                locationTypes.put(rs.getInt("typeid"), type);
            }
            log.info("Loaded " + locationTypes.size() + " different location types.");
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Error pre-loading location type data", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            conn.close();
        }
    }

    public static LocationType getLocationType( int typeid )
    {
        return locationTypes.get(typeid);
    }

    public int getTypeid() { return this.typeid; }
    public void setTypeid(int typeid) { this.typeid = typeid; }
    public String getName() { return this.name; }
    public void setName(String name) { this.name = name; }
    public String getCssname() { return this.cssname; }
    public void setCssname(String cssname) { this.cssname = cssname; }
    public double getSearchrate() { return this.searchrate; }
    public void setSearchrate( double r ) { this.searchrate = r; }
}


