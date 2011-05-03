/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import java.util.*;

public class CombatResult
{

    //{{{ Members
	protected int armorSoak = 0;
	protected int shieldSoak = 0;
	protected List<String> attackerMessages = new ArrayList<String>();
	protected int damageDone = 0;
    //}}}

    //{{{ Constuctors
    private CombatResult(){};

    public CombatResult(int rawDamage)
    {
        damageDone = rawDamage;
    }

    /**
     * Increments the amount of damage soaked by armor and decrement the damage done by this attack.
     */
    public void setArmorSoak(int armorSoak)
	{
        this.armorSoak += armorSoak;
        damageDone -= armorSoak;
	}

    /**
     * Increments the amount of damage soaked by shields and decrement the damage done by this attack.
     */
	public void setShieldSoak(int shieldSoak)
	{
	    this.shieldSoak += shieldSoak;
	    damageDone -= shieldSoak;
	}
    //}}}

    //{{{ Methods
    public void addMessage(String msg)
    {
        attackerMessages.add(msg);
    }
    //}}}

    //{{{ Getters and Setters
	public int getArmorSoak() { return this.armorSoak; }
	public int getShieldSoak() { return this.shieldSoak; }
	public List<String> getAttackerMessages() { return this.attackerMessages; }
    public int getDamageDone() { return this.damageDone; }
	public void setDamageDone(int damageDone) { this.damageDone = damageDone; }
	//}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

