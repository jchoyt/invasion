/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.util;

import invasion.pets.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.*;
import org.json.*;
import invasion.dataobjects.*;
import invasion.util.*;
import java.sql.*;


public class Poll
{

    public final static String KEY = Poll.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    //static{log.setLevel(Level.FINER);}

    public Poll()
    {
    }

    protected static final String ERROR = buildErrorJson();

    private static String buildErrorJson()
    {
        JSONObject ret = new JSONObject();
        try
        {
            JSONObject error = new JSONObject();
            error.put("message", "There has been an error retrieving the status");
            error.put("type", "error");
            ret.put("announce", error);
        }
        catch (JSONException e)
        {
            return null;
        }
        return String.valueOf(ret);
    }

    public static void fullPoll(Writer out, Whatzit wazzit, JSONArray alerts)
    {
        InvasionConnection conn = null;
        try
        {
            conn =  new InvasionConnection();
            fullPoll(conn, out, wazzit, alerts);
        }
        catch(Exception e)
        {
            log.throwing( KEY, "Error occurred during polling", e);
            try {out.write(ERROR);} catch (Exception ee){};
            return;
        }
        finally
        {
            conn.close();
        }
    }

    public static void fullPoll(InvasionConnection conn, Writer out, Whatzit wazzit, JSONArray alerts)
    {
        log.entering(KEY, "fullPoll");
        long start = System.currentTimeMillis();
        log.finer(start+"");
        try
        {
            JSONObject ret = new JSONObject();
            //stats
            ret.put("stats", Alt.getStats(conn, wazzit.getAlt().getId() ) );
            log.finer( "Stats complete: " + (System.currentTimeMillis()-start) );
            //TODO: if char is dead, stop here so messages don't show up as read.
            //Inventory
            JSONArray items = Item.getItems(conn, wazzit.getAlt().getId() );
            if( items.length() > 0 )
            {
                ret.put("inv", items);
            }
            log.finer( "Items complete: " + (System.currentTimeMillis()-start) );
            //Messages (message pane)
            ret.put("msgs", Message.getInitialMessages(conn, wazzit.getAlt().getId() ) );
            //Occupants
            JSONArray occupants = Location.getOccupants(conn, wazzit.getAlt().getLocation(), wazzit.getAlt().getId() );
            if( occupants.length() > 0 )
            {
                ret.put("occs", occupants);
            }
            log.finer( "Occupants complete: " + (System.currentTimeMillis()-start) );
            //Announcements (errors, info)
            if( alerts != null && alerts.length() > 0)
            {
                ret.put("announce", alerts);
            }
            //critters
            JSONArray pets = Critter.petsAtLocation( wazzit.getAlt().getLocation() );
            if( pets.length() > 0 )
            {
                ret.put("pets", pets );
            }
            log.finer( "Pets complete: " + (System.currentTimeMillis()-start) );
            //loction details
            ret.put("location", Location.getSummary(conn, wazzit.getAlt()) );
            //items on the ground
            items = Item.getItems(conn, wazzit.getAlt().getLocation() );
            if( items.length() > 0 )
            {
                ret.put("ground", items);
            }
            log.finer( "Location items complete: " + (System.currentTimeMillis()-start) );
            log.finer( "Poll results: " + String.valueOf(ret));
            out.write(String.valueOf(ret));
        }
        catch(Exception e)
        {
            log.throwing( KEY, "Error occurred during polling", e);
            try {out.write(ERROR);} catch (Exception ee){};
            return;
        }
        log.finer("Exiting: " + (System.currentTimeMillis()-start));
    }

    public static void sendReloadCommand(Writer out)
    {
        try
        {
            JSONObject ret = new JSONObject();
            ret.put("reload", true );
            out.write(String.valueOf(ret));
        }
        catch(Exception e)
        {
            log.throwing( KEY, "Error occurred during polling", e);
            try {out.write(ERROR);} catch (Exception ee){};
            return;
        }
    }


    public static JSONObject createErrorAlert( String message )
    {
        try
        {
            JSONObject ret = new JSONObject();
            ret.put("type", "error");
            ret.put("message", message );
            return ret;
        }
        catch (JSONException e)
        {
            return null;
        }
    }

