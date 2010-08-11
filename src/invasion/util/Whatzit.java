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


    public void reload()
        throws SQLException
    {
        this.alt = Alt.load(alt.getId());
    }

    public void setLastTarget(int targetId)
    {
        this.lastTarget = Alt.load(targetId);
    }

    public void setAlt( Alt alt ) { this.alt=alt; }
    public Alt getAlt() { return this.alt; }
    public GuiConfig getGui() { return this.gui; }
    public Alt getLastTarget() { return this.lastTarget; }
    public void setGui(GuiConfig gui) { this.gui = gui; }
 }
