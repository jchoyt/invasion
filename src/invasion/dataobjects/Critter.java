/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.dataobjects;

public class Critter
{
    /**
     *  Basic constructor for Critter
     */
    public Critter()
    {
    }

    //{{{ Common class properties
    protected int id = 0;
    protected int owner = 0;
    protected int ap = 50;
    protected int hp = 30;
    protected int location = 0;
    protected int lasthurtby = 0;
    protected String description = null;
    protected String name = null;
    protected int cost = 10;
    protected int stance = 0;
    protected int attackDamage = 5;
    protected char damageType;
    protected float defendAccuracy = 0.10f;
    protected float attackAccuracy = 0.25f;
    protected int armor = 50;
    protected int shield = 0;
    protected int apmax = 0;
    protected int hpmax = 0;
    //}}}

    /**
     *  attack target
     */
    protected void attack( int targetid )
    {
    }

    /**
     *  defend owner
     */
    protected void defend()
    {
    }

    //{{{  Getters and setters
    public int getId() { return this.id; }
    public void setId(int id) { this.id = id; }
    public int getOwner() { return this.owner; }
    public void setOwner(int owner) { this.owner = owner; }
    public int getAp() { return this.ap; }
    public void setAp(int ap) { this.ap = ap; }
    public int getHp() { return this.hp; }
    public void setHp(int hp) { this.hp = hp; }
    public int getLocation() { return this.location; }
    public void setLocation(int location) { this.location = location; }
    public int getLasthurtby() { return this.lasthurtby; }
    public void setLasthurtby(int lasthurtby) { this.lasthurtby = lasthurtby; }
    public String getDescription() { return this.description; }
    public void setDescription(String description) { this.description = description; }
    public String getName() { return this.name; }
    public void setName(String name) { this.name = name; }
    public int getCost() { return this.cost; }
    public void setCost(int cost) { this.cost = cost; }
    public int getStance() { return this.stance; }
    public void setStance(int stance) { this.stance = stance; }
    public int getArmor() { return this.armor; }
    public void setArmor(int armor) { this.armor = armor; }
    public int getShield() { return this.shield; }
    public void setShield(int shield) { this.shield = shield; }
    public int getAttackDamage() { return this.attackDamage; }
    public void setAttackDamage(int attackDamage) { this.attackDamage = attackDamage; }
    public char getDamageType() { return this.damageType; }
    public void setDamageType(char damageType) { this.damageType = damageType; }
    public float getDefendAccuracy() { return this.defendAccuracy; }
    public void setDefendAccuracy(float defendAccuracy) { this.defendAccuracy = defendAccuracy; }
    public float getAttackAccuracy() { return this.attackAccuracy; }
    public void setAttackAccuracy(float attackAccuracy) { this.attackAccuracy = attackAccuracy; }
    public int getApmax() { return this.apmax; }
    public void setApmax(int apmax) { this.apmax = apmax; }
    public int getHpmax() { return this.hpmax; }
    public void setHpmax(int hpmax) { this.hpmax = hpmax; }
//}}}

    //{{{ Buffer Properties
    // :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:
    //}}}

}
