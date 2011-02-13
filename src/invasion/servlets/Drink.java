/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.ui.NaughtyException;
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
@WebServlet(urlPatterns = { "/map/drink" } )
public class Drink extends HttpServlet
{

    public final static String KEY = Drink.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the PqmServlet object
     *
     * @since
     */
    public Drink()
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
        String itemid = WebUtils.getRequiredParameter(request, "itemid");
        int id = Integer.parseInt(itemid);
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        //do DB inserts
        String query = "delete from item where itemid = ? and locid = ?";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        try{
            conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            String category = Item.getCategory(conn, id);
            String itemName = Item.getName(conn, id);
            if( !category.equals("booze") )
            {
                throw new NaughtyException("That does not seem to be alcohol.");
            }
            ps.setInt(1, id);
            ps.setInt(2, wazzit.getAlt().getId());
            int count = ps.executeUpdate();
            if( count == 1 )
            {
                Stats.addChange(wazzit.getAlt().getId(), Stats.BOOZE, 1);
            }
            else
                throw new NaughtyException("What are you trying to do?");

            // inventory = Item.getItems(conn, wazzit.getAlt().getId());
            // out.write(String.valueOf(inventory));
            wazzit.getAlt().decrementAp(conn, 1);
            new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You open the " +  itemName + " and start drinking.  All too soon, it's gone.");

            //TODO death by alcohol poisoning
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            DatabaseUtility.close(ps);
            Poll.fullPoll( conn, out, wazzit, null );
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


