/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.util.*;
import invasion.ui.*;
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
 *  Intended to use in an ajax call - any return value other than "OK" is unacceptable.
 *
 * @author     jchoyt
 * @created
 */
@WebServlet(urlPatterns = { "/alterPolitics" } )
public class AlterPolitics extends HttpServlet
{

    public final static String KEY = AlterPolitics.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    public AlterPolitics()
    {
        super();
    }

    /**
     *  Do not use - everything should go through doPost().
     *
     */
    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        PrintWriter out = response.getWriter();
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();
        if( alt == null || alt.getFaction() == null || alt.getFactionrank() < Constants.FACTION_LT )
        {
            //piss off, hacker
            throw new NaughtyException("Player's status within a faction is in question.");
        }
        int setterid = alt.getFaction().getId();

        String factionid_string = WebUtils.getRequiredParameter(request, "faction");
        String newStatus = WebUtils.getRequiredParameter(request, "newStatus");
        int targetid = Integer.parseInt( factionid_string );

        String deleteQuery = "delete from politics where setter=? and target=?";
        String insertQuery = "";
        boolean doInsert = false;

        if( newStatus.equals("hostile") )
        {
            doInsert = true;
            insertQuery = "insert into politics (setter, target, setting) values (?,?,0)";
        }
        else if( newStatus.equals("friendly") )
        {
            doInsert = true;
            insertQuery = "insert into politics (setter, target, setting) values (?,?,2)";
        }

        InvasionConnection conn = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();
            conn.psExecuteUpdate( deleteQuery, "Error removing old status", setterid, targetid );
            if( doInsert )
            {
                int count = conn.psExecuteUpdate( insertQuery, "Error setting new status", setterid, targetid );
                if( count != 1 )
                {
                    out.print("Insert did not happen");
                }
            }
            response.sendRedirect( "editFaction.jsp?info=Faction politics successfully updated." );
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
     *  Sets the faction status or removes it from the database table (if new status is neutral).
     *
     */
    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        response.sendRedirect("http://disney.com");
    }

}


