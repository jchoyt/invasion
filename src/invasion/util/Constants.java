/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.util;

import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.*;

public class Constants
{

    public final static String KEY = Constants.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}

    //{{{ Members
    public final static float ARMOR_SOAK_PERCENT = 0.5f;
    public final static float SHIELD_SOAK_PERCENT = 1.0f;
    public final static JSONObject RELOAD_REQUIRED = new JSONObject();

    static{
        try{
            RELOAD_REQUIRED.put("reload", "true");
        }catch (Exception e){
            log.throwing(KEY, "error setting up Constants", e) ;
        }
    }

    public final static int DEAD_LOCATION = Integer.parseInt("-DEAD", 16);  //-57005
    public final static int NO_FACTION = 0;

    public final static int MIN_CHAR_ID = 0;
    public final static int MAX_CHAR_ID = 1000000;
    public final static int MIN_LOCATION_ID = MAX_CHAR_ID + 1;
    public final static int MAX_LOCATION_ID = 2000000;
    public final static int MIN_FACTION_ID = MAX_LOCATION_ID + 1;
    public final static int MAX_FACTION_ID = 3000000;;
    public final static int MIN_LOCKER_ID = MAX_FACTION_ID + 1;
    public final static int MAX_LOCKER_ID = 4000000;

	public static int HUMAN = 1;
	public static int TOHU = 2;
	public static int TIKKUN = 3;

    //}}}

    //{{{ Methods
    /**
     * Provides "he" or "she" depending on the gender.  Putting this in one place prevents having to do the damn check everywhere.
     * @param
     * @return
     *
     */
    public static String getHeShe( char gender, boolean capiltalized )
    {
        switch( gender )
        {
            case 'm':
                if(capiltalized)
                    return "He";
                else
                    return "he";
            default:
                if(capiltalized)
                    return "She";
                else
                    return "she";
        }
    }

    /**
     * Provides "his" or "hers" depending on the gender.  Putting this in one place prevents having to do the damn check everywhere.
     * @param
     * @return
     *
     */
    public static String getHisHers( char gender, boolean capiltalized )
    {
        switch( gender )
        {
            case 'm':
                if(capiltalized)
                    return "His";
                else
                    return "his";
            default:
                if(capiltalized)
                    return "Hers";
                else
                    return "hers";
        }
    }


    /**
     * Provides "his" or "hers" depending on the gender.  Putting this in one place prevents having to do the damn check everywhere.
     * @param
     * @return
     *
     */
    public static String getHimHer( char gender, boolean capiltalized )
    {
        switch( gender )
        {
            case 'm':
                if(capiltalized)
                    return "Him";
                else
                    return "him";
            default:
                if(capiltalized)
                    return "Her";
                else
                    return "her";
        }
    }
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:
