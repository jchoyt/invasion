/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import java.io.*;
import invasion.bot.*;
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
 *  Class to process Stats on shutdown
 */
@WebListener
public class StatsListener implements ServletContextListener
{

    public final static String KEY = StatsListener.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}
	ServletContext context;

	@Override
	public void contextInitialized(ServletContextEvent contextEvent)
	{
		System.out.println("Context Created");
		context = contextEvent.getServletContext();
		// set variable to servlet context
		context.setAttribute("TEST", "TEST_VALUE");
	}

	@Override
	public void contextDestroyed(ServletContextEvent contextEvent)
	{
		context = contextEvent.getServletContext();
		InvasionConnection conn= null;
        try
        {
            conn = new InvasionConnection();
            Stats.process(conn);
        }
        catch (SQLException e)
        {
            try
            {
                Stats.writeLog(new FileWriter( context.getRealPath( "/" ) + "/stats"+System.currentTimeMillis() ) );
            }
            catch(Exception ex)
            {
                StringWriter w = new StringWriter();
                try{Stats.writeLog(w);}catch(Exception ey){}
                log.warning( w.toString() );
            }
            log.throwing(KEY, "body", e);
            return;
        }
        finally
        {
            conn.close();
        }
        VasionBot.shutdown();
		// System.out.println("Context Destroyed");
	}
}

