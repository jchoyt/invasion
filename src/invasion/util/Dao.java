package invasion.util;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.*;
import java.util.*;
import java.sql.*;
import invasion.dataobjects.Alt;
import invasion.dataobjects.Item;

/**
 *  All objects should be created and accessed through here.
 */

public class Dao
{

    // public static Item getItem(int itemid, InvasionConnection conn)
    // {
    //     String query = "select * from item where itemid = ?";
    //     PreparedStatement ps = null;
    //     ResultSet rs = null;
    //     Item ret = new Item();
    //     try
    //     {
    //         ps = conn.prepareStatement(query);
    //         ps.setInt(1,itemid);
    //         rs = ps.executeQuery();
    //         if(rs.next())
    //         {
    //             ret.setItemid( itemid );
    //             ret.setItemtype( rs.getInt("typeid") );
    //             ret.setLocid( rs.getInt("locid") );
    //             ret.setAmmoleft( rs.getInt("ammoleft") );
    //             ret.setCapacitymod( rs.getInt("capacitymod") );
    //             ret.setCondition( rs.getInt("condition") );
    //             return ret;
    //         }
    //         else
    //             return null;
    //     }
    //     catch(SQLException e)
    //     {
    //         log.throwing( KEY, "Exception retrieving item " + itemid, e);
    //         return null;
    //     }
    //     finally
    //     {
    //         DatabaseUtility.close(rs);
    //         DatabaseUtility.close(ps);
    //     }
    // }

}
