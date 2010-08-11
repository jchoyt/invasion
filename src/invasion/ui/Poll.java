/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.util;

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
    // static{log.setLevel(Level.FINER);}

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
            JSONArray items = Item.getItems(conn, wazzit.getAlt().getId() );
            //Inventory
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
            if( alerts != null )
            {
                ret.put("announce", alerts);
            }
            //stats
            ret.put("stats", Alt.getStats(conn, wazzit.getAlt().getId() ) );
            log.finer( "Stats complete: " + (System.currentTimeMillis()-start) );
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
     *       {
     *        "msgs": [
     *            {  "who": "You", "msg": "test",  "date": "2010-01-08 21:00:00" },
     *            { "who": "EK",  "msg": "test2",  "date": "2010-01-08 21:00:01" } ] ,
     *        "occs":[
     *            {"id":9,"hp":0,"level":1,"name":"Test2"},
     *            {"id":10,"hp":0,"level":1,"name":"Test3"},
     *            {"id":1,"hp":0,"level":1,"name":"Uncle Purvy"},
     *            {"id":12,"hp":0,"level":1,"name":"asdf"} ],
     *        "inv": [
     *            { "ammoleft": 2, "condition": "Non-functional", "name": "Energy pack ", "typeid": 28, "itemid": 265, "type": "ammo" },
     *            { "ammoleft": 2, "condition": "Battered", "name": "Energy pack ", "typeid": 28, "itemid": 257, "type": "ammo" },
     *            { "ammoleft": 5, "condition": "Destroyed", "name": "Energy pack ", "typeid": 28, "itemid": 258, "type": "ammo" },
     *            { "ammoleft": 1, "condition": "Destroyed", "name": "Vodka", "typeid": 37, "itemid": 264, "type": "booze" },
     *            { "ammoleft": 2, "condition": "Destroyed", "name": "Vodka", "typeid": 37, "itemid": 259, "type": "booze" },
     *            { "ammoleft": 7, "condition": "Average", "name": "Vodka", "typeid": 37, "itemid": 268, "type": "booze" },
     *        stats: { "ip": 0, "hp":50, "XP": 9001, "AP": 50, "status": "drunk, dead, encumbered, no body, insane"},
     *        pets: [],
     *        announce: [
     *            { "type": "error", "message":"This is an error" },
     *            { "type": "info", "message":"This is for information" } ]
     *       }
     *
     */
}
