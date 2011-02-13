/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.dataobjects;

import invasion.util.*;
import java.sql.SQLException;

public interface Defender
{
    public void insertMessage(String message, int type, InvasionConnection conn);

    public int getLocation();

    public String getName();

    public int getId();

    public void kill() throws SQLException;

    public void kill( InvasionConnection conn ) throws SQLException;

    /**
     * Notifies the defender they've been hit.  Soak should be applied (or pet defensive manuevers).
     *
     * @param   attacker - who hit this defender
     * @param   rawAmount - the amount of damage before soak
     * @param   conn - an active connection to the database
     * @return  final amount of damage done
     *
     */
    public int hit( Attacker attacker, int rawAmount, InvasionConnection conn ) throws SQLException;

    public void notifyAttacked( Attacker attacker, InvasionConnection conn );

}
