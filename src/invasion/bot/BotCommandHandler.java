/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.bot;

import org.jibble.pircbot.*;

import java.io.*;
import java.util.*;
import java.net.*;
import java.text.*;
import java.util.*;


/**
 *  Provides an interface for pluggable IRC command handlers.  Calling code should create an Info object and pass it in
 *  to the implemnting class's handleMessage() method.  Fire and forget...you just need to check the return method to see
 *  if this handler handled the command.
 *
 * @author jchoyt
  */
public interface BotCommandHandler
{
    /**
     *  Handles the commands this handler is capable of.  Returns true if the command was handled, false if not.
     */
    public boolean handleMessage( Info info );

    public boolean handlePrivateMessage( Info info );

    public void handleJoin( Info info );

    public void handleNickChange( Info info );  //the sender member of Info gets the new nick


}
