/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.*;
import java.util.*;
import java.sql.*;
import invasion.util.*;
import invasion.ui.NaughtyException;


public class ActionLog {

    public static final String KEY = ActionLog .class.getName();
    public static final Logger log = Logger.getLogger(KEY);
    // static { log.setLevel(Level.FINER); }

    private static List<ActionRecord> queue = new ArrayList<ActionRecord>();

    //TODO read this directly from the DB
    private static final String[] names = { "entered", "said", "attacked", "killed", "wrote", "hacked", "smote" };
    public static final int ENTERED = 0;
    public static final int SAID = 1;
    public static final int ATTACKED = 2;
    public static final int KILLED = 3;
    public static final int WROTE = 4;
    public static final int HACKED = 5;
    public static final int SMOTE = 6;

    public static synchronized void addAction(int actor,int action, int subject)
    {
        queue.add(new ActionRecord( actor, action, subject ));
    }

    public static String getActionName( int index )
    {
        return names[index];
    }

    public static void writeLog( java.io.Writer out )
    {
        try{
            for(ActionRecord a : queue)
            {
                out.write( a.toString() );
                out.write( "\n" );
            }
        }
        catch (IOException e)
        {
            //do nothing
            log.throwing( KEY, "Error writing out stats log", e );
        }
    }

    public static void process( InvasionConnection conn )
        throws SQLException
    {
        // log.finer("Prepearing to process " + queue.size() + " actions." );
        //Move new adjustments over to a new List in a way that is safe
        List<ActionRecord> newqueue = new ArrayList<ActionRecord>();
        List<ActionRecord> toProcess = queue;
        queue = newqueue;
        //process
        String query = "insert into actionlog (actor, action, subject, ts) values (?,?,?,?)";
        long start = System.currentTimeMillis();
        PreparedStatement ps = conn.prepareStatement(query);
        for(ActionRecord s : toProcess)
        {
            ps.setInt(1, s.getActor());
            ps.setInt(2, s.getAction());
            ps.setInt(3, s.getSubject());
            ps.setLong(4, s.getTimestamp());
            ps.addBatch();
        }
        ps.executeBatch();
        log.info( "Total time to process "+toProcess.size()+" records in the action log was " + (System.currentTimeMillis() - start) + "ms");
        DatabaseUtility.close(ps);
    }
}

class ActionRecord
{
	protected int actor = 0;
	protected int action = 0;
	protected int subject = 0;
    protected long timestamp = System.currentTimeMillis();

    public ActionRecord(int actor, int action, int subject)
    {
        this.actor = actor;
        this.action = action;
        this.subject = subject;
    }

    public String toString()
    {
        return "insert into actionlog (actor, action, subject, time) values ( " + actor + "," + action + ","  + subject + ","  + timestamp + ")";
    }

	public int getActor() { return this.actor; }
	public void setActor(int actor) { this.actor = actor; }
	public int getAction() { return this.action; }
	public void setAction(int action) { this.action = action; }
	public int getSubject() { return this.subject; }
	public void setSubject(int subject) { this.subject = subject; }
	public long getTimestamp() { return this.timestamp; }
	public void setTimestamp(long timestamp) { this.timestamp = timestamp; }


}
