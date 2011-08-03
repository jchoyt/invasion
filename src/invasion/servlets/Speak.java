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
import org.json.*;

/**
 *
 *
 * @author     jchoyt
 * @created
 */
@WebServlet(urlPatterns = { "/map/speak" } )
public class Speak extends HttpServlet
{

    public final static String KEY = Speak.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public Speak()
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
        String ME = "/me ";
        String message = WebUtils.getRequiredParameter(request, "words");
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        boolean emote = message.length() > 4 && message.substring(0,4).equals( ME );

        //clean up message (prevent bad things)
        message = EscapeChars.forHTML(message);
        //prepare message
        if( emote )
        {
            message = "<a href=\"" +  getServletContext().getAttribute("base") + "viewCharacter.jsp?id=" + wazzit.getAlt().getId() + "\">" + wazzit.getAlt().getName() + "</a> " + message.substring(8);
        }
        else
            message = "<a href=\"" +  getServletContext().getAttribute("base") + "viewCharacter.jsp?id=" + wazzit.getAlt().getId() + "\">" + wazzit.getAlt().getName() + "</a> said, \"" + message + "\"";

        //do DB inserts
        String query = "insert into messages (message, altid) select ?, id from alt where location = ?";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        try{
            conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, message);
            ps.setInt(2, wazzit.getAlt().getLocation());
            ps.executeUpdate();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            DatabaseUtility.close(ps);
            DatabaseUtility.close(conn);
            response.sendRedirect("index.jsp");
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


