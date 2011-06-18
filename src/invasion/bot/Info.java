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
 * This is the main class for invasion.bot.  It processes all commands and provides for all interactions with IRC channels.
 *
 * @author jchoyt
  */
public class Info
{
    private String channel;
    private String sender;
    private String login;
    private String hostname;
    private String message;
    private VasionBot bot;

    private Info()
    {
    }


    /**
    Basic constructor for Info
    */
    public Info(VasionBot bot, String channel, String sender, String login, String hostname, String message)
    {
        this.channel  = channel  ;
        this.sender   = sender   ;
        this.login    = login    ;
        this.hostname = hostname ;
        this.message  = message  ;
        this.bot = bot;
    }


    /**
     *  Constructor for Private messages
     */
    public Info(VasionBot bot, String sender, String login, String hostname, String message)
    {
        this.channel  = sender ;
        this.sender   = sender   ;
        this.login    = login    ;
        this.hostname = hostname ;
        this.message  = message  ;
        this.bot = bot;
    }

    /**
	 * Returns the value of bot.
	 */
	public VasionBot getBot()
	{
		return bot;
	}


    public void sendMessage( String channel, String msg )
    {
        bot.sendMessage( channel, msg );
    }


    public void sendMessage( String msg )
    {
        bot.sendMessage( this.channel, msg );
    }


    public void sendAction( String channel, String msg )
    {
        bot.sendAction( channel, msg );
    }


    public void sendAction( String msg )
    {
        bot.sendAction( this.channel, msg );
    }


    /**
	 * Returns the value of message.
	 */
	public String getMessage()
	{
		return message;
	}


    /**
	 * Returns the value of channel.
	 */
	public String getChannel()
	{
		return channel;
	}


	/**
	 * Returns the value of nick.
	 */
	public String getSender()
	{
		return sender;
	}

}
