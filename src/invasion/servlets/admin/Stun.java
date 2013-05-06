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
import org.json.*;

/**
 *
 *
 * @author     jchoyt
 */
@WebServlet(urlPatterns = { "/admin/stun" } )
public class Stun extends HttpServlet
{

    public final static String KEY = Stun.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public Stun()
    {
        super();
    }

    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        PrintWriter out = response.getWriter();
        String altidString = WebUtils.getRequiredParameter(request, "id");
        String timeString = WebUtils.getRequiredParameter(request, "seconds");
        String message = WebUtils.getRequiredParameter(request, "message");
        InvasionConnection conn = null;
        try{
            int altid = Integer.parseInt(altidString);
            long seconds = Long.parseLong( timeString );
            conn = new InvasionConnection();
            Alt alt = AltFactory.load( conn, altid );
            alt.setStunned( System.currentTimeMillis() + (1000L * seconds) );
            new Message( conn, altid, Message.ETHERIAL, message );
        }
        catch(SQLException e)
        {
            log.throwing(KEY, "Error stunning someone", e);
            throw new ServletException(e);
        }
        finally
        {
            DatabaseUtility.close(conn);
        }
        response.setHeader("HTTP-EQUIV","Refresh");
        response.setHeader("CONTENT", "1;URL=charList.jsp");
        out.write("<html><body>He/she/it's been stunned <br/><a href=\"charList.jsp\">Back to the character list</a></body></html>");
    }


    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }
}


