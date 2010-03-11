package invasion.util;

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
    protected GuiConfig gui = null;
    protected int lastTargetId = 0;
    protected int locid = -1;
    protected int locidtype = -1;
    protected String equippedWeaponName = null;
    protected int equippedWeaponId = 0;


    /* Getters and setters */
    public Alt getAlt() { return this.alt; }
    public GuiConfig getGui() { return this.gui; }
    public int getLastTargetId() { return this.lastTargetId; }
    public int getLocid() { return this.locid; }
    public int getLocidtype() { return this.locidtype; }
    public void setAlt(Alt alt) { this.alt = alt; }
    public void setGui(GuiConfig gui) { this.gui = gui; }
    public void setLastTargetId(int lastTargetId) { this.lastTargetId = lastTargetId; }
    public void setLocid(int locid) { this.locid = locid; }
    public void setLocidtype(int locidtype) { this.locidtype = locidtype; }
    public int getEquippedWeaponId() { return this.equippedWeaponId; }
    public void setEquippedWeaponId(int equippedWeaponId) { this.equippedWeaponId = equippedWeaponId; }
    public String getEquippedWeaponName() { return this.equippedWeaponName; }
    public void setEquippedWeaponName(String equippedWeaponName) { this.equippedWeaponName = equippedWeaponName; }

 }
