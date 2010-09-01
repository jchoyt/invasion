/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.dataobjects;

import org.json.*;
import invasion.util.*;

public interface Attacker
{
    /**
     * Performs an attack.
     * @param  defender - target of the attack
     * @param  conn - existing database connection
     * @return  Any alters (e.g. your target has moved away) for the user
     *
     */
    public JSONArray attack(Defender defender, InvasionConnection conn );

    public int getLocation();

    public void insertMessage(String message, int type, InvasionConnection conn);

    public int getId();

}
