package invasion.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Formatter;
import java.util.logging.LogRecord;
import java.util.logging.Logger;

/**
 *  Description of the Class
 *
 *@author     jchoyt
 *@created    May 30, 2004
 */
public class LogFormatter extends Formatter
{

    public final static String KEY = LogFormatter.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    public static final String NEWLINE = System.getProperty( "line.separator" );
    /**
     *  Description of the Method
     *
     *@param  record  Description of the Parameter
     *@return         Description of the Return Value
     */
    public String format( LogRecord record )
    {
        StringBuilder ret = new StringBuilder();
        ret.append( NEWLINE );
        ret.append( "[" );
        ret.append( formatDate( record.getMillis() ) );
        ret.append( " | "  );
        ret.append( record.getLevel().getName() );
        ret.append( " | " );
        if ( record.getSourceClassName() != null )
            ret.append( record.getSourceClassName() );
        else
            ret.append( "unknown" );
        if ( record.getSourceMethodName() != null )
        {
            ret.append( " | " );
            ret.append( record.getSourceMethodName() );
        }
        ret.append( "()] " );
        ret.append( record.getMessage() );
        Object[] params = record.getParameters();
        for ( int i = 0; params != null && i < params.length; i++ )
        {
            ret.append( "\n\t" );
            ret.append( String.valueOf( params[i].getClass().getName() ) );
            ret.append( ": " );
            ret.append( String.valueOf( params[i] ) );
        }
        Throwable t = record.getThrown();
        if ( t != null )
        {
            ret.append( NEWLINE );
            ret.append( "Exception chain: " );
            ret.append( NEWLINE );
            ret.append( LogFormatter.formatThrowable( t ) );
        }
        return ret.toString();
    }


    /**
     *  Description of the Method
     *
     *@param  t  Description of the Parameter
     *@return    Description of the Return Value
     */
    public static String formatThrowable( Throwable t )
    {
        StringBuilder ret = new StringBuilder();
        /*
         *  show the message
         */
        ret.append( "\t--" );
        ret.append( NEWLINE );
        ret.append("\t");
        ret.append( t.getClass().getName());
        ret.append( ": " );
        ret.append( t.getMessage() );
        /*
         *  If not the root cause, append the first 3 lines of the stack trace
         *  and then go on down the stack
         */
        StackTraceElement[] stack = t.getStackTrace();
        if ( t.getCause() != null )
        {
            ret.append( NEWLINE );
            int limit = stack.length > 2 ? 3 : stack.length;
            for ( int i = 0; i < limit; i++ )
            {
                ret.append( "\t" );
                ret.append( stack[i] );
                ret.append( NEWLINE );
            }
            ret.append( "\t..." + ( stack.length ) + " total\n" );
            ret.append( formatThrowable( t.getCause() ) );
        }
        /*
         *  if it is the root cause, make sure you go deep enough to get to
         *  mrald's classes, then show 2 more
         */
        else
        {
            int extra = 2;
            boolean foundMyClasses = false;
            ret.append( NEWLINE );
            ret.append( "\t*Root cause*" );
            ret.append( NEWLINE );
            for ( int i = 0; i < stack.length && extra >= 0; i++ )
            {
                ret.append( "\t" + stack[i] );
                ret.append( NEWLINE );
                foundMyClasses = foundMyClasses || stack[i].getClassName().indexOf( "invasion" ) > -1;
                if ( foundMyClasses )
                {
                    extra--;
                }
            }
            ret.append( "\t..." + ( stack.length ) + " total" );
        }
        return ret.toString();
    }


    /**
     *  Takes a date in milliseconds and returns the date, formatted like: <br>
     *  <code>yy-mm-dd hh:mm:ss</code>
     *
     *@param  time_millis  Description of the Parameter
     *@return              Description of the Return Value
     */
    public static String formatDate( long time_millis )
    {
        SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
        Date date = new Date( time_millis );
        return format.format( date );
    }

}

