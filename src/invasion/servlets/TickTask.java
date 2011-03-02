/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import java.io.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.*;
import invasion.dataobjects.*;
import invasion.util.*;
import invasion.pets.*;


/**
 *  This class is a repeating task to process the tick
 *
 * @author     jchoyt
 * @created    Wed Mar 10 12:39:43 EST 2010 @777 /Internet Time/
 */


public class TickTask extends TimerTask
{

    public final static String KEY = TickTask.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    InvasionConnection conn = null;

    /**
     *  Constructor for the TickTask object
     */
    public TickTask() { }


    /**
     *  Main processing method for the TickTask object
     */
    public void run()
    {
        try
        {
            conn = new InvasionConnection();
            log.entering( KEY, "run" );
            processStats();
            ticksAlive();
            checkLevels();
            checkSanity();
            adjustStats();
            //checkBadges();
            Alt.checkCache();
            BroodManager.workBroodsForTick();
            log.exiting( KEY, "run" );
        }
        catch(Exception e)
        {
            log.throwing(KEY, "Exception running the tick", e);
            // TODO bot notify
        }
        finally{
            conn.close();
            conn = null;
        }
    }

    /**
     *  Adjust stats (e.g., increment AP) and gives a guy a new body..  This will have to be revisited once critters start locking down cloning facilities
     */
    private void adjustStats()
        throws SQLException
    {
        Statement s = conn.getConnection().createStatement();
        //do tick
        s.addBatch( "update alt set ap = ap + 1 where ap < apmax" );
        //EK doesn't want his IP to decrease
        s.addBatch( "update alt set ip = ip -1 where ip > 0 AND id!=4 ");
        //if you have 10 HP or less, you are destined for death.
        s.addBatch( "insert into messages (message, type, altid) select 'Your wounds are so grevious even breathing causes more damage', 4, id from alt where hp < 11 and hp > 0 ");
        s.addBatch( "update stats set count = count + 1 where statid = 4 and altid in (select id from alt where hp < 11 and hp > 0) " ); //update damage taken
        s.addBatch( "update alt set hp = hp - 1 where hp < 11 and hp > 0 ");
        s.executeBatch();
        DatabaseUtility.close(s);
        //Check for death
        String query = "select id from alt where hp < 1 and ticksalive > 0";
        ResultSet rs = conn.psExecuteQuery( query, "Error checking for those who have died a slow death" );
        while(rs.next())
        {
            Alt.load( conn, rs.getInt(1) ).kill( conn );
        }
        s = conn.getConnection().createStatement();
        //if just died, put body at a random cloning facility
        s.addBatch( "insert into messages (message, type, altid) select 'Your new body has been started.  It will be ready in approximately ' || level || ' tick(s).', 1, id from alt where location=-57005" );
        s.addBatch( "update alt set location = (select id from location l where typeid=31 and alt.station=l.station order by random() limit 1), ticksalive=-1*level where location=-57005" );
        //increament ticksalive
        s.addBatch( "update alt set ticksalive = ticksalive + 1 where ticksalive != 0 " );
        //clear "lasthurtby" where hp=hpmax
        s.addBatch( "update alt set lasthurtby=null where hp=hpmax and lasthurtby is not null " );
        s.executeBatch();
        DatabaseUtility.close(s);
    }

    private void checkSanity()
    {
        //if insane, do some random action
        //chance of random action is (IP-(20+level))/100
        //else decrement
    }


    private void ticksAlive()
    {
        //negative for can't spawn
        //set to 1 at respawn
        //count/98 for days alive
    }

    /**
     * rotaties the stats tracker and logs them to file prior to processing
     * @param
     * @return
     *
     */
    private void processStats()
    {
        try
        {
            Stats.process( conn );
        }
        catch (SQLException e)
        {
            StringWriter w = new StringWriter();
            try{Stats.writeLog(w);}catch(Exception ey){}
            log.warning( w.toString() );
            return;
        }
    }

