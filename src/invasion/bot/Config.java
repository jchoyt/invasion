/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.bot;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.*;
import java.io.*;
import java.lang.reflect.Array;


/**
 *  This class acts like a Properties object, but it can hold multiple Strings for one key
 *
 *@author     jchoyt
 *@created    February 2, 2001
 */
public final class Config extends Object implements Serializable
{

    public final static String KEY = Config.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}
    private HashMap<String,String[]> nvPairs;
    public static int RANDOM_PRIME_NUMBER = 215;

    /**
     *  Constructor for the Config object
     *
     *@since    1.2
     */
    public Config()
    {
        nvPairs = new HashMap<String,String[]>();
    }

    public Config(InputStream is)
    {
        nvPairs = new HashMap<String,String[]>();
        load(is);
    }


    protected void load(InputStream is)
    {
        try
        {
            BufferedReader br = new BufferedReader( new InputStreamReader( is ) );
            String tmp;
            String line = br.readLine(  ); // read first line of file.

            while ( line != null )
            { // read a line until end of file.
                line = line.trim();
                // If empty line or begins with a comment character, skip this line.
                if (line.length() == 0 || line.charAt(0) == '#' || line.charAt(0) == '!')
                {
                    line = br.readLine(  );
                    continue;
                }

                // The characters up to the next Whitespace, ':', or '='
                // describe the key.
                int delimLoc = line.indexOf("=");
                String key = line.substring( 0, delimLoc ).trim();
                String value = line.substring(delimLoc + 1).trim();
                setValue( key, value );

                line = br.readLine(  );
            }
        }
        catch ( Exception e )
        {
            e.printStackTrace(  );
        }
        log.info( toString() );
    }

    /**
     *  * Adds a new name value pair to the internal hashmap. The form should be
     *  pre-parser, e.g., name=FilterAfterTheFact
     *  value=Table:thisTable~Field:dayOfWeek~Operator:!=~Value:Friday
     *
     *@param  name   The new Value value
     *@param  value  The new Value value
     *@since         1.2
     */
    public void setValue( String name, String value )
    {
        String[] test = nvPairs.get( name );
        String[] newValues;
        int origLength;

        if ( test == null )
        {
            //no item was there
            newValues = new String[1];

        //value = MiscUtils.checkApostrophe(value);

            newValues[0] = value;

        }
        else
        {
            //append to the Array
            origLength = Array.getLength( test );
            newValues = new String[origLength + 1];
            System.arraycopy( test, 0, newValues, 0, origLength );
            newValues[newValues.length - 1] = value;
        }

        nvPairs.put( name, newValues );
    }


    public HashMap<String,String[]> getNVPairs()
	{
		return nvPairs;
	}

    /**
     *  Gets the Props attribute of the Config object
     *
     *@return    The Props value
     *@since     1.2
     */
    public String getProps()
    {
        return nvPairs.toString();
    }

    /**
     *  Gets the Props attribute of the Config object
     *
     *@return    The Props value
     *@since     1.2
     */
    public int getSize()
    {
        return nvPairs.size();
    }


    /**
     *  Gets just the first object for the passed array
     *
     *@param  name  Description of Parameter
     *@return       The Value value
     *@since        1.2
     */
    public String getValue( String name )
    {
        String[] returnVal = nvPairs.get( name );
        if( returnVal == null )
        {
            return null;
        }
        else
            return returnVal[0];
    }

    /**
     *  Gets all the objects for the passed array
     *
     *@param  name  Description of Parameter
     *@return       The Value value
     *@since        1.2
     */
    public String[] getValues( String name )
    {
        return nvPairs.get( name );
    }


    /**
     *  This method clears the name-value pairs from the Config
     *
     *@since
     */
    public void clearNvPairs()
    {
        nvPairs.clear();
    }


    /**
     *  Description of the Method
     *
     *@return    Description of the Return Value
     */
    public String nameValuesToString()
    {
        StringBuffer ret = new StringBuffer();
        Iterator iter = nvPairs.keySet().iterator();
        while ( iter.hasNext() )
        {
            String key = ( String ) iter.next();
			if ( key.toLowerCase().indexOf( "password" ) == -1 )
            {
				String[] values = nvPairs.get( key );
				ret.append( "\n\t" );
				ret.append( key );
				ret.append( "=" );
				for ( int i = 0; i < values.length; i++ )
				{
					if ( i > 0 )
					{
						ret.append( "; " );
					}
					ret.append( values[i] );
				}
			}
        }
        return ret.toString();
    }


    /**
     *  Removes a name/value pair from nvPairs
     *
     *@param  key  The key of the pair to be removed
     *@since       1.2
     */
    public void removeValue( String key )
    {
        nvPairs.remove( key );
    }


    /**
     *  Lists, in text form, the critical information stored
     *
     *@return    Text representation of the critical contents
     */
    public String toString()
    {
        StringBuffer ret = new StringBuffer();
        ret.append( "\nName.Value pairs stored:" );
        if ( nvPairs.size() == 0 )
        {
            ret.append( "none." );
        }
        else
        {
            ret.append( nameValuesToString() );
        }
        return ret.toString();
    }
}
