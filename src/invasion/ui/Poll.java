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
     *  {
     *      "msgs": [
     *          {
     *              "text": "You attack Dalek323 with your Energy pistol and miss.",
     *              "reps": 1,
     *              "read": true,
     *              "date": "2010-11-15 (Mon) 18:29:02 -0500",
     *              "type": 0
     *          },
     *          {
     *              "text": "Dalek323 attacked you and missed.",
     *              "reps": 1,
     *              "read": true,
     *              "date": "2010-11-15 (Mon) 18:29:02 -0500",
     *              "type": 0
     *          },
     *          {
     *              "text": "You attack Dalek323 with your Energy pistol and miss.",
     *              "reps": 1,
     *              "read": true,
     *              "date": "2010-11-15 (Mon) 18:29:03 -0500",
     *              "type": 0
     *          },
     *          {
     *              "text": "Dalek323 attacked you and missed.",
     *              "reps": 1,
     *              "read": true,
     *              "date": "2010-11-15 (Mon) 18:29:03 -0500",
     *              "type": 0
     *          },
     *          {
     *              "text": "You attack Dalek323 with your Energy pistol and deal 5 points of damage.  You earned 5 XP.",
     *              "reps": 1,
     *              "read": true,
     *              "date": "2010-11-15 (Mon) 18:29:03 -0500",
     *              "type": 0
     *          },
     *          {
     *              "text": "Dalek323 attacked you and dealt 9 points of damage.",
     *              "reps": 1,
     *              "read": true,
     *              "date": "2010-11-15 (Mon) 18:29:03 -0500",
     *              "type": 0
     *          },
     *          {
     *              "text": "You have died.  You feel the familiar tingle of your consciencousness being downloaded.  The station maintenance bots have removed your body for recycling.  A new body will be started for you soon.",
     *              "reps": 1,
     *              "read": true,
     *              "date": "2010-11-15 (Mon) 18:29:03 -0500",
     *              "type": 1
     *          },
     *          {
     *              "text": "After some contemplation on your experiences, you have a major insight.  You have levelled up!",
     *              "reps": 1,
     *              "read": true,
     *              "date": "2010-11-15 (Mon) 18:30:00 -0500",
     *              "type": 4
     *          },
     *          {
     *              "text": "Your new body has been started.  It will be ready in approximately 3 tick(s).",
     *              "reps": 1,
     *              "read": true,
     *              "date": "2010-11-15 (Mon) 18:30:00 -0500",
     *              "type": 1
     *          },
     *          {
     *              "text": "You step out of the cloning chamber and look around with your new old eyes.  You see rows of identical chambers around the room.  Moving around experimentally, you determine everything appears to be as it should be.",
     *              "reps": 1,
     *              "read": true,
     *              "date": "2010-11-15 (Mon) 22:35:02 -0500",
     *              "type": 1
     *          },
     *          {
     *              "text": "You attack Dalek447 with your Energy pistol and miss.",
     *              "reps": 1,
     *              "read": false,
     *              "date": "2010-11-15 (Mon) 22:35:13 -0500",
     *              "type": 0
     *          },
     *          {
     *              "text": "Dalek447 attacked you and missed.",
     *              "reps": 1,
     *              "read": false,
     *              "date": "2010-11-15 (Mon) 22:35:13 -0500",
     *              "type": 0
     *          }
     *      ],
     *      "stats": {
     *          "hp": 50,
     *          "level": 3,
     *          "cp": 20,
     *          "ap": 21,
     *          "xp": 232,
     *          "ticksalive": 1,
     *          "ip": 0
     *      },
     *      "pets": [
     *          {
     *              "id": "447",
     *              "hp": 0,
     *              "name": "Dalek447"
     *          },
     *          {
     *              "id": "536",
     *              "hp": 0,
     *              "name": "Dalek536"
     *          }
     *      ],
     *      "inv": [
     *          {
     *              "ammoleft": 8,
     *              "condition": "Average",
     *              "hidden": false,
     *              "name": "Energy pack",
     *              "typeid": 28,
     *              "equipped": false,
     *              "itemid": 937,
     *              "type": "ammo",
     *              "wt": "2"
     *          },
     *          {
     *              "ammoleft": 2,
     *              "condition": "Broken",
     *              "hidden": false,
     *              "name": "Energy pistol",
     *              "typeid": 26,
     *              "equipped": true,
     *              "itemid": 938,
     *              "type": "weapon",
     *              "wt": "3"
     *          }
     *      ]
     *  }
     *
     */
}
