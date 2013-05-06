/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.bot;

import java.util.logging.Level;
import java.util.logging.Logger;

import java.text.*;
import java.util.regex.*;
import org.jibble.pircbot.*;
import java.io.*;
import java.net.*;
import java.text.*;
import java.util.*;

public class Utils
{

    public final static String KEY = Utils.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}
    /**
     *  URL to hit for accurate current time
     */
    public final static String timeUrl = "http://tycho.usno.navy.mil/cgi-bin/timer.pl";

    private final static List<String> stooges = Arrays.asList("CakeBot", "TekBot", "BeerWench", "EugeneBot" );

    public final static String NEWLINE = System.getProperty("line.separator");
    /**
    * returns the string UTC time from the timeUrl.  The form is MMM. d, HH:mm:ss z (e.g., Nov. 26, 20:27:39 UTC)
     */
    public static String getRealTime(Info info )
    {
        try
        {
            URL url = new URL( timeUrl );
            URLConnection conn = url.openConnection(  );
            BufferedReader dis = new BufferedReader( new InputStreamReader( conn.getInputStream( ) ) );
            String inputLine;

            while ( ( inputLine = dis.readLine(  ) ) != null )
            {
                if ( inputLine.contains( "UTC" ) )
                {
                    String date = inputLine.substring( 4 );  //"Feb. 11, 14:00:51 UTC";
                    dis.close(  );
                    return date;
                }
            }
        }
        catch ( Exception e )
        {
            info.sendMessage( "Time service is busted.  Hunt down Purveyor and make him fix it." );
        }
        return null;
    }


    public static GregorianCalendar getRealDate(Info info)
    {
        try
        {
            String timeString = getRealTime(info);
            SimpleDateFormat parser = new SimpleDateFormat( "MMM. d, HH:mm:ss z" );
            Date date = parser.parse( timeString );
            TimeZone z = parser.getTimeZone();
            GregorianCalendar cal = new GregorianCalendar(z);
            cal.setTime(date);
            return cal;
        }
        catch ( Exception e )
        {
            info.sendMessage( "Time service is busted.  Hunt down Purveyor and make him fix it." );
        }
        return null;    }


    public static int getRealMinutes( Info info )
    {
        try
        {
            String time = getRealTime( info );
            String[] parts = time.split(":");
            int minutes = Integer.parseInt( parts[1] );
            return minutes;
        }
        catch ( Exception e )
        {
            info.sendMessage( "Time service is busted.  Hunt down the Purveyor and make him fix it." );
        }
        return -1;

    }

    public static boolean isPresent( Info info, List<String> present )
    {
        User[] users = info.getBot().getUsers( info.getChannel() );

        for ( int i = 0; i < users.length; i++ )
        {
            if( present.contains( users[i].getNick() ) )
            {
                return true;
            }
        }
        List userList = Arrays.asList(users);
        for (String name : present)
        {
            if( userList.contains( name ) )
            {
                return true;
            }
        }

        return false;
    }

    public static boolean nickIsOp(Info info, String name, String chan)
    {
    	// System.out.println(name + " " + chan);
    	User[] currentUsers = (User[]) info.getBot().getUsers(chan);
    	for (int i=0; i<currentUsers.length; i++)
    	{
    		if (currentUsers[i].getNick().equalsIgnoreCase(name))
    			return currentUsers[i].isOp() || currentUsers[i].getNick().matches(info.getBot().getLogin());
    	}
    	return false;
    }


    /**
     * Generic function to load a text file into a List of Strings
     *
     * @param filename DOCUMENT ME!
     * @param caseSensitive DOCUMENT ME!
     *
     * @return DOCUMENT ME!
     */
    public static List<String> loadFile( String filename, boolean caseSensitive )
    {
        List<String> list = new ArrayList<String>(  );

        try
        {
            InputStream resource = filename.getClass().getClassLoader().getResourceAsStream( filename );

            if( resource == null )
            {
                log.warning( "Could not load " + filename );
                return null;
            }

            BufferedReader br = new BufferedReader( new InputStreamReader( resource ) );
            String tmp;
            tmp = br.readLine(  ); // read first line of file.

            while ( tmp != null )
            { // read a line until end of file.

                if ( caseSensitive )
                {
                    list.add( tmp );
                }
                else
                {
                    list.add( tmp.toLowerCase(  ) );
                }

                tmp = br.readLine(  );
            }
        }
        catch ( Exception e )
        {
            e.printStackTrace(  );
        }

        return list;
    }

    /**
     * DOCUMENT ME!
     */
    public static void save( List<String> list, String REPO )
    {
        try
        {
            FileWriter out = new FileWriter(REPO);
            for(String s : list)
            {
                out.write( s );
                out.write( NEWLINE );
            }
            out.close();
        }
        catch ( IOException e )
        {
            System.err.println( "Things not going as planned." );
            e.printStackTrace(  );
        } // catch
    }
}
