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
 */
@WebServlet(urlPatterns = { "/map/chalk" } )
public class Chalk extends HttpServlet
{

    public final static String KEY = Chalk.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public Chalk()
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
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        String message = WebUtils.getRequiredParameter(request, "message");

        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        String type = "chalk";
        String action = "wrote";

        if( message.startsWith("!draw " ) )
        {
            type = "draw";
            message = message.substring("!draw ".length());
            action = "drew";
        }
        else if( message.startsWith("!scrawl " ) )
        {
            type = "scrawl";
            message = message.substring("!scrawl ".length());
            action = "scrawled";
        }

        InvasionConnection conn = null;
        PreparedStatement ps = null;
        try{
            conn = new InvasionConnection();
            String query = "update location set messagetype=?, message=? where id=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, type );
            ps.setString(2, message );
            ps.setInt(3, wazzit.getAlt().getLocation());
            ps.execute();
            DatabaseUtility.close(ps);
            Message.locationBroadcast( conn, wazzit.getAlt().getLocation(), Message.NORMAL, wazzit.getAlt().getName() + " " + action + " something on the wall.", wazzit.getAlt().getId() );
            ActionLog.addAction( wazzit.getAlt().getId(), ActionLog.WROTE, wazzit.getAlt().getLocation() );

        }
        catch (SQLException e)
        {
            Logger log = Logger.getLogger( "chalkProcess.jsp" );
            log.log(Level.WARNING, "Error adding writing to the wall", e);
        }
        finally
        {
            DatabaseUtility.close(ps);
            DatabaseUtility.close(conn);
        }
        response.sendRedirect(WebUtils.BASE + "map/index.jsp");
    }


    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}


