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

    /**
    * Get locid property.
    *
    *@return Locid property.
    */
    public int getLocid() {
        return this.locid;
    }

    /**
    * Set locid property.
    *
    *@param locid New locid property.
    */
    public void setLocid(int locid) {
        this.locid = locid;
    }

    /**
    * Get locidtype property.
    *
    *@return Locidtype property.
    */
    public int getLocidtype() {
        return this.locidtype;
    }

    /**
    * Set locidtype property.
    *
    *@param locidtype New locidtype property.
    */
    public void setLocidtype(int locidtype) {
        this.locidtype = locidtype;
    }

    /**
     * Get alt property.
     *
     *@return Alt property.
     */
    public Alt getAlt() {
    	return this.alt;
    }

    /**
     * Set alt property.
     *
     *@param alt New alt property.
     */
    public void setAlt(Alt alt) {
    	this.alt = alt;
    }

    /**
     * Get lastTargetId property.
     *
     *@return LastTargetId property.
     */
    public int getLastTargetId() {
    	return this.lastTargetId;
    }

    /**
     * Set lastTargetId property.
     *
     *@param lastTargetId New lastTargetId property.
     */
    public void setLastTargetId(int lastTargetId) {
    	this.lastTargetId = lastTargetId;
    }

    /**
     * Get gui property.
     *
     *@return Gui property.
     */
    public GuiConfig getGui() {
    	return this.gui;
    }

    /**
     * Set gui property.
     *
     *@param gui New gui property.
     */
    public void setGui(GuiConfig gui) {
    	this.gui = gui;
    }






}
