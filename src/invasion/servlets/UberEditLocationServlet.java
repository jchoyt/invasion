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
 * @created
 */
@WebServlet(urlPatterns = { "/admin/uberEditLocation" } )
public class UberEditLocationServlet extends HttpServlet
{

    public final static String KEY = UberEditLocationServlet.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public UberEditLocationServlet()
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
        String locid = WebUtils.getRequiredParameter(request, "locid");
        String name = WebUtils.getRequiredParameter(request, "name");
        String type = WebUtils.getRequiredParameter(request, "type");
        String desc = WebUtils.getRequiredParameter(request, "desc");
        String station = WebUtils.getRequiredParameter(request, "station");

        InvasionConnection conn = null;
        PreparedStatement ps = null;
        try{
            conn = new InvasionConnection();
            String query = "update location set name=?, typeid=?, description=? where id=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setInt(2, Integer.parseInt( type ));
            ps.setString(3, desc);
            ps.setInt(4, Integer.parseInt(locid));
            ps.execute();
        }
        catch (SQLException e)
        {
            Logger log = Logger.getLogger( "AdminMap.tag" );
            log.log(Level.WARNING, "Error editing location " + locid, e);
        }
        finally
        {
            DatabaseUtility.close(ps);
            DatabaseUtility.close(conn);
        }
        response.sendRedirect( "fullStationView.jsp?id=" + station );
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


