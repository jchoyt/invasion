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
@WebServlet(urlPatterns = { "/map/drop" } )
public class Drop extends HttpServlet
{

    public final static String KEY = Drop.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public Drop()
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
        String[] itemids = WebUtils.getRequiredParameterValues(request, "itemid");
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        int altid = wazzit.getAlt().getId();
        String query = "delete from item where itemid = ? and locid = ? and equipped='f'";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        JSONArray alerts = new JSONArray();
        try{
            conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            for( String itemid : itemids )
            {
                int id = Integer.parseInt(itemid);
                String itemName = Item.getName(conn, id);
                if( itemName == null )
                {
                    alerts.put( Poll.createErrorAlert("You do not own that item.") );
                    return;
                }
                ps.setInt(1, Integer.parseInt(itemid));
                ps.setInt(2, altid);
                ps.executeUpdate();
                //TODO drop a random object if count==0
                new Message( conn, altid, Message.NORMAL, "You drop your " + itemName + ".");
            }
        }
        catch(Exception e)
        {
            log.log( Level.SEVERE, "Error dropping items.", e );
            alerts.put( Poll.createErrorAlert("You, apparently, can't even drop stuff on the floor correctly.") );
            return;
        }
        finally
        {
            DatabaseUtility.close(ps);
            Poll.fullPoll( conn, out, wazzit, alerts );
            DatabaseUtility.close(conn);
            // out.write(String.valueOf(inventory));
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


