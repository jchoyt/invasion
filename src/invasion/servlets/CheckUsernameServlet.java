/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.util.*;
import java.util.*;
import java.util.logging.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import javax.servlet.annotation.WebServlet;
import java.sql.*;

/**
 *
 *
 * @author     jchoyt
 * @created
 */
@WebServlet(urlPatterns = { "/checkUsernameAvailable" } )
public class CheckUsernameServlet extends HttpServlet
{

    public final static String KEY = CheckUsernameServlet.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the PqmServlet object
     *
     * @since
     */
    public CheckUsernameServlet()
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
    public void doGet( HttpServletRequest req, HttpServletResponse resp )
        throws IOException, ServletException
    {
        PrintWriter out = resp.getWriter();
        String name = WebUtils.getRequiredParameter(req, "name");
        if( name.toLowerCase().contains("jesus") || name.contains("<:") )
        {
            out.write("false");
            return;
        }
        String query = "select * from alt where name=?";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1,name);
            rs = ps.executeQuery();
            if(rs.next())
                out.write("false");
            else
                out.write("true");
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            DatabaseUtility.close(conn);
        }
    }


    /**
     *  Description of the Method
     *
     */
    @Override
    public void doPost( HttpServletRequest req, HttpServletResponse resp )
        throws IOException, ServletException {
            doGet( req, resp );
        }

}


