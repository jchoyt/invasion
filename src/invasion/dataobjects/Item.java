/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
import invasion.util.*;
import org.json.*;

/**
 *
 */
public class Item  implements java.io.Serializable {

    public final static String KEY = Item.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    private int itemid;
    private ItemType itemtype;
    private int locid;
    /**
     * Ammoleft is ammo for firearms and amount of armor/shields left for armor.
     */
    private int ammoleft = (int)(Math.random() * 10);
    /**
     * For enhancements - how to adjust the max on the item
     */
    private int capacitymod = 0;
	protected boolean equipped = false;
	protected boolean hidden = false;

    private int condition = (int)(Math.random() * 6);
    public static final String[] conditions = { "Destroyed", "Broken", "Battered", "Operational", "Average", "To spec" };

    private Item() {
    }

    public static Item load(InvasionConnection conn, int id)
    {
        Item i = new Item();
        String query = "select * from item i where itemid=?";
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();
            rs = conn.psExecuteQuery(query, "Error retrieving item from database", id);
            if(rs.next())
            {
                i.itemid = id;
                i.itemtype = ItemType.getItemType(rs.getInt("typeid"));
                i.ammoleft = rs.getInt("ammoleft");
                i.capacitymod = rs.getInt("capacitymod");
                i.condition = rs.getInt("condition");
                i.locid = rs.getInt("locid");
                i.equipped = rs.getBoolean("equipped");
                i.hidden = rs.getBoolean("hidden");
            }
            else
                return null;
            DatabaseUtility.close(rs);
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Error trying to retrieve item from the database", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            conn.close();
        }
        return i;
    }

    public void update(InvasionConnection conn)
    {
        String query = "update item set ammoleft=?, capacitymod=?, condition=? where itemid=?";
        ResultSet rs = null;
        int count = conn.psExecuteUpdate(query, "Error updating item in database", ammoleft, capacitymod, condition, itemid);
        if( count==0 )
        {
            log.severe("Failed to update item " + itemid );
        }
    }

    public Item(InvasionConnection conn, int itemtype, int locationid)
    {
        Item newItem = new Item();
        String query = "insert into item (typeid, locid, ammoleft, capacitymod, condition) values (?,?,?,?,?)";
        PreparedStatement ps = null;
        try
        {
            ps = conn.prepareStatement(query);
            ps.setInt(1,itemtype);
            ps.setInt(2,locationid);
            ps.setInt(3,(int)(Math.random() * ItemType.getItemType(itemtype).getCapacity()));
            ps.setInt(4,newItem.getCapacitymod());
            ps.setInt(5,newItem.getCondition());
            ps.execute();
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Exception creating item of type " + itemtype, e);
            throw new RuntimeException(e);
        }
        finally
        {
           DatabaseUtility.close(ps);
        }
    }

    /**
     *  Returns current inventory as a JSONArray.  Sample format:
     *      [
     *          { "ammoleft": 2, "condition": "Non-functional", "name": "Energy pack ", "typeid": 28, "itemid": 265, "type": "ammo" },
     *          { "ammoleft": 2, "condition": "Battered", "name": "Energy pack ", "typeid": 28, "itemid": 257, "type": "ammo" },
     *          { "ammoleft": 5, "condition": "Destroyed", "name": "Energy pack ", "typeid": 28, "itemid": 258, "type": "ammo" },
     *          { "ammoleft": 1, "condition": "Destroyed", "name": "Vodka", "typeid": 37, "itemid": 264, "type": "booze" },
     *          { "ammoleft": 2, "condition": "Destroyed", "name": "Vodka", "typeid": 37, "itemid": 259, "type": "booze" },
     *          { "ammoleft": 7, "condition": "Average", "name": "Vodka", "typeid": 37, "itemid": 268, "type": "booze" }
     *      ]
     *  TODO - add wt, hidden, and equipped to this
     */
    public static JSONArray getItems( InvasionConnection conn, int locid )
    throws SQLException
    {
        String query = "select i.typeid, itemid, ammoleft, condition, name, type, hidden, equipped, weight from item i join itemtype t on (i.typeid = t.typeid) where locid = ? order by type, name, ammoleft";
        PreparedStatement ps = null;
        ResultSet rs = null;
        JSONArray root = new JSONArray();
        try
        {
            ps = conn.prepareStatement(query);
            ps.setInt(1,locid);
            rs = ps.executeQuery();
            while(rs.next())
            {
                JSONObject obj = new JSONObject();
                obj.put("typeid", rs.getInt("typeid"));
                obj.put("itemid", rs.getInt("itemid"));
                obj.put("name", rs.getString("name"));
                obj.put("ammoleft", rs.getInt("ammoleft"));
                obj.put("condition", Item.conditions[rs.getInt("condition")]);
                obj.put("type", rs.getString("type"));
                obj.put("wt", rs.getString("weight"));
                obj.put("hidden", rs.getBoolean("hidden"));
                obj.put("equipped", rs.getBoolean("equipped"));
                root.put(obj);
            }
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Error retrieving Item list", e);
            throw e;
        }
        finally
        {
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            return root;
        }
    }

    public static JSONArray getItems( int locid )  //can also be altid
    {
        JSONArray ret = null;
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            ret = getItems( conn, locid );
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Error forming the message queue", e);
            throw new RuntimeException(e);
        }
        finally
        {
            conn.close();
            return ret;
        }
    }

    public static String getCategory( InvasionConnection conn, int itemid) throws SQLException
    {
        String query = "SELECT type from item i join itemtype t on (i.typeid = t.typeid) where itemid=?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1,itemid);
        ResultSet rs = ps.executeQuery();
        String ret = null;
        if(rs.next())
        {
            ret = rs.getString("type");
        }
        DatabaseUtility.close(rs);
        DatabaseUtility.close(ps);
        return ret;
    }

    public static String getName( InvasionConnection conn, int itemid) throws SQLException
    {
        String query = "SELECT name from item i join itemtype t on (i.typeid = t.typeid) where itemid=?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1,itemid);
        ResultSet rs = ps.executeQuery();
        String ret = null;
        if(rs.next())
        {
            ret = rs.getString("name");
        }
        DatabaseUtility.close(rs);
        DatabaseUtility.close(ps);
        return ret;
    }

    /* setters and getters */
    public Integer getLocid() { return this.locid; }
    public int getAmmoleft() { return this.ammoleft; }
    public int getCapacitymod() { return this.capacitymod; }
    public int getCondition() { return this.condition; }
    public int getItemid() { return this.itemid; }
    public ItemType getItemtype() { return this.itemtype; }
    public void setAmmoleft(int x) { this.ammoleft = x; }
    public void setCapacitymod(int x) { this.capacitymod = x; }
    public void setCondition(int x) { this.condition = x; }
    public void setItemid(int itemid) { this.itemid = itemid; }
    // public void setItemtype(int itemtype) { this.itemtype = itemtype; }
    public void setLocid(Integer locid) { this.locid = locid; }
    public boolean isEquipped() { return this.equipped; }
	public void setEquipped(boolean equipped) { this.equipped = equipped; }
	public boolean isHidden() { return this.hidden; }
	public void setHidden(boolean hidden) { this.hidden = hidden; }
	}


