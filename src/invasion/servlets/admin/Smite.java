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
 * @created
 */
@WebServlet(urlPatterns = { "/admin/smite" } )
public class Smite extends HttpServlet
{

    public final static String KEY = Smite.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public Smite()
    {
        super();
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
        String altidString = WebUtils.getRequiredParameter(request, "id");
        String message = WebUtils.getRequiredParameter(request, "message");
        String query = "update alt set hp=0, lasthurtby=null where id=?";
        InvasionConnection conn = null;
        try{
            int altid = Integer.parseInt(altidString);
            conn = new InvasionConnection();
            Alt alt = Alt.load( conn, altid );
            int count =  conn.psExecuteUpdate(query, "", altid);
            new Message( conn, altid, Message.EFFECT, message );
            alt.kill( null, conn, null);
            //LATER - lock account
        }
        catch(SQLException e)
        {
            log.throwing(KEY, "Error smiting someone", e);
            throw new ServletException(e);
        }
        finally
        {
            DatabaseUtility.close(conn);
        }
        response.setHeader("HTTP-EQUIV","Refresh");
        response.setHeader("CONTENT", "1;URL=charList.jsp");
        out.write("<html><body>He/she/it's been smote <br/><a href=\"/admin/charList.jsp\">Back to the character list</a></body></html>");
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


