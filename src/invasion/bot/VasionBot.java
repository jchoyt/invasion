/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.bot;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.jibble.pircbot.*;

import java.io.*;

import java.net.*;
import java.text.*;
import java.util.*;


/**
 * This is the main class for yocsbot.  It processes all commands and provides for all interactions with IRC channels.
 *
 * @author jchoyt
  */
public class VasionBot extends PircBot
{

    public final static String KEY = VasionBot.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     * The line separator for the OS this is running on.  While everyone should be running Linux or MacOS, I recognize
     * some are unfortunate enough to run Windows.
     */
    public final static String LINESEP = System.getProperty( "line.separator" );
    private static List<String> channels = new ArrayList<String>();
    private Timer timer = new Timer(true);
    private List<BotCommandHandler> doers = new ArrayList<BotCommandHandler>();
    private Config config = null;
    public ChannelCommands channelCommands;
    private static List<String> owners = null;
    private List<String> ignoreList = null;
    private static VasionBot bot = null;

    /**
     * Creates a new VasionBot object.  These hardcoded instances should be changed if you reuse this code.  Preferably, they
     * should be moved to an external text file.
     */
    public VasionBot( String propsFile )
    {
        log.entering( KEY, "Constructor", "starting" );
        InputStream resource = getClass().getClassLoader().getResourceAsStream( propsFile );
        System.setProperty("http.agent", "EKs pants");
        if( resource == null )
        {
            log.severe( "Did not find a config file named " + propsFile );
        }
        else
        {
            VasionBot.bot = this;
            config = new Config( resource );

            //set bot info
            this.setName( config.getValue("name") );
            owners = Arrays.asList( config.getValue("owner").split(",") );
            this.setLogin( config.getValue("name") );

            reload();

            //set up handlers
            channelCommands = new ChannelCommands();
            doers.add(channelCommands);
            doers.add(new GoofyRestCommands() );
            // doers.add(new MessageCommands());
            join();
        }
    }

    /**
     *  Commands that work only in a private message (/msg yocsbot <command>)  These commands are mostly for management of the bot.
     */
    protected  void  onPrivateMessage(String sender, String login, String hostname, String message)
    {
        log.entering(KEY, "onPrivateMessage()");
        if( ignoreList.contains( sender ) )
        {
            return;
        }
        Info info = new Info( this,  sender,  login,  hostname,  message );
        if ( message.startsWith( "!ignore " ) && owners.contains(info.getSender() ) )
        {
            String nick = message.substring( 8 );
            ignoreList.add( nick );
            Utils.save( ignoreList, "ignore.txt" );
        }
        else if( message.startsWith("!connect ") && owners.contains(info.getSender() ) )
        {
            String[] parts = message.substring( 9 ).split( " " );
            if( parts.length != 3 )
            {

            }
        }
        for(BotCommandHandler doer : doers )
        {
            if(doer.handlePrivateMessage( info )) break;
        }
        onMessage(sender, sender, login, hostname, message);
    }

    /**
     * The general commands that work in all channels (including private ones, due to the "else" above.
     *
     * @param channel DOCUMENT ME!
     * @param sender DOCUMENT ME!
     * @param login DOCUMENT ME!
     * @param hostname DOCUMENT ME!
     * @param message DOCUMENT ME!
     */
    protected void onMessage( String channel, String sender, String login, String hostname, String message )
    {
        log.entering(KEY, "onMessage()");
        if( ignoreList.contains( sender ) )
        {
            return;
        }
        // if( message.equals("!help" ) )
        // {
        //     sendMessage( channel, "Help for " + getName() + " can be found at " + config.getValue("helpUrl") );
        //     return;
        // }
        Info info = new Info( this,  channel,  sender,  login,  hostname,  message );
        System.out.println("Sending to doers");
        for(BotCommandHandler doer : doers )
        {
            if(doer.handleMessage( info )) break;
        }
    }

    protected void onInvite(String targetNick,
                        String sourceNick,
                        String sourceLogin,
                        String sourceHostname,
                        String channel)
    {
        // channel = channel.replace("#", "");
        // String[] channels = config.getValues("room");
        // for(int i = 0; i < channels.length; i++)
        // {
        //     if( channel.equals(channels[i] ) )
        //     {
        //         channelCommands.join(channel, this);
        //         break;
        //     }
        // }
    }


    /**
     *  Clears out the temporary per-channel data
     */
    protected void onJoin(String channel, String sender, String login, String hostname)
    {
        // System. out.println(ignoreList);
        if( ignoreList.contains( sender ) )
        {
            return;
        }
        // System.out.println( "in onJoin()" );
        Info info = new Info( this,  channel,  sender,  login,  hostname,  "" );
        for(BotCommandHandler doer : doers )
        {
            doer.handleJoin(info);
        }
    }

    protected void onNickChange(String oldNick, String login, String hostname, String newNick)
    {
        if( ignoreList.contains( oldNick ) || ignoreList.contains( newNick ) )
        {
            return;
        }
        Info info = new Info( this,  null,  newNick,  login,  hostname,  "" );
        for(BotCommandHandler doer : doers )
        {
            doer.handleNickChange(info);
        }
    }

    /**
     * Starts the program
     *
     * @param args DOCUMENT ME!
     *
     * @throws Exception DOCUMENT ME!
     */
    public static void main( String[] args ) throws Exception
    {
        if( args.length < 1 )
        {
            usage();
            //System.exit(1);
            return;
        }

        // Now start our bot up.
        VasionBot bot = new VasionBot( args[0] );

        // Enable debugging output.
        bot.setVerbose(true);

        // Sos I can test
        bot.setAutoNickChange( true );

    }

    private static void usage()
    {
        System.out.println( "usage: java -jar invasion.bot.jar <properties file>"  );
    }

    protected void onDisconnect()
    {
        try
        {
            Thread.sleep(5*60*1000); //sleep 5 minutes, then rejoin
        }
        catch (Exception e)
        {
            //just rejoin immediately
        }
        join();
    }

    protected void join()
    {
        try{
            // Connect to the IRC server.
            connect( config.getValue("server"), Integer.parseInt(config.getValue("port")) );
            log.info( "Connected to " + config.getValue("server") );
        }
        catch(Exception e)
        {
            e.printStackTrace();
            //System.exit(1);
            return;
        }

        if(config.getValue("authenticate") != null)
            this.sendMessage("NickServ", config.getValue("authenticate"));

        String[] channels = config.getValues("room");
        for(int i = 0; i < channels.length; i++)
        {
            channelCommands.join(channels[i], this);
            log.info( "Joined to " +  channels[i] );
            VasionBot.channels.add( channels[i] );
        }
        // VasionBot.bot.sendMessage( VasionBot.channels.get(0), "Don't try to get me to do stuff..I'm not here for your entertainment.  I report errors.  That's about all.");
    }

    public static boolean isOwner(String nick)
    {
        return owners.contains(nick);
    }

    public String getProperty(String name)
    {
        return config.getValue( name );
    }

    /**
     * Reloads all the various text files.  !reload makes the bot do this.
     */
    public void reload(  )
    {
        ignoreList = Utils.loadFile( "ignore.txt", true );
        // System.out.println("ignoreList loaded without error: " + ignoreList);
    }

    public static void announce( String msg )
    {
        bot.sendMessage( channels.get(0), msg );
    }

    public static void shutdown()
    {
        bot.disconnect();
    }
}

