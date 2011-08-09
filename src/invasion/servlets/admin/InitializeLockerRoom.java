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
@WebServlet(urlPatterns = { "/admin/initializeLockerRoom" } )
public class InitializeLockerRoom extends HttpServlet
{

    public final static String KEY = InitializeLockerRoom.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    public InitializeLockerRoom()
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
        response.setHeader("HTTP-EQUIV","Refresh");
        response.setHeader("CONTENT", "1;URL=index.jsp");
        PrintWriter out = response.getWriter();
        String locid = WebUtils.getRequiredParameter(request, "locid");
        InvasionConnection conn = null;
        ResultSet rs = null;
        String query = "select * from location where id = ?";
        int typeid = -1;
        try
        {
            out.write("<html><body>");
            conn = new InvasionConnection();
            //check
            rs = conn.psExecuteQuery( query, "", Integer.parseInt(locid));
            if(rs.next())
            {
                typeid = rs.getInt("typeid");
                if( typeid != 23 )
                {
                    out.write("That location is not a locker room.");
                    return;
                }
            }
            else
            {
                out.write("That location doesn't exist");
                return;
            }
            DatabaseUtility.close(rs);

           //check to make sure it's not initialized
           query = "SELECT * from locker where location = ?";
           rs = conn.psExecuteQuery( query, "", Integer.parseInt(locid));
           if(rs.next())
           {
               out.write("That location already has lockers assigned to it.");
               return;
           }
           DatabaseUtility.close(rs);

           //TODO Do stuff here
           String insert = "INSERT INTO locker ( location, number ) values ( ?, ? )";
           int count = 0;
           for(int i = 0; i < 250; i++)
           {
               if( Math.random() < 0.33 )
               {
                   count = conn.psExecuteUpdate( insert, "Failed to created locker.", Integer.parseInt(locid), ( i + 100 ) );
                   out.write("Locker " + ( i + 100 ) + " created? " + (count==1) + "<br>");
               }
           }
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            out.write("</body></html>");
            DatabaseUtility.close(rs);
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


