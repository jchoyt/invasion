/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.bot;

import org.jibble.pircbot.*;
import java.io.*;
import java.net.*;
import java.text.*;
import java.util.*;


/**
 * This provides functionality that is just plain screwing around.
 *
 * @author jchoyt
  */
public class GoofyCommands implements BotCommandHandler
{
    private List<String> vend = new ArrayList<String>(  );
    private Inventory inventory = new Inventory("inventory.txt");

    public GoofyCommands()
    {
        reload();
    }

    public boolean handleMessage(Info info)
    {
        String message = info.getMessage();
        if ( message.equalsIgnoreCase( "!reload" ) )
        {
            reload(  );
            info.getBot().reload();
            info.sendMessage( "I have reloaded the various lists, as instructed." );
        }
        else if ( message.equalsIgnoreCase( "!vend" ) )
        {
            double randomValue = Math.random(  );
            if( randomValue < 0.25 && inventory.getInventoryCount()>0)
            {
                // info.sendMessage("Let's see what I have for you from my special inventory..." );
                info.sendAction( "gives " + info.getSender() + " " + inventory.getItem() );
            }
            else
                sendQuote( info, vend );
        }
        else if ( message.equalsIgnoreCase( "!inventory" ) )
        {
            info.sendMessage("Kind strangers have given me " + inventory.getInventoryCount() + " items that I have not distributed yet. You can !give me your items to be handed out later." );
        }
        else if ( message.startsWith( "!give " ) )
        {
            String item = message.substring( 6 );
            inventory.addItem( item + " (provided by " + info.getSender() + ", " + new Date() + ")");
            info.sendAction("puts the thoughtful gift in a pouch marked \"For someone special\".");
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

    /**
     *  Sends a random selection from quotelist
     */
    private void sendQuote( Info info, List<String> quotelist )
    {
        if ( quotelist.size(  ) == 0 )
        {
            info.sendMessage( "Internal Bot Error. Please don't do that again." );
            return;
        }

        double randomValue = Math.random(  );
        int quoteNum = ( int ) ( randomValue * quotelist.size(  ) );
        String quote = quotelist.get( quoteNum );

        if ( quote.startsWith( "/me " ) )
        {
            info.sendAction(  quote.substring( 4 ) );
        }
        else
        {
            info.sendMessage( quote );
        }
    }


    /**
     *  Sends a random selection from quotelist
     */
    private void sendQuote( Info info, List<String> quotelist, String match )
    {
        int MAXLENGTH = 475;
        match = match.toLowerCase();
        if ( quotelist.size(  ) == 0 )
        {
            info.sendMessage( "Internal Bot Error." );
        }

        double randomValue = Math.random(  );
        int quoteNum = ( int ) ( randomValue * quotelist.size(  ) );
        String quote = quotelist.get( quoteNum ).toLowerCase();
        int tries = 0;
        while( !quote.contains(match) && tries < 300 )
        {
            tries++;
            randomValue = Math.random(  );
            quoteNum = ( int ) ( randomValue * quotelist.size(  ) );
            quote = quotelist.get( quoteNum ).toLowerCase();
        }
        if( tries < 300 )
        {
            quote = quotelist.get( quoteNum );
        }
        else
            quote = "I didn't find a quote that matched \"" + match +"\"";
        while ( quote.length(  ) > MAXLENGTH )
        {
            int breakPt = quote.lastIndexOf(" ", MAXLENGTH );
            info.sendMessage( quote.substring( 0, breakPt ) );
            quote = quote.substring( breakPt - 1 );
        }

        if ( quote.startsWith( "/me " ) )
        {
            info.sendAction(  quote.substring( 4 ) );
        }
        else
        {
            info.sendMessage( quote );
        }
    }


    /**
     * Reloads all the various text files.  !reload makes the bot do this.
     */
    private void reload(  )
    {
        vend = Utils.loadFile( "vend.txt", true);
        inventory.load();
    }

    public void handleJoin( Info info ){}
    public void handleNickChange( Info info ){}
}
