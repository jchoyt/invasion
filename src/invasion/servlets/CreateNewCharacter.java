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
        String charname = WebUtils.getRequiredParameter( request, "name");
        if( charname.length() < 2 )
        {
            response.sendRedirect( WebUtils.BASE + "index.jsp?error=Your character's name should have at least 2 characters, don't you think?  It's just cruel otherwise.  Try again." );
        }
        String skill_string = WebUtils.getRequiredParameter( request, "skill");
        String station_string = WebUtils.getRequiredParameter( request, "station");
        String race_string = WebUtils.getOptionalParameter( request, "race", "1");
        int skill = Integer.parseInt(skill_string);
        int station = Integer.parseInt(station_string);
        int race = Integer.parseInt(race_string);

        long humanSkill = 0L;
        long psiSkill = 0L;
        long mutSkill = 0L;

        switch(skill)
        {
            case 0:
                humanSkill = Skills.getValue(Skill.FIREARMS1);
                break;
            case 1:
                humanSkill = Skills.getValue(Skill.MELEE1);
                break;
            case 2:
                humanSkill = Skills.getValue(Skill.TINKERER1);
                break;
            default:
                break;
        }


        InvasionConnection conn = null;
        try
        {
            Alt alt = Alt.createNew( request.getUserPrincipal().getName(), charname, station, race );

            if( alt != null )
            {
                conn = new InvasionConnection();
                new Message( conn, alt.getId(), Message.SELF, "Welcome to Invasion's pre-alpha stage.  In reality, you can't do much yet.  Over time, more will be added and I'm relying on you to pass on lessons learned to others (via the boards, for example) who will follow you.  Also, I need bug reports, suggestions, etc. - put them in the issue tracker.  There are some loop holes in security right now; report them and have fun with them, but don't abuse them.  Mostly, enjoy.");
                String query = "update alt set humanskill=?, psiskill=?, mutateskill=? where id=?";
                int count = conn.psExecuteUpdate( query, "Error updating " + alt.getName() + " for their starting skills", humanSkill, psiSkill, mutSkill, alt.getId() );
                if( count != 1 )
                {
                    throw new BotReportException( "Error updating " + alt.getName() + " for their starting skills.  The character was not found under the id " + alt.getId() );
                }

                response.sendRedirect( WebUtils.BASE + "" );
                return;
            }
        }
        catch (Exception e)
        {
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


