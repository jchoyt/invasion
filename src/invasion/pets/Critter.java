/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.pets;

import org.json.*;
import invasion.util.*;
import invasion.dataobjects.*;

public class Critter implements Attacker, Defender
{
    //{{{ Constructors
    /**
     *  Basic constructor for Critter
     */
    public Critter()
    {
    } //}}}

    //{{{ Common class properties
    protected String description = null;
    protected String name = null;
    protected char damageType;
    protected float attackAccuracy = 0.40f;
    protected float defendAccuracy = 0.10f;
    protected int ap = 50;
    protected int apmax = 50;
    protected int armor = 50;
    protected int armorMax = 50;
    protected int attackDamage = 5;
    protected int cost = 10;
    protected int hp = 30;
    protected int hpmax = 0;
    protected int id = 0;
    protected int lasthurtby = 0;
    protected int shield = 0;
    protected int shieldMax = 0;
    //}}}

    //{{{ Methods
    /**
     *  If this Critter gets control of a brood, what are his priorities?
     */
    public void setBroodGoals( Brood brood ){}
    //}}}

    //{{{ For Defender interface
    public void insertMessage(String message, int type, InvasionConnection conn){}

    public int getLocation() {return -1;}

    public void hit( Attacker attacker, int rawAmount, InvasionConnection conn ){}

    //}}}

    //{{{ For Attacker interface
    public JSONArray attack(Defender defender, InvasionConnection conn ){ return null;}
    //}}}


    //{{{  Getters and setters
    public String getDescription() { return this.description; }
    public String getName() { return this.name; }
    public char getDamageType() { return this.damageType; }
    public float getAttackAccuracy() { return this.attackAccuracy; }
    public float getDefendAccuracy() { return this.defendAccuracy; }
    public int getAp() { return this.ap; }
    public int getApmax() { return this.apmax; }
    public int getArmor() { return this.armor; }
    public int getAttackDamage() { return this.attackDamage; }
    public int getCost() { return this.cost; }
    public int getHp() { return this.hp; }
    public int getHpmax() { return this.hpmax; }
    public int getId() { return this.id; }
    public int getLasthurtby() { return this.lasthurtby; }
    public int getShield() { return this.shield; }
    public void setAp(int ap) { this.ap = ap; }
    public void setApmax(int apmax) { this.apmax = apmax; }
    public void setArmor(int armor) { this.armor = armor; }
    public void setAttackAccuracy(float attackAccuracy) { this.attackAccuracy = attackAccuracy; }
    public void setAttackDamage(int attackDamage) { this.attackDamage = attackDamage; }
    public void setCost(int cost) { this.cost = cost; }
    public void setDamageType(char damageType) { this.damageType = damageType; }
    public void setDefendAccuracy(float defendAccuracy) { this.defendAccuracy = defendAccuracy; }
    public void setDescription(String description) { this.description = description; }
    public void setHp(int hp) { this.hp = hp; }
    public void setHpmax(int hpmax) { this.hpmax = hpmax; }
    public void setId(int id) { this.id = id; }
    public void setLasthurtby(int lasthurtby) { this.lasthurtby = lasthurtby; }
    public void setName(String name) { this.name = name; }
    public void setShield(int shield) { this.shield = shield; }
//}}}

}
// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:
