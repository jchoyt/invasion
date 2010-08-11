/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.dataobjects;

import invasion.util.*;

public interface Defender
{
    public void insertMessage(String message, int type, InvasionConnection conn);

    public int getLocation();

    public String getName();

    public int getId();

    /**
     * Notifies the defener they've been hit.  Soak should be applied (or pet defensive manuevers)
     *
     * @param   attacker - who hit this defender
     * @param   rawAmount - the amount of damage before soak
     * @param   conn - an active connection to the database
     * @return
     *
     */
    public void hit( Attacker attacker, int rawAmount, InvasionConnection conn );

}
