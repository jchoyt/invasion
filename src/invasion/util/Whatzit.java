/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.util;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import invasion.dataobjects.*;
import invasion.ui.*;


/**
 *    Didn't know what to name this, so I searched for "terrible" in my wife's preschool library database.    Found a book called "Harry and the Terrible Whatzit"
 *    and dammit, that's a good name.
 *
 *    Used as a cache to store all the frequently needed and static info when a user is logged in and connected to a character.
 */
public class Whatzit
{

    public final static String KEY = Whatzit.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}

    protected Alt alt = null;
    protected Alt lastTarget = null;
    protected GuiConfig gui = null;
    protected int locid = -1;
    protected int locidtype = -1;
    protected int equippedWeaponId = 0;
    protected int equippedWeaponTypeId = 0;
    protected boolean ammoModNeeded = false;
    protected int ammo = 0;


    public void reload()
        throws SQLException
    {
        this.alt = new Alt( null,alt.getId(), false);
        setAlt( alt );
    }


    /* Getters and setters */
    public void setAlt(Alt alt)
        throws SQLException
    {
        this.alt = alt;
        locid = alt.getLocation();
        locidtype = alt.getLocationType();
        //set whether the equipped weapon uses ammunition or not
        InvasionConnection conn = new InvasionConnection();
        String query = "select * from item i join itemtype t on (i.typeid = t.typeid) where itemid=?";
        ResultSet rs = conn.psExecuteQuery( query, "Error connecting to " + alt.getId(), alt.getEquippedWeapon() );
        if(rs.next())
        {
            ammoModNeeded = rs.getBoolean( "usesammo" );
            ammo = rs.getInt("ammoleft");
            equippedWeaponTypeId = rs.getInt("typeid");
            equippedWeaponId = rs.getInt("itemid");
        }
        DatabaseUtility.close(rs);
        conn.close();
    }

    public void setLastTarget(int targetId)
    {
        this.lastTarget = new Alt(null, targetId, false);
    }


    public Alt getAlt() { return this.alt; }
    public GuiConfig getGui() { return this.gui; }
    public Alt getLastTarget() { return this.lastTarget; }
    public int getLocid() { return this.locid; }
    public int getLocidtype() { return this.locidtype; }
    public void setGui(GuiConfig gui) { this.gui = gui; }
    public void setLocid(int locid) { this.locid = locid; }
    public void setLocidtype(int locidtype) { this.locidtype = locidtype; }
    public int getEquippedWeaponId() { return this.equippedWeaponId; }
    public int getEquippedWeaponTypeId() { return this.equippedWeaponTypeId; }
    public void setEquippedWeaponTypeId(int id) { this.equippedWeaponTypeId = id; }
    public void setAmmoModNeeded(boolean needed) { this.ammoModNeeded = needed; }
    public boolean getAmmoModNeeded() { return ammoModNeeded; }
    public int getAmmo() { return this.ammo; }
    public void setAmmo(int ammo) { this.ammo = ammo; }
    public void decrementAmmo() { ammo--; }
 }
