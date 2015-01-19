package invasion.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;
import java.util.logging.Handler;
import java.util.logging.LogManager;
import java.util.logging.Logger;


/**
 *  Description of the Class
 *
 *@author     jchoyt
 *@created    May 30, 2004
 */
public class LogConfig
{

    public final static String KEY = LogConfig.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    /**
     *  Constructor for the LogConfig object
     */
    public LogConfig()
    {
        reloadLogManagerProperties();
    }


    /**
     *  Description of the Method
     */
    public static void reloadLogManagerProperties()
    {
        /*
         *  this is repsonsible for configuring the properties for the logging
         */
        Properties props = new Properties();
        //set root logger level
        props.setProperty(".level","FINER");
        //set handlers
        props.setProperty("handlers","java.util.logging.ConsoleHandler,java.util.logging.FileHandler,org.apache.juli.FileHandler");
        //configure ConsoleHandler
        // props.setProperty("java.util.logging.ConsoleHandler.formatter","invasion.util.LogFormatter");  //not working
        props.setProperty("java.util.logging.ConsoleHandler.level","FINER");
        //configure FileHandler
        // props.setProperty("java.util.logging.FileHandler.formatter","invasion.util.LogFormatter");  //not working
        props.setProperty("java.util.logging.FileHandler.level","FINER");
        props.setProperty("java.util.logging.FileHandler.limit","1000000");
        // props.setProperty("java.util.logging.FileHandler.pattern", "/invasion.log");
        props.setProperty("java.util.logging.FileHandler.count","5");
        //for tomcat
        // props.setProperty( "org.apache.juli.FileHandler.pattern", "invasion%u.log" );
        props.setProperty( "org.apache.juli.FileHandler.directory", "${catalina.base}/logs" );
        props.setProperty( "org.apache.juli.FileHandler.prefix", "invasion." );
        props.setProperty("org.apache.juli.FileHandler.level","INFO");

        //read in the properties as a Stream
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        try
        {
            props.store( bos, "Logging Properties" );
            ByteArrayInputStream in = new ByteArrayInputStream( bos.toByteArray() );
            LogManager.getLogManager().readConfiguration( in );
            Handler[] handlers = LogManager.getLogManager().getLogger( "" ).getHandlers();
            for ( int i = 0; i < handlers.length; i++ )
            {
                handlers[i].setFormatter( new LogFormatter() );
            }
        }
        catch ( IOException e )
        {
            System.out.println( LogFormatter.formatThrowable( e ) );
        }
        catch ( NullPointerException e )
        {
            System.out.println( LogFormatter.formatThrowable( e ) );
        }
    }


    /**
     *  Gets the configuration attribute of the LogConfig class
     *
     *@return    The configuration value
     */
    public static String getConfiguration()
    {
        StringBuilder ret = new StringBuilder( "Current LogManager configuration" );
        Logger logger = null;
        for ( Enumeration<String> e = LogManager.getLogManager().getLoggerNames(); e.hasMoreElements();  )
        {
            logger = LogManager.getLogManager().getLogger( e.nextElement() );
            ret.append( LogFormatter.NEWLINE );
            ret.append( "Logger name: " );
            ret.append( logger.getName() );
            if(logger.getLevel()!=null)
            {
                ret.append( LogFormatter.NEWLINE );
                ret.append( "\tLevel: " );
                ret.append( logger.getLevel().toString() );
            }
            Handler[] handlers = logger.getHandlers();
            for ( int i = 0; i < handlers.length; i++ )
            {
                ret.append( LogFormatter.NEWLINE );
                ret.append( "\tHandler: " );
                ret.append( handlers[i].getClass().getName() );
                ret.append( LogFormatter.NEWLINE );
                ret.append( "\t\tFormatter: " );
                ret.append( handlers[i].getFormatter().getClass().getName() );
                ret.append( LogFormatter.NEWLINE );
                ret.append( "\t\tLevel: " );
                ret.append( handlers[i].getLevel().toString() );
            }
        }
        return ret.toString();
    }
}

