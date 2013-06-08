/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

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
 */
@WebServlet(urlPatterns = { "/admin/itemAdd" } )
public class AddItem extends HttpServlet
{

    public final static String KEY = AddItem.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public AddItem()
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


    @Override
    public void doGet( HttpServletRequest req, HttpServletResponse resp )
        throws IOException, ServletException
    {
        String vals = WebUtils.getRequiredParameter(req, "newvalues");

        //example 37,Vodka,booze,1,s,15,1d3,1,true,p,false
        String[] values = vals.split(",");

        InvasionConnection conn = null;
        PreparedStatement ps = null;
        try{
            conn = new InvasionConnection();
            String query = "insert into itemtype (name, type, weight, size, accuracy, damage, capacity, consumable, damagetype, usesammo) values (?,?,?,?,?,?,?,?,?,?)";
            ps = conn.prepareStatement(query);
            int i = 0;
            ps.setString(++i, values[i-1]);
            ps.setString(++i, values[i-1]);
            ps.setInt(++i, Integer.parseInt( values[i-1] ));
            ps.setString(++i, values[i-1]);
            ps.setInt(++i, Integer.parseInt( values[i-1] ));
            ps.setString(++i, values[i-1] );
            ps.setInt(++i, Integer.parseInt( values[i-1] ));
            ps.setBoolean(++i, Boolean.parseBoolean( values[i-1] ) );
            ps.setString(++i, values[i-1] );
            ps.setBoolean(++i, Boolean.parseBoolean( values[i-1] ) );
            ps.execute();
        }
        catch (SQLException e)
        {
            log.log(Level.WARNING, "Error editing item.", e);
        }
        finally
        {
            DatabaseUtility.close(ps);
            DatabaseUtility.close(conn);
        }
        resp.sendRedirect("itemList.jsp");
    }


    @Override
    public void doPost( HttpServletRequest req, HttpServletResponse resp )
        throws IOException, ServletException {
            //TODO Do stuff here
        }

}


