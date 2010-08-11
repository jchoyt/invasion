/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import java.io.*;
import java.util.*;
import java.util.logging.*;
import invasion.dataobjects.*;
import invasion.util.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;

public class MoveServlet extends HttpServlet
{
    public final static String KEY = "MoveServlet";  //change to MoveServlet eventually
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    int[] xdelta = { -1, 0, 1, -1, 0, 1, -1, 0, 1};
    int[] ydelta = { -1, -1, -1, 0, 0, 0, 1, 1, 1};

    /**
     *  Description of the Method
     *
     *@param  config                Description of the Parameter
     *@exception  ServletException  Description of the Exception
     */
    public void init( ServletConfig config )
        throws ServletException
    {
        /*
         *  required for all Servlets
         */
        super.init( config );
    }

    protected void setNewLoc(InvasionConnection conn, int locid, int altid)
    {
        Integer[] params = {locid, altid};
        log.entering(KEY, "setNewLoc", params);
        String query = "update alt set location = ? where id = ?";
        PreparedStatement ps = null;
        try{
            ps = conn.prepareStatement(query);
            ps.setInt(1,locid);
            ps.setInt(2, altid);
            int count = ps.executeUpdate();
            log.finer("did query - updated number of rows = " + count);
        }
        catch(Exception e)
        {
            log.throwing(KEY, "setNewLoc", e);
        }
        finally
        {
            DatabaseUtility.close(ps);
        }
    }


    /**
     *  Description of the Method
     *
     *@param  req                   Description of the Parameter
     *@param  resp                  Description of the Parameter
     *@exception  ServletException  Description of the Exception
     *@exception  IOException       Description of the Exception
     */
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws ServletException, IOException
    {
        // put current location in sesion memory  String start = WebUtils.getRequiredParameter(request, "start");
        // don't wnat destination...want movement direction  String dest = WebUtils.getRequiredParameter(request, "dest");
        String direction = WebUtils.getRequiredParameter(request, "dir");
        int dir = Integer.parseInt(direction);
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        if( wazzit==null)
        {
            //not logged in
            log.warning("User not logged in.");
            response.sendRedirect("/index.jsp");
            return;
        }


        int altid = wazzit.getAlt().getId();
        int locid = wazzit.getAlt().getLocation();

        log.finer("old location: " + locid);
        boolean valid = true;

        String query = "select * from location l where (station, level, x, y) in (select station, level, x + " + xdelta[dir] + ", y + " + ydelta[dir] + " from location s where id=?)";
        log.finer( query );

        InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            conn = new InvasionConnection();
            ps =  conn.prepareStatement(query);
            ps.setInt(1,locid);
            rs = ps.executeQuery();
            if(rs.next())
            {
                locid = rs.getInt("id");
                //DO CHECKS FOR VALID destinations here
                log.finer("new location: " + locid);
                setNewLoc(conn, locid, altid );
                wazzit.getAlt().setLocation(locid);
                wazzit.getAlt().setLocationType(rs.getInt("typeid"));
                wazzit.getAlt().decrementAp(conn, 1);
            }
            else
            {
                log.severe("Location not found!");
                response.sendRedirect("/naughty.jsp");
                return;
            }
        }
        catch(Exception e)
        {
            log.throwing(KEY, "body", e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            conn.close();
        }
        response.sendRedirect("index.jsp");
    }


    /**
     *  Description of the Method
     *
     *@param  req                   Description of the Parameter
     *@param  resp                  Description of the Parameter
     *@exception  ServletException  Description of the Exception
     *@exception  IOException       Description of the Exception
     */
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws ServletException, IOException
    {
        response.sendRedirect("/naughty.jsp");
    }

}
