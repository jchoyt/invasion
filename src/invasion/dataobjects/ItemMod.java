/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import invasion.util.*;
import java.sql.*;

/**
 * Cumulative modifications for an item
 */
public class ItemMods
{

    //{{{ Members
    /**
     * For weapon enhancements and defects
     */
	protected float scaleDamage = 0.0f;
	protected float scaleAccuracy = 0.0f;
	protected float misfireRate = 0.0f;
	protected float shortCircuitRate = null;
	protected float shortCircuitRate = null;
	protected float backFireRate = null;
	protected int weightReduction = 0;
	protected int fireDamage = 0;
	protected int acidDamage = 0;
	protected int electricalDamage = 0;
    //}}}

    //{{{ Constuctors
    //}}}

    //{{{ Methods
    public static load( InvasionConnection conn, int itmeid )
    {
    }
    //}}}

    //{{{ Getters and Setters
	public float getScaleDamage() { return this.scaleDamage; }
	public void setScaleDamage(float scaleDamage) { this.scaleDamage = scaleDamage; }
	public float getScaleAccuracy() { return this.scaleAccuracy; }
	public void setScaleAccuracy(float scaleAccuracy) { this.scaleAccuracy = scaleAccuracy; }
	public float getMisfireRate() { return this.misfireRate; }
	public void setMisfireRate(float misfireRate) { this.misfireRate = misfireRate; }
	public float getShortCircuitRate() { return this.shortCircuitRate; }
	public void setShortCircuitRate(float shortCircuitRate) { this.shortCircuitRate = shortCircuitRate; }
	public float getShortCircuitRate() { return this.shortCircuitRate; }
	public void setShortCircuitRate(float shortCircuitRate) { this.shortCircuitRate = shortCircuitRate; }
	public float getBackFireRate() { return this.backFireRate; }
	public void setBackFireRate(float backFireRate) { this.backFireRate = backFireRate; }
	public int getWeightReduction() { return this.weightReduction; }
	public void setWeightReduction(int weightReduction) { this.weightReduction = weightReduction; }
	public int getFireDamage() { return this.fireDamage; }
	public void setFireDamage(int fireDamage) { this.fireDamage = fireDamage; }
	public int getAcidDamage() { return this.acidDamage; }
	public void setAcidDamage(int acidDamage) { this.acidDamage = acidDamage; }
	public int getElectricalDamage() { return this.electricalDamage; }
	public void setElectricalDamage(int electricalDamage) { this.electricalDamage = electricalDamage; }
   //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

