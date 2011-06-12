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
        String query = "update item set ammoleft=?, condition=? where itemid=?";
        ResultSet rs = null;
        int count = conn.psExecuteUpdate(query, "Error updating item in database", ammoleft, condition, itemid);
        if( count==0 )
        {
            log.severe("Failed to update item " + itemid );
        }
    }

    public Item(InvasionConnection conn, int itemtype, int locationid)
    {
        Item newItem = new Item();
        String query = "insert into item (typeid, locid, ammoleft, condition) values (?,?,?,?)";
        PreparedStatement ps = null;
        try
        {
            ps = conn.prepareStatement(query);
            ps.setInt(1,itemtype);
            ps.setInt(2,locationid);
            ps.setInt(3,(int)(Math.random() * ItemType.getItemType(itemtype).getCapacity()));
            ps.setInt(4,newItem.getCondition());
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
     *  Returns current inventory as a JSONArray.  See Poll.java for sample format.
     */
    public static JSONArray getItems( InvasionConnection conn, int locid )
    throws SQLException
    {
        String query = "select i.typeid, itemid, ammoleft, condition, name, type, hidden, equipped, weight, damagetype, capacity from item i join itemtype t on (i.typeid = t.typeid) where locid = ? order by type, name, ammoleft";
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
                obj.put("damagetype", rs.getString("damagetype"));
                obj.put("capacity", rs.getInt("capacity"));
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

    /**
     * @return  't' for true, 'f' for false.  Makes it easier to put into JSON than converting from a boolean.
     */
     public char canRepair()
     {
         if( itemtype.getType().equals("armor") || itemtype.getType().equals("weapon") )
             return 't';
         else
             return 'f';
     }

    /**
     * Add a defect appropriate to this item - it makes the change in the memory-based object and the database
     */
    public void addDefect(InvasionConnection conn)
    {
        //query to get a random defect
        //select id from modtype where type='b' or type='?' and fault=true order by random() limit 1;
        String query = "insert into itemmod (itemid, type) values ( ?, (select id from modtype where type='b' or type='?' and fault=true order by random() limit 1) );";
        try
        {
            int count = conn.psExecuteUpdate(query, "Error message", id, itemtype.getDamageType() );
            if( count == 0 )
            {
                throw new BotReportException( "Failed to add defect to item " + id, e );
            }
            //TODO do a range of messages for this
            new Message( conn, locid, Message.NORMAL, "As you work, you see something that didn't look quite right.  You review your notes, but it doesn't appear you did anything incorrectly." );

        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }

    }


    /* setters and getters */
    public Integer getLocid() { return this.locid; }
    public int getAmmoleft() { return this.ammoleft; }
    public int getCondition() { return this.condition; }
    public int getItemid() { return this.itemid; }
    public ItemType getItemtype() { return this.itemtype; }
    public void setAmmoleft(int x) { this.ammoleft = x; }
    public void setCondition(int x) { this.condition = x; }
    public void setItemid(int itemid) { this.itemid = itemid; }
    // public void setItemtype(int itemtype) { this.itemtype = itemtype; }
    public void setLocid(Integer locid) { this.locid = locid; }
    public boolean isEquipped() { return this.equipped; }
	public void setEquipped(boolean equipped) { this.equipped = equipped; }
	public boolean isHidden() { return this.hidden; }
	public void setHidden(boolean hidden) { this.hidden = hidden; }
	}


