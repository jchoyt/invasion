/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.dataobjects.*;
import org.json.*;
import invasion.util.*;
import java.io.*;
import java.util.*;
import java.util.logging.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

/**
 *
 *
 * @author     jchoyt
 * @created
 */
@WebServlet(urlPatterns = { "/map/unequip" } )
public class Unequip extends HttpServlet
{

    public final static String KEY = Unequip.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the PqmServlet object
     *
     * @since
     */
    public Unequip()
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
            }
            else
            {
                response.sendRedirect( "/map/index.jsp?error=That item is not a weapon or you do not own it.");
                return;
            }
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            //do both updates in one statement
            query = "update alt set equippedweapon = ? where id = ?;update item set equipped='f' where itemid = ?";
            ps = conn.prepareStatement(query);
            ps.setNull(1, Types.INTEGER);
            ps.setInt(2, wazzit.getAlt().getId());
            ps.setInt(3, id);
            ps.execute();
            wazzit.getAlt().setEquippedWeapon( id );
            DatabaseUtility.close(ps);
            //now decrement AP
            wazzit.reload();
            wazzit.getAlt().decrementAp(conn, 1);
            new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You have unequipped your " + weaponName + ".");
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


