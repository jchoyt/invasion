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

    public void kill(CombatResult result) throws SQLException;

    public void kill( InvasionConnection conn, CombatResult result ) throws SQLException;

    /**
     * Notifies the defender they've been hit.  Soak should be applied (or pet defensive manuevers).
     *
     * @param   attacker - who hit this defender
     * @param   rawAmount - the amount of damage before soak
     * @param   conn - an active connection to the database
     * @return  Object cotnaining the results of the hit
     *
     */
    public CombatResult hit( Attacker attacker, int rawAmount, char damagetype, InvasionConnection conn, boolean updateNow ) throws SQLException;

    public void notifyAttacked( Attacker attacker, InvasionConnection conn );

    public int getDodgeLevel();

    public int getHp();

    /**
     * Sets the time for the defender to become unstunned
     * @param   stunned time the defender becomes unstunned - compare to System.currentTimeMills()
     *
     */
	public void setStunned(long stunned);
	public long getStunned();

    public int getFactionid();
}
