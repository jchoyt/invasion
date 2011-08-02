/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import invasion.util.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import org.json.*;

/**
 *  Create messages and retrieve them from the db
 */
public class Message  implements java.io.Serializable {

    public final static String KEY = Message.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}


    //{{{ Members
    private int messageid;
    private Date messagedate;
    private String message;
    private boolean read = false;
    private int type = 0;
    private int reps = 1;
    public static final int NORMAL = 0;
    public static final int SELF = 1;
    public static final int BROADCAST = 2;
    public static final int ETHERIAL = 3;
    public static final int EFFECT = 4; //}}}

    //{{{ Constructors
    public Message() {
    }

    public Message(int messageid) {
        this.messageid = messageid;
    }

    /**
     *  Do not use for creating new messages - only for grabbing new ones from the database
     */
    public Message(int id, Date messagedate, String message, int type, boolean read )
    {
        messageid = id;
        this.messagedate = messagedate;
        this.message = message;
        this.type = type;
        this.read = read;
    }

    /**
     *  Inserts a message into the database
     */
    public Message(InvasionConnection conn, int altid, int type, String message)
    {
        String query = "insert into messages (message, type, altid) values (?, ?, ?)";
        PreparedStatement ps = null;
        try{
            ps = conn.prepareStatement(query);
            ps.setString(1, message);
            ps.setInt(2, type);
            ps.setInt(3, altid);
            ps.executeUpdate();
        }
        catch(Exception e)
        {
            log.throwing(KEY, "constructor", e);
        }
        finally
        {
            DatabaseUtility.close(ps);
        }

    } //}}}

    //{{{ methods
    public static JSONArray getInitialMessages(InvasionConnection conn, int altId)
    {
        String query = "select * from messages where read = true and altid = ? order by messageid desc limit 10";
        // InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Message> msgs = new ArrayList();
        try
        {
            // conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1,altId);
            rs = ps.executeQuery();
            String lastMessage = "";
            while(rs.next())
            {
                String message = rs.getString("message");
                if( lastMessage.equals(message) )
                {
                    msgs.get(0).reps = msgs.get(0).reps + 1;
                }
                else
                {
                    lastMessage = message;
                    msgs.add(0, new Message( rs.getInt("messageid"), rs.getTimestamp("messagedate"), message, rs.getInt("type"), true));
                }
            }
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);

            if( msgs.size() > 0 )
            {
                lastMessage = msgs.get(msgs.size()-1).message;
            }
            query = "select * from messages where read = false and altid = ? order by messageid";
            lastMessage="";  //reset so new messages don't get combined with old ones.
            ps = conn.prepareStatement(query);
            ps.setInt(1,altId);
            //TODO set params here
            rs = ps.executeQuery();
            while(rs.next())
            {
                String message = rs.getString("message");
                if( lastMessage.equals(message) )
                {
                    msgs.get(msgs.size()-1).reps = msgs.get(msgs.size()-1).reps + 1;
                }
                else
                {
                    lastMessage = message;
                    msgs.add(new Message( rs.getInt("messageid"), rs.getTimestamp("messagedate"), message, rs.getInt("type"), false));
                }
            }
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            query = "update messages set read = true where altid = ? and read = false";
            ps = conn.prepareStatement(query);
            ps.setInt(1,altId);
            ps.executeUpdate();
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "Error forming the message queue", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            // conn.close();
        }
        JSONArray ret = new JSONArray();
        for(Message m : msgs)
        {
            try{
                ret.put(m.toJson());
            }
            catch(JSONException e)
            {
                throw new RuntimeException(e);
            }
        }
        return ret;
    }

    /**
     *  Inserts a message into the database for every character at the given location
     */
    public static void locationBroadcast(InvasionConnection conn, int locid, int type, String message)
    {
        String query = "insert into messages (message, type, altid) select ?, ?, id from alt where location=?";
        PreparedStatement ps = null;
        try{
            ps = conn.prepareStatement(query);
            ps.setString(1, message);
            ps.setInt(2, type);
            ps.setInt(3, locid);
            ps.executeUpdate();
        }
        catch(Exception e)
        {
            log.throwing(KEY, "constructor", e);
        }
        finally
        {
            DatabaseUtility.close(ps);
        }

    }

    /**
     *  Inserts a message into the database for every character at the given location except the one given
     */
    public static void locationBroadcast(InvasionConnection conn, int locid, int type, String message, int exceptAlt)
    {
        String query = "insert into messages (message, type, altid) select ?, ?, id from alt where location=? and id != ?";
        PreparedStatement ps = null;
        try{
            ps = conn.prepareStatement(query);
            ps.setString(1, message);
            ps.setInt(2, type);
            ps.setInt(3, locid);
            ps.setInt(4, exceptAlt);
            ps.executeUpdate();
        }
        catch(Exception e)
        {
            log.throwing(KEY, "constructor", e);
        }
        finally
        {
            DatabaseUtility.close(ps);
        }

    }

    /**
     *  Inserts a message into the database for every character who should be in the given station
     */
    public static void stationBroadcast(InvasionConnection conn, int station, int type, String message)
    {
        String query = "insert into messages (message, type, altid) select ?, ?, id from alt where station=?";
        PreparedStatement ps = null;
        try{
            ps = conn.prepareStatement(query);
            ps.setString(1, message);
            ps.setInt(2, type);
            ps.setInt(3, station);
            ps.executeUpdate();
        }
        catch(Exception e)
        {
            log.throwing(KEY, "constructor", e);
        }
        finally
        {
            DatabaseUtility.close(ps);
        }

    }

    public JSONObject toJson()
        throws JSONException
    {
        JSONObject ret = new JSONObject();
        ret.put("read", read);
        ret.put("type", type);
        ret.put("reps", reps);
        ret.put("text", message);
        ret.put("date", formatDate(messagedate));
        return ret;
    }

    protected String formatDate( Date messagedate )
    {
        String ret = null;
        // SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss z");
        //ret = f.format(messagedate);
        long now = System.currentTimeMillis();
        long diffInSec = ( now - messagedate.getTime() ) / 1000;
        if( diffInSec < 90 )
        {
            ret = diffInSec + " sec ago";
        }
        else if( diffInSec < 3000 )
        {
            ret = Math.round(diffInSec/60.0) + " min ago";
        }
        else if( diffInSec < 165600 ) // just under two days
        {
            ret = Math.round(diffInSec/3600.0) + " hr ago";
        }
        else if( diffInSec < 600000 ) //just under 7 days
        {
            ret = Math.round(diffInSec/86400.0) + " days ago";
        }
        else
        {
            ret = "long ago";
        }

        return ret;
    }//}}}

    //{{{ Getters and Setters
    public int getMessageid() { return this.messageid; }
    public void setMessageid(int messageid) { this.messageid = messageid; }
    public Date getMessagedate() { return this.messagedate; }
    public void setMessagedate(Date messagedate) { this.messagedate = messagedate; }
    public String getMessage() { return this.message; }
    public void setMessage(String message) { this.message = message; }
    //}}}


}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

