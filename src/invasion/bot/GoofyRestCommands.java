/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.bot;

import java.util.logging.Level;
import java.util.logging.Logger;
import org.jibble.pircbot.*;
import java.io.*;
import java.net.*;
import java.text.*;
import java.util.*;


/**
 * This provides functionality that isjust plain screwing around.
 *
 * @author jchoyt
 * @deprecated  Replaced by EK by a python bot.  I assume he's splitting it off and will run it under a different nick eventually
 */
public class GoofyRestCommands implements BotCommandHandler
{

    public final static String KEY = GoofyRestCommands.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    public GoofyRestCommands()
    {
    }

    public boolean handleMessage(Info info)
    {

        log.entering( KEY, "handleMessages()" );
        String message = info.getMessage();
        if ( message.equalsIgnoreCase( "!vend" ) )
        {
            log.info("Attempting to vend");
            try
            {
                URL url = new URL("http://itvends.com/vend.php");
                InputStream is = (InputStream) url.getContent();
                BufferedReader br = new BufferedReader(new InputStreamReader(is));
                String line = null;
                StringBuffer sb = new StringBuffer();
                while((line = br.readLine()) != null){
                    sb.append(line);
                }
                String htmlContent = info.getBot().getName() + " vends " + sb.toString();
                info.sendMessage( htmlContent );
            }
            catch( Throwable t )
            {
                log.throwing(KEY, "broke hitting EK's server", t);
            }
        }
        else if ( message.equalsIgnoreCase( "!inventory" ) )
        {
            // info.sendMessage("Kind strangers have given me " + inventory.getInventoryCount() + " items that I have not distributed yet. You can !give me your items to be handed out later." );
        }
        else if ( message.startsWith( "!give " ) )
        {
        //     String item = message.substring( 6 );
        //     inventory.addItem( item + " (provided by " + info.getSender() + ", " + new Date() + ")");
        //     info.sendAction("puts the thoughtful gift in a pouch marked \"For someone special\".");
        }
        return true;
    }

    /**
     *  Handles private messages.  These are usually administrative type tasks that only the bot owner should be able to execute.
     */
    public boolean handlePrivateMessage(Info info)
    {
        return false;
    }

    public void handleJoin( Info info ){}
    public void handleNickChange( Info info ){}
}
