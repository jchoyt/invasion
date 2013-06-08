/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;

import java.util.logging.Level;
import java.util.logging.Logger;
import invasion.util.*;
import java.sql.*;

/**
 * Cumulative modifications for an item
 */
public class ItemMods
{

    public final static String KEY = ItemMods.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    //{{{ Members
    /**
     * For weapon enhancements and defects
     */
	protected float scaleDamage = 1.0f;
	protected float scaleAccuracy = 1.0f;
	protected float misfireRate = 0.0f;
	protected float shortCircuitRate = 0.0f;
	protected float backFireRate = 0.0f;
	protected int weightChange = 0;
	protected int fireDamage = 0;
	protected int acidDamage = 0;
	protected int electricalDamage = 0;
    //}}}

    //{{{ Constuctors
    //}}}

    //{{{ Methods
    /**
     * Loads item mods for an item from the database and calculates their cumulative effects.  This should only appy to weapons.  Except maybe for lightening armor?
     * I'm not at all happy with the massive if-them-else below, but it's what I have at the moment.  Java 7 should allow this to go to a switch statement.  I
     * can't justify the code necessary for a class/polymorphism solution.
     */
    public static ItemMods load( InvasionConnection conn, int itemid )
        throws BotReportException
    {
        ItemMods ret = new ItemMods();
        String query = "select * from itemmod m join modtype t on m.type=t.id where itemid=?";
        ResultSet rs = null;
        try
        {
            rs = conn.psExecuteQuery(query, "Error pulling item modifications", itemid);
            while(rs.next())
            {
                String effect = rs.getString("effect");
                float amount = rs.getFloat("amount");
                boolean fault = rs.getBoolean("fault");
                //process
                if( effect.equals("scale accuracy") )
                {
                    ret.scaleAccuracy = adjustScale( ret.scaleAccuracy, amount );
                }
                else if( effect.equals("scale damage") )
                {
                    ret.scaleDamage = ret.scaleDamage * amount;
                }
                else if( effect.equals("backfire") )
                {
                    ret.backFireRate = adjustScale( ret.backFireRate, amount );
                }
                else if( effect.equals("weight change") )
                {
                    ret.weightChange += (int)amount;
                }
                else if( effect.equals("misfire") )
                {
                    ret.misfireRate = 1-adjustScale( 1.0f-ret.misfireRate, amount );
                }
                else if( effect.equals("short circuit") )
                {
                    ret.shortCircuitRate = 1-adjustScale( 1.0f-ret.shortCircuitRate, amount );
                }
                else if( effect.equals("acid damage") )
                {
                    ret.acidDamage += (int)amount;
                }
                else if( effect.equals("electrical damage") )
                {
                    ret.electricalDamage += (int)amount;
                }
                else if( effect.equals("fire damage") )
                {
                    ret.fireDamage += (int)amount;
                }
                else //NEW TYPE!  PANIC TIME!
                {
                    throw new BotReportException( "A new item modification type was detected in the database.  " + effect + " is not handled in the code in invasion.dataobjects.ItemMods.  Check item " + itemid );
                }
            }
            DatabaseUtility.close(rs);
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
        }

        return ret;
    }

    /**
     * Used to scale occurance rates.
     * @param  base - the current baseline - this is what will be adjusted
     * @param amount - the value from the database representing the amount to geometrically adjust the base
     * @return  new value of the base
     *
     */
    public static float adjustScale( float base, float amount )
    {
        return base * (1.0f - amount );
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
	public float getBackFireRate() { return this.backFireRate; }
	public void setBackFireRate(float backFireRate) { this.backFireRate = backFireRate; }
	public int getWeightChange() { return this.weightChange; }
	public void setWeightChange(int weightChange) { this.weightChange = weightChange; }
	public int getFireDamage() { return this.fireDamage; }
	public void setFireDamage(int fireDamage) { this.fireDamage = fireDamage; }
	public int getAcidDamage() { return this.acidDamage; }
	public void setAcidDamage(int acidDamage) { this.acidDamage = acidDamage; }
	public int getElectricalDamage() { return this.electricalDamage; }
	public void setElectricalDamage(int electricalDamage) { this.electricalDamage = electricalDamage; }
   //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

