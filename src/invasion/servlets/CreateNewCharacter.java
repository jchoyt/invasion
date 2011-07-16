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
 * @created
 */
@WebServlet(urlPatterns = { "/newCharacter" } )
public class CreateNewCharacter extends HttpServlet
{

    public final static String KEY = CreateNewCharacter.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public CreateNewCharacter()
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
        PrintWriter out = response.getWriter();
        String charname = WebUtils.getRequiredParameter( request, "name");
        String speciality = WebUtils.getRequiredParameter( request, "speciality");
        String skill = WebUtils.getRequiredParameter( request, "skill");
        skill="-1";
        int station = 0;
        InvasionConnection conn = null;
        try
        {
            int specialityid = Integer.parseInt( speciality );
            Alt alt = Alt.createNew( request.getUserPrincipal().getName(), charname, specialityid, Integer.parseInt(skill), station );

            if( alt != null )
            {
                conn = new InvasionConnection();
                Message msg = new Message( conn, alt.getId(), Message.SELF, "Welcome to Invasion's pre-alpha stage.  In reality, you can't do much yet.  Over time, more will be added and I'm relying on you to pass on lessons learned to others (via the wiki, for example) who will follow you.  Also, I need bug reports, suggestions, etc. - put them on the forums.  There are some loop holes in security right now.  Report them and have fun with them, but don't abuse them.  Mostly, enjoy.");
                response.sendRedirect( WebUtils.BASE + "" );
                return;
            }
        }
        catch (Exception e)
        {
            Logger log = Logger.getLogger( "newCharacterProcess.jsp" );
            log.log(Level.WARNING, "Error creating new character ", e);
        }
        finally
        {
            DatabaseUtility.close(conn);
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


