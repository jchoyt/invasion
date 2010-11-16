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
    }
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:
