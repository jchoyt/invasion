/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.util.*;
import invasion.dataobjects.*;
import java.io.*;
import java.util.*;
import java.util.logging.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import org.json.*;

/**
 *
 *
 * @author     jchoyt
 * @created
 */
@WebServlet(urlPatterns = { "/map/equip" } )
public class Equip extends HttpServlet
{

    public final static String KEY = Equip.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the PqmServlet object
     *
     * @since
     */
    public Equip()
    {
        super();
    }



    /**
     *  Description of the Method
     *
     * @param  config                Description of the Parameter
     * @exception  ServletException  Description of the Exception
     */
    public void init( ServletConfig config )
        throws ServletException
    {
        log.entering( KEY, "init" );
        /*
         *  required for all Servlets
         */
        super.init( config );
    }


    /**
     *  Description of the Method
     *
     */
    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        PrintWriter out = response.getWriter();
        String itemid = WebUtils.getRequiredParameter(request, "weaponid");
        int id = Integer.parseInt(itemid);
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        //do DB inserts
        String query = "select * from item i join itemtype t on i.typeid=t.typeid where itemid = ? and locid = ? and type='weapon'";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean newWeaponNeedsAmmo = false;
        JSONObject inventory = null;
        try{
            conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ps.setInt(2, wazzit.getAlt().getId());
            rs = ps.executeQuery();
            String weaponName = null;
            if( rs.next() )
            {
                weaponName = rs.getString("name");
                newWeaponNeedsAmmo = rs.getBoolean("usesammo");
            }
            else
                response.sendRedirect( "/map/index.jsp?error=That item is not a weapon or you do not own it.");
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            //do both updates in one statement
            query = "update alt set equippedweapon = ? where id = ?;update item set equipped='f' where locid = ?;update item set equipped='t' where itemid = ?";
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ps.setInt(2, wazzit.getAlt().getId());
            ps.setInt(3, wazzit.getAlt().getId());
            ps.setInt(4, id);
            ps.execute();
            wazzit.getAlt().setEquippedWeapon( id );
            //update wazzit - weapon name, ammo, etc
            DatabaseUtility.close(ps);
            //now decrement AP
            wazzit.getAlt().decrementAp(conn, 1);
            new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You switch your equipped weapon. You will now use your " + weaponName + ".");
            response.sendRedirect( "/map/index.jsp" );
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            DatabaseUtility.close(ps);
            DatabaseUtility.close(conn);
        }
    }


    /**
     *  Description of the Method
     *
     */
    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}


