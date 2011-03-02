/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.pets;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
import invasion.dataobjects.*;
import invasion.util.*;

public class CritterFactory
{

    public final static String KEY = CritterFactory.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    //{{{ Members
    //}}}

    //{{{ Constuctors
    //}}}

    //{{{ Methods
	public static Critter loadCritter( InvasionConnection conn, int id )
	{
	    String query = "select class, b.id as id, ap, hp, armor, shield, typeid, c.name, location  from critters c join crittertype t on c.typeid=t.id join brood b on c.brood=b.id where c.id=?";
        ResultSet rs = null;
        Critter ret = null;
        try
        {
            rs = conn.psExecuteQuery(query, "Error message", id);
            if(rs.next())
            {
                Class clazz = Class.forName( rs.getString("class") );
                ret = (Critter)clazz.newInstance();
                ret.setId( id );
                ret.setAp( rs.getInt("ap"));
                ret.setHp( rs.getInt("hp"));
                // ret.setHp( rs.getInt("hp"));
                ret.setArmor( rs.getInt("armor"));
                ret.setShield( rs.getInt("shield"));
                ret.setName( rs.getString("name"));
                ret.setTypeid( rs.getInt("typeid"));
                ret.setLocation( rs.getInt("location"));
                //TODO get this working for player broods as well
                ret.setBrood( BroodManager.getFeralBrood(rs.getInt("id")));
            }
            else
            {
                //throwsome error
            }
            DatabaseUtility.close(rs);
        }
        catch(Exception e)
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
    //}}}

    //{{{ Getters and Setters
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

