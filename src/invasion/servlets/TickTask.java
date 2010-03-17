/**
 *
 */

package invasion.servlets;

import java.io.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.*;
import invasion.dataobjects.*;
import invasion.util.*;


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
    static{log.setLevel(Level.FINER);}

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
            //checkBadges();
            //checkLevels();
            checkSanity();
            adjustStats();
            log.exiting( KEY, "run" );
        }
        catch(Exception e)
        {
            log.throwing(KEY, "Exception running the tick", e);
            //TODO bot notify
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
        String query = "update alt set ap = ap + 1 where ap < apmax";
        conn.executeUpdate(query);
        //EK doesn't want his IP to decrease
        query = "update alt set ip = ip -1 where ip > 0 AND id!=4 ";
        conn.executeUpdate(query);
        //if you have 10 HP or less, you are destined for death.
        query = "insert into messages (message, type, altid) select 'Your wounds are so grevious even breathing causes more damage', 4, id from alt where hp < 11 and hp > 0; " +
            "update stats set count = count + 1 where statid = 4 and altid in (select id from alt where hp < 11 and hp > 0); " +  //update damage taken
            "update alt set hp = hp - 1 where hp < 11 and hp > 0 ";
        conn.executeUpdate(query);
        //if just died, put body at a random cloning facility
        query = "insert into messages (message, type, altid) select 'Your new body has been started.  It will be ready in approximately ' || level || ' tick(s).', 1, id from alt where location=-57005";
        conn.executeUpdate(query);
        query = "update alt set location = (select id from location l where typeid=31 and alt.station=l.station order by random() limit 1), ticksalive=-1*level where location=-57005";
        //increament ticksalive
        conn.executeUpdate(query);
        query = "update alt set ticksalive = ticksalive + 1 where ticksalive != 0 ";
        conn.executeUpdate(query);
        //clear "lasthurtby" where hp=hpmax
        query = "update alt set lasthurtby=null where hp=hpmax and lasthurtby is not null ";
        conn.executeUpdate(query);

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

}

