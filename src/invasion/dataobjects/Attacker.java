/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.dataobjects;

import org.json.*;
import invasion.util.*;

public interface Attacker
{

    public JSONArray attack(Defender defender, InvasionConnection conn );

    public int getLocation();

    public void insertMessage(String message, int type, InvasionConnection conn);

    public int getId();

}
