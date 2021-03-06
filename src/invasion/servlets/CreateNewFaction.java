/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
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
@WebServlet(urlPatterns = { "/newFaction" } )
public class CreateNewFaction extends HttpServlet
{

    public final static String KEY = CreateNewFaction.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public CreateNewFaction()
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
        /*
         *  required for all Servlets
         */
        super.init( config );
    }


    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        String name = WebUtils.getRequiredParameter( request, "name");
        String description = WebUtils.getOptionalParameter( request, "description", "1");
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();
        InvasionConnection conn = null;
        try
        {
            if( alt != null )
            {
                conn = new InvasionConnection();
                Faction faction = Faction.createNew( conn, alt, name, description );
                response.sendRedirect( WebUtils.BASE + "map/index.jsp" );
                return;
            }
        }
        catch (Exception e)
        {
            log.log(Level.WARNING, "Error creating new faction ", e);
            response.sendRedirect( WebUtils.BASE + "map/index.jsp?error=There was an error creating the faction.  If this persists, please report it on the <a href=\"http://soulcubes.com/boards\" target=\"_blank\">boards</a>.");
        }
        finally
        {
            DatabaseUtility.close(conn);
        }

    }


    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}


