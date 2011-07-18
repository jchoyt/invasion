/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.util;

import org.json.*;

public class Constants
{

    //{{{ Members
    public final static float ARMOR_SOAK_PERCENT = 0.5f;
    public final static float SHIELD_SOAK_PERCENT = 1.0f;
    public final static JSONObject RELOAD_REQUIRED = new JSONObject();

    static{
        try{
            RELOAD_REQUIRED.put("reload", "true");
        }catch (Exception e){}
    } //}}}

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
