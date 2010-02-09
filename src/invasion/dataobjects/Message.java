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
 *  Hold messages and retrieve them from the db
 */
public class Message  implements java.io.Serializable {

    public final static String KEY = Message.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}


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
    public static final int EFFECT = 4;

    public Message() {
    }

    public Message(int messageid) {
        this.messageid = messageid;
    }


    public Message(int id, Date messagedate, String message, int type, boolean read )
    {
        messageid = id;
        this.messagedate = messagedate;
        this.message = message;
        this.type = type;
        this.read = read;
    }


    public Message(int altid, int type, String message)
    {
        String query = "insert into messages (message, type, altid) values (?, ?, ?)";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        try{
            conn = new InvasionConnection();
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
            conn.close();
        }

    }

    public static JSONObject getInitialMessages(int altId)
    {
        String query = "select * from messages where read = true and altid = ? order by messageid desc limit 10";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Message> msgs = new ArrayList();
        try
        {
            conn = new InvasionConnection();
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
            conn.close();
        }
        JSONObject ret = new JSONObject();
        for(Message m : msgs)
        {
            try{
                ret.append("msgs", m.toJson());
            }
            catch(JSONException e)
            {
                throw new RuntimeException(e);
            }
        }
        return ret;
    }

    public JSONObject toJson()
        throws JSONException
    {
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd (EEE) HH:mm:ss Z");
        JSONObject ret = new JSONObject();
        ret.put("read", read);
        ret.put("type", type);
        ret.put("reps", reps);
        ret.put("text", message);
        ret.put("date", f.format(messagedate));
        return ret;
    }

    public int getMessageid() {
        return this.messageid;
    }

    public void setMessageid(int messageid) {
        this.messageid = messageid;
    }
    public Date getMessagedate() {
        return this.messagedate;
    }

    public void setMessagedate(Date messagedate) {
        this.messagedate = messagedate;
    }
    public String getMessage() {
        return this.message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}


