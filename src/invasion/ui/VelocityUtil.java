/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.ui;

import org.apache.velocity.app .*;
import org.apache.velocity.*;
import java.io.*;
import java.util.*;
import java.util.regex.*;
import java.util.logging.*;
import org.json.*;


public class VelocityUtil{

    public final static String KEY = VelocityUtil.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    /*  first, get and initialize an engine  */
    private static VelocityEngine ve = new VelocityEngine();

    public static void init( String templateLocation )
    {
        try
        {
            ve.setProperty("file.resource.loader.path", templateLocation );
            ve.init();
        }
        catch(Exception e)
        {
            log.throwing(KEY, "constructor", e);
        }
    }


    /**
     *  recursively converts a JSONObject into a hierarchical series of Maps and Lists
     */
    public static Object process(Object node) throws JSONException
    {
        if( node instanceof JSONObject )
        {
            JSONObject jobj = (JSONObject) node;
            Map child = new HashMap();
            Iterator keys = jobj.keys();
            while(keys.hasNext())
            {
                Object key = keys.next();
                child.put(key, process( jobj.get((String)key) ));
            }
            return child;
        }
        else if( node instanceof JSONArray )
        {
            List<JSONObject> child = new ArrayList<JSONObject>();
            //leaf node is an array of JSONObjects which better have a property matching tokens[0]
            JSONArray leaf = (JSONArray)node;
            for(int i = 0; i < leaf.length(); i++)
            {
                child.add((JSONObject) process(leaf.get(i)));
            }
            return child;
        }
        else
            return node;
    }


    /**
     *  Converts JSONObject into a hierarchical series of Maps and Lists.  Assumes the top node is *not* an array (i.e., it has names),  It can be a single object which is
     *  a name and Array, but it must have the name.
     */
    public static Map json2Map(JSONObject obj) throws JSONException
    {
        Map root = new HashMap();
        Iterator keys = obj.keys();
        while(keys.hasNext())
        {
            String key = (String)keys.next();
            root.put(key, process( obj.get((String)key)));
        }
        return root;
    }


    /**
     *  Applies template to json data and puts the results in the provided Writer
     *  @param o Input data
     *  @param template location of .vm file to be used
     *  @param writer output is written here.  Could be a StringWriter or some sort of stream
     */
    public static void applyTemplate( JSONObject o, String template, Writer writer ) throws Exception
    {
        /*  convert the JSONObject to a Map */
        Map converted = json2Map( o );
        /*  add that to a VelocityContext  */
        VelocityContext context = new VelocityContext(converted);
        // context.put("context", converted);
        /*  get the Template  */
        Template t = ve.getTemplate( template );
        /*  now render the template into a Writer  */
        t.merge( context, writer );
    }


}
