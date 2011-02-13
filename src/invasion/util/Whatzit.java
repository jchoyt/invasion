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
 *    Used as a cache to store frequently needed and static info when a user is logged in and connected to a character.
 */
public class Whatzit
{

    public final static String KEY = Whatzit.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}

    //{{{ Members
    protected Alt alt = null;
	protected int currentAltId = 0;
    protected GuiConfig gui = null;
    //}}}

    //{{{ Constuctors
    public Whatzit(int loggedInAltId)
    {
        currentAltId = loggedInAltId;
    }
    //}}}

    //{{{ Methods
    public void reload()
        throws SQLException
    {
        this.alt = Alt.load(currentAltId);
    }
    //}}}

    public Alt getAlt() { return this.alt; }

    //{{{ Getters and Setters
    public int getCurrentAltId() { return this.currentAltId; }
	public void setCurrentAltId(int currentAltId) { this.currentAltId = currentAltId; }
	public GuiConfig getGui() { return this.gui; }
    public void setGui(GuiConfig gui) { this.gui = gui; }
    //}}}
}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