    private void checkLevels()
    throws SQLException
    {
        long start = System.currentTimeMillis();
        Statement s = conn.getConnection().createStatement();
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 99 and level < 2");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 199 and level < 3");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 299 and level < 4");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 499 and level < 5");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 699 and level < 6");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 899 and level < 7");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 1199 and level < 8");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 1499 and level < 9");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 1799 and level < 10");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 2199 and level < 11");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 2599 and level < 12");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 2999 and level < 13");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 3499 and level < 14");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 3999 and level < 15");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 4499 and level < 16");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 5099 and level < 17");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 5699 and level < 18");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 6299 and level < 19");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 6999 and level < 20");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 7699 and level < 21");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 8399 and level < 22");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 9199 and level < 23");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 9999 and level < 24");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 10799 and level < 25");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 11699 and level < 26");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 12599 and level < 27");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 13499 and level < 28");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 14499 and level < 29");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 15499 and level < 30");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 23249 and level < 31");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 34874 and level < 32");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 52299 and level < 33");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 78449 and level < 34");
        s.addBatch( "insert into messages (message, type, altid) select 'After some contemplation on your experiences, you have a major insight.  You have levelled up!' , 4,  id from alt where xp > 117674 and level < 35");
        s.addBatch( "update alt set cp=cp+10,level=level+1 where xp > 99 and level < 2");
        s.addBatch( "update alt set cp=cp+10,level=level+1, apmax=apmax+2 where xp > 199 and level < 3");
        s.addBatch( "update alt set cp=cp+10,level=level+1 where xp > 299 and level < 4");
        s.addBatch( "update alt set cp=cp+10,level=level+1 where xp > 299 and level < 4");
        s.addBatch( "update alt set cp=cp+10,level=level+1, hpmax=hpmax+3, hp=hp+3 where xp > 499 and level < 5");
        s.addBatch( "update alt set cp=cp+15,level=level+1, apmax=apmax+2 where xp > 699 and level < 6");
        s.addBatch( "update alt set cp=cp+15,level=level+1 where xp > 899 and level < 7");
        s.addBatch( "update alt set cp=cp+15,level=level+1 where xp > 1199 and level < 8");
        s.addBatch( "update alt set cp=cp+15,level=level+1, apmax=apmax+2 where xp > 1499 and level < 9");
        s.addBatch( "update alt set cp=cp+15,level=level+1, hpmax=hpmax+3, hp=hp+3 where xp > 1799 and level < 10");
        s.addBatch( "update alt set cp=cp+15,level=level+1 where xp > 2199 and level < 11");
        s.addBatch( "update alt set cp=cp+15,level=level+1, apmax=apmax+2 where xp > 2599 and level < 12");
        s.addBatch( "update alt set cp=cp+15,level=level+1 where xp > 2999 and level < 13");
        s.addBatch( "update alt set cp=cp+15,level=level+1 where xp > 3499 and level < 14");
        s.addBatch( "update alt set cp=cp+15,level=level+1, apmax=apmax+2, hpmax=hpmax+3, hp=hp+3 where xp > 3999 and level < 15");
        s.addBatch( "update alt set cp=cp+20,level=level+1 where xp > 4499 and level < 16");
        s.addBatch( "update alt set cp=cp+20,level=level+1 where xp > 5099 and level < 17");
        s.addBatch( "update alt set cp=cp+20,level=level+1, apmax=apmax+2 where xp > 5699 and level < 18");
        s.addBatch( "update alt set cp=cp+20,level=level+1 where xp > 6299 and level < 19");
        s.addBatch( "update alt set cp=cp+20,level=level+1, hpmax=hpmax+3, hp=hp+3 where xp > 6999 and level < 20");
        s.addBatch( "update alt set cp=cp+20,level=level+1, apmax=apmax+2 where xp > 7699 and level < 21");
        s.addBatch( "update alt set cp=cp+20,level=level+1 where xp > 8399 and level < 22");
        s.addBatch( "update alt set cp=cp+20,level=level+1 where xp > 9199 and level < 23");
        s.addBatch( "update alt set cp=cp+20,level=level+1, apmax=apmax+2 where xp > 9999 and level < 24");
        s.addBatch( "update alt set cp=cp+20,level=level+1, hpmax=hpmax+3, hp=hp+3 where xp > 10799 and level < 25");
        s.addBatch( "update alt set cp=cp+25,level=level+1 where xp > 11699 and level < 26");
        s.addBatch( "update alt set cp=cp+25,level=level+1, apmax=apmax+2 where xp > 12599 and level < 27");
        s.addBatch( "update alt set cp=cp+25,level=level+1 where xp > 13499 and level < 28");
        s.addBatch( "update alt set cp=cp+25,level=level+1 where xp > 14499 and level < 29");
        s.addBatch( "update alt set cp=cp+25,level=level+1, apmax=apmax+2, hpmax=hpmax+3, hp=hp+3 where xp > 15499 and level < 30");
        s.addBatch( "update alt set cp=cp+30,level=level+1, apmax=apmax+5 where xp > 23249 and level < 31");
        s.addBatch( "update alt set cp=cp+35,level=level+1, apmax=apmax+6 where xp > 34874 and level < 32");
        s.addBatch( "update alt set cp=cp+40,level=level+1, apmax=apmax+7 where xp > 52299 and level < 33");
        s.addBatch( "update alt set cp=cp+45,level=level+1, apmax=apmax+8 where xp > 78449 and level < 34");
        s.addBatch( "update alt set cp=cp+50,level=level+1, apmax=apmax+9 where xp > 117674 and level < 35");
        int[] counts = s.executeBatch();
        int sum=0;
        for(int count : counts)
        {
            sum = sum + count;
        }
        log.info( "Total time to process "+sum+" level adjustments was " + (System.currentTimeMillis() - start) + "ms");
        DatabaseUtility.close(s);
    }

}

