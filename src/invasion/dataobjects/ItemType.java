/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import invasion.util.*;
import java.sql.*;

public class ItemType{

    public final static String KEY = ItemType.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}

    protected int typeid = 0;
    protected int weight = 0;
    protected int capacity = 0;
    protected int damage = 0;
    protected boolean consumable = false;
    protected String name = null;
    protected String type = null;
    protected String damageType = null;
    protected boolean usesammo = false;


    protected static Map<Integer, ItemType> itemTypes = new HashMap<Integer, ItemType>();


    public ItemType(int typeid, int weight, int capacity, int damage,
             boolean consumable, String name, String type, String damageType, boolean usesammo){
        this.typeid = typeid;
        this.weight = weight;
        this.capacity = capacity;
        this.damage = damage;
        this.consumable = consumable;
        this.name = name;
        this.type = type;
        this.damageType = damageType;
        this.usesammo = usesammo;
    }

    public ItemType() { }

    public static void load()
    {
        String query = "select * from itemtype";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            ItemType type = null;
            while(rs.next())
            {
                type = new ItemType(rs.getInt("typeid"),
                rs.getInt("weight"),
                rs.getInt("capacity"),
                rs.getInt("damage"),
                rs.getBoolean("consumable"),
                rs.getString("name"),
                rs.getString("type"),
                rs.getString("damageType"),
                rs.getBoolean("usesammo"));
                itemTypes.put(rs.getInt("typeid"), type);
            }
            log.info("Loaded " + itemTypes.size() + " different item types.");
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Error pre-loading item type data", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            conn.close();
        }
    }

    public static ItemType getItemType( int typeid )
    {
        return itemTypes.get(typeid);
    }

    /* setters and getters */

	public boolean getUsesammo() { return this.usesammo; }
	public void setUsesammo(boolean usesammo) { this.usesammo = usesammo; }
    public int getTypeid() { return this.typeid; }
    public void setTypeid(int typeid) { this.typeid = typeid; }
    public int getWeight() { return this.weight; }
    public void setWeight(int weight) { this.weight = weight; }
    public int getCapacity() { return this.capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }
    public int getDamage() { return this.damage; }
    public void setDamage(int damage) { this.damage = damage; }
    public boolean isConsumable() { return this.consumable; }
    public void setConsumable(boolean consumable) { this.consumable = consumable; }
    public String getName() { return this.name; }
    public void setName(String name) { this.name = name; }
    public String getType() { return this.type; }
    public void setType(String type) { this.type = type; }
    public String getDamageType() { return this.damageType; }
    public void setDamageType(String damageType) { this.damageType = damageType; }



}
