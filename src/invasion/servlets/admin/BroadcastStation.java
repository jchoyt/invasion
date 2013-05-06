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

/**
 * Sends announcement to entire station
 *
 * @author     jchoyt
 */
@WebServlet(urlPatterns = { "/admin/broadcastStation" } )
public class BroadcastStation extends HttpServlet
{

    public final static String KEY = BroadcastStation.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    public BroadcastStation()
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
        String station_string = WebUtils.getRequiredParameter(request, "station");
        String type_string = WebUtils.getRequiredParameter(request, "type");
        String msg = WebUtils.getRequiredParameter(request, "msg");
        PrintWriter out = response.getWriter();
        InvasionConnection conn = null;
        try
        {
            int stationId = Integer.parseInt( station_string );
            int typeId = Integer.parseInt( type_string );
            conn = new InvasionConnection();
            //TODO Do stuff here

            int count = Message.stationBroadcast( conn, stationId, typeId, msg );
            response.setHeader("HTTP-EQUIV","Refresh");
            response.setHeader("CONTENT", "1;URL=stationList.jsp");
            if( count == 0 )
            {
                out.write("<html><body>Failed to send message to the station <br/><a href=\"stationList.jsp\">Back to the station list</a></body></html>");
            }
            out.write("<html><body>Message sent to the station <br/><a href=\"stationList.jsp\">Back to the station list</a></body></html>");
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