    public static JSONObject createInfoAlert( String message )
    {
        try
        {
            JSONObject ret = new JSONObject();
            ret.put("type", "info");
            ret.put("message", message );
            return ret;
        }
        catch (JSONException e)
        {
            return null;
        }
    }



    /*
     *  Sample data
{
    "msgs": [
        {
            "text": "You open the Vodka and start drinking.  All too soon, it's gone.",
            "reps": 4,
            "read": true,
            "date": "2011-07-28 (Thu) 21:57:05 -0400",
            "type": 0
        },
        {
            "text": "You open the Canned goods and  start eating.  It tastes horrible, but you must keep your strength up.",
            "reps": 1,
            "read": true,
            "date": "2011-07-28 (Thu) 21:57:06 -0400",
            "type": 0
        },
        {
            "text": "You pick up a Energy pack(empty) from the ground.",
            "reps": 1,
            "read": false,
            "date": "2011-07-28 (Thu) 22:09:16 -0400",
            "type": 0
        }
    ],
    "location": {
        "chalk": "Some message here.",
        "level": "1",
        "allowrecharage": "t",
        "locid": "1004213",
        "station": "Crescent",
        "name": "Strickland Energy and Energy Accessories",
        "type": "Power Distribution",
        "y": 36,
        "x": 36
    },
    "stats": {
        "hp": 53,
        "level": 8,
        "cp": 255,
        "ap": 44,
        "daysalive": 0,
        "xp": 1294,
        "ticksalive": 6,
        "ip": 0
    },
    "inv": [
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 2522,
            "type": "ammo",
            "wt": "1"
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 2426,
            "type": "ammo",
            "wt": "1"
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 2509,
            "type": "ammo",
            "wt": "1"
        },
        {
            "ammoleft": 0,
            "condition": "Battered",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 2439,
            "type": "ammo",
            "wt": "1"
        },
        {
            "ammoleft": 0,
            "condition": "Operational",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 2405,
            "type": "ammo",
            "wt": "1"
        },
        {
            "ammoleft": 0,
            "condition": "To spec",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 2411,
            "type": "ammo",
            "wt": "1"
        },
        {
            "ammoleft": 0,
            "condition": "Operational",
            "hidden": false,
            "name": "Energy pack(empty)",
            "typeid": 49,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 2355,
            "type": "ammo",
            "wt": "1"
        },
        {
            "ammoleft": 50,
            "condition": "To spec",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": true,
            "damagetype": "e",
            "itemid": 2319,
            "type": "armor",
            "wt": "3"
        },
        {
            "ammoleft": 18,
            "condition": "Battered",
            "hidden": false,
            "name": "Riot armor",
            "typeid": 36,
            "capacity": 100,
            "equipped": false,
            "damagetype": "p",
            "itemid": 2523,
            "type": "armor",
            "wt": "15"
        },
        {
            "ammoleft": 37,
            "condition": "To spec",
            "hidden": false,
            "name": "Riot armor",
            "typeid": 36,
            "capacity": 100,
            "equipped": false,
            "damagetype": "p",
            "itemid": 2528,
            "type": "armor",
            "wt": "15"
        },
        {
            "ammoleft": 96,
            "condition": "To spec",
            "hidden": false,
            "name": "Riot armor",
            "typeid": 36,
            "capacity": 100,
            "equipped": true,
            "damagetype": "p",
            "itemid": 2292,
            "type": "armor",
            "wt": "15"
        },
        {
            "ammoleft": 20,
            "condition": "Operational",
            "hidden": false,
            "name": "Energy pistol",
            "typeid": 26,
            "capacity": 10,
            "equipped": false,
            "damagetype": "e",
            "itemid": 2532,
            "type": "weapon",
            "wt": "3"
        },
        {
            "ammoleft": 20,
            "condition": "To spec",
            "hidden": false,
            "name": "Energy pistol",
            "typeid": 26,
            "capacity": 10,
            "equipped": true,
            "damagetype": "e",
            "itemid": 2347,
            "type": "weapon",
            "wt": "3"
        }
    ]
}     *
     */
}
