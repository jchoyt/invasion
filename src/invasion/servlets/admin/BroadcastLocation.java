/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets.admin;

import invasion.util.*;
import invasion.dataobjects.*;
import java.io.*;
import java.util.*;
import java.util.logging.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

/**
 * Sends announcement to entire location
 *
 * @author     jchoyt
 */
@WebServlet(urlPatterns = { "/admin/broadcastLocation" } )
public class BroadcastLocation extends HttpServlet
{

    public final static String KEY = BroadcastLocation.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    public BroadcastLocation()
    {
        super();
    }

    /**
     *  Standard get method.  doPost redirects here.
     *
     */
    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        String location_string = WebUtils.getRequiredParameter(request, "locid");
        String msg = WebUtils.getRequiredParameter(request, "msg");
        PrintWriter out = response.getWriter();
        InvasionConnection conn = null;
        try
        {
            int locationId = Integer.parseInt( location_string );
            conn = new InvasionConnection();
            //TODO Do stuff here

            int count = Message.locationBroadcast( conn, locationId, 3, msg );
            response.setHeader("HTTP-EQUIV","Refresh");
            response.setHeader("CONTENT", "1;URL=charList.jsp");
            if( count == 0 )
            {
                out.write("<html><body>Failed to send message to the location <br/><a href=\"charList.jsp\">Back to the character list</a></body></html>");
            }
            out.write("<html><body>Message sent to the location <br/><a href=\"charList.jsp\">Back to the character list</a></body></html>");
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            conn.close();
        }
    }


    /**
     *  Redirect to doGet()
     *
     */
    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}


