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
 * This provides functionality that is more closely tied to channel management or dealing with RL objects (like time)
 *
 * @author jchoyt
  */
public class ChannelCommands implements BotCommandHandler
{
    /**
     * VasionBot saves messages to be delivered the next time someone logs in - this is the central mechanism for doing this.
     */
    private Messages messages = new Messages( "messages.ser" );
    private Timer timer = new Timer(true);
    public List<String> channels = new ArrayList<String>();
    private SimpleDateFormat timeOnly = new SimpleDateFormat( "H:mm" );

    public ChannelCommands()
    {
        messages.load(  );
    }

    public boolean handleMessage(Info info)
    {
        //check for commands to process
        String message = info.getMessage();

        if ( message.equalsIgnoreCase( "!quiet" ) || message.equalsIgnoreCase( "!quite" ))
        {
            quiet(info);
        }
        else if ( message.equalsIgnoreCase( "!talk" ) )
        {
            talk(info);
        }
        else if ( message.startsWith( "!voice" ) )
        {
            voice(info);
        }
        else if ( message.startsWith( "!novoice" ) )
        {
            novoice(info);
        }
        else
            return false;
        return true;
    }

    /**
     *  Handles private messages.  These are usually administrative type tasks that only the bot owner should be able to execute.
     */
    public boolean handlePrivateMessage(Info info)
    {

        if( !VasionBot.isOwner(info.getSender() ) )
        {
            return false;
        }
        String message = info.getMessage();
        if( message.startsWith( "!join " ) )
        {
            String login = message.substring( 6 ).trim();
            join( login, info.getBot() );
        }
        else if( message.startsWith( "!part " ) )
        {
            String channel = message.substring( 6 );
            if( channel.charAt(0) != '#' )
            {
                channel = "#" + channel;
            }
            channels.remove( channel );
            info.getBot().partChannel( channel, "I do my bidding." );
        }
        else if( message.equals( "!shutdown" ) )
        {
            info.getBot().quitServer( info.getBot().getNick() + " is shutting down." );
            System.exit(0);
        }
        else if( message.equals("!help") )
        {
            info.sendMessage( info.getSender(), "All normal channel commands work here, plus the following: !reviewall, !shutdown, !join <channel>, !part <channel>, !dm <nick>, !identify <password>" );
        }
        else if ( message.equalsIgnoreCase( "!diagnostics" ) )
        {
            diagnostics( info );
        }
        else
            return false;
        return true;
    }

    /**
     *  given a set of login info (either a channel or a channel/password pair, log in to the channel
     */
    public void join(String login, PircBot bot)
    {
           int space = login.indexOf(' ');
           String channel;
           if(space == -1)
           {
               //no password
               if( login.charAt(0) == '#' )
               {
                   channel = login;
               }
               else channel = "#" + login;
               channels.add( channel );
               bot.joinChannel( channel);
           }
           else
           {
               channel = login.substring(0, space);
               String password = login.substring(space);
               if( channel.charAt(0) != '#' )
               {
                   channel = "#" + channel;
               }
               channels.add( channel );
               bot.joinChannel( channel, password );
           }
    }


    /**
     *  returns if the user has voice or is an op on the channel
     */
    public boolean hasVoice(String nick, String channel)
    {
        return false;
    }

    /**
     *  Sets the channel mode to Moderated
     */
    public void quiet( Info info )
    {
        info.getBot().setMode( info.getChannel(), "+m");
    }

    /**
     *  Sets the channel mode to unModerated
     */
    public void talk( Info info )
    {
        info.getBot().setMode( info.getChannel(), "-m");
    }

    /**
     *  Gives voice to nick in message
     */
    public void voice( Info info )
    {
        String namelist = info.getMessage().substring(6);
        String[] names = namelist.split(" ");
        namelist = "+vvvvvv" + namelist;
        info.getBot().setMode( info.getChannel(), namelist );
    }

    /**
     *  Removes voice from nick in message
     */
    public void novoice( Info info )
    {
        String namelist = info.getMessage().substring(8);
        String[] names = namelist.split(" ");
        namelist = "-vvvvvv" + namelist;
        info.getBot().setMode( info.getChannel(), namelist );
    }


    public void showAllMessages( Info info )
    {
        List m = messages.reviewAllMessages(  );

        if ( m != null )
        {
            if ( m.size(  ) == 0 )
            {
                info.sendMessage( "No messages pending." );
            }
            else
            {
                for ( Object o : m )
                {
                    info.sendMessage( String.valueOf( o ) );
                }
            }
       }
    }


    /**
     *  lists all the channels the bot is in.
     */
    private void diagnostics( Info info )
    {
        info.sendMessage(info.getSender(), "I am on " + Arrays.toString( info.getBot().getChannels() ) );
    }

    public boolean showHelp( Info info )
    {
        info.sendMessage( "Channel commands:");
        // info.sendMessage( "     general commands are !ping, !weather, !gmt, !timer, !alias <nick> <alt>, and !whois <nick or alt previously registered with !alias>.");
        // info.sendMessage( "     channel management commands are !quiet, !talk, !voice <nick>, !novoice <nick>.");
        return true;
    };

    public void handleJoin( Info info )
    {
        // System.out.println( "Sender: " + info.getSender() + " my name " + info.getBot().getName() );
        if(info.getSender().equals(info.getBot().getName()))
        {
            System.out.println( "adding a new history structure for " + info.getChannel() );
        }
    }

    public void handleNickChange( Info info ){}

}



