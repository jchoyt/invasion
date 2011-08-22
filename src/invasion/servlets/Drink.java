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
     *  Constructor for the Servlet object
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
     *  Imbibe the alcohol and suffer the consequences.
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
        Alt alt = wazzit.getAlt();
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
                throw new NaughtyException("That does not seem to be something to drink.");
            }
            ps.setInt(1, id);
            ps.setInt(2, alt.getId());
            int count = ps.executeUpdate();
            if( count == 1 )
            {
                Stats.addChange(alt.getId(), Stats.BOOZE, 1);
            }
            else
                throw new NaughtyException("What are you trying to do?");

            // out.write(String.valueOf(inventory));
            alt.heal( 2 );
            alt.healIp( 1 );
            //the AP decrement below will save this change
            alt.decrementAp(conn, 1);
            new Message( conn, alt.getId(), Message.NORMAL, "You open the " +  itemName + " and start drinking.  As you finish, you feel a bit better.");

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


