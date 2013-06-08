/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import java.io.*;
import invasion.util.*;
import invasion.dataobjects.*;
import java.sql.*;
import java.text.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebListener;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


/**
 *  Class to kill the tick timers on application shutdown
 */
@WebListener
public class KillTickListener implements ServletContextListener
{

    public final static String KEY = KillTickListener.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
	ServletContext context;

	@Override
	public void contextInitialized(ServletContextEvent contextEvent)
	{
		log.finer("Context Created");
		context = contextEvent.getServletContext();
	}

	@Override
	public void contextDestroyed(ServletContextEvent contextEvent)
	{
		context = contextEvent.getServletContext();
		TickServlet.killTimer();
		PetTickServlet.killTimer();
		log.finer("Context Destroyed");
	}
}

