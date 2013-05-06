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
@WebServlet(urlPatterns = { "/purchaseSkill" } )
public class PurchaseSkill extends HttpServlet
{

    public final static String KEY = PurchaseSkill.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public PurchaseSkill()
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
        String altidString = WebUtils.getRequiredParameter( request, "altid" );
        String skillid_string = WebUtils.getRequiredParameter( request, "skillid" );
        int skillid = Integer.parseInt( skillid_string );
        Skill s = Skills.getById( skillid );
        InvasionConnection conn = null;
        PrintWriter out = response.getWriter();
        try
        {
            int altid = Integer.parseInt( altidString );
            conn = new InvasionConnection();
            String column = "humanskill";
            if( s.getRace().equals( Skill.PSI ) )
                column = "psiskill";
            else if( s.getRace().equals( Skill.MUTATE ) )
                column = "mutateskill";
            String query = "select s.name, a.cp, s.cost <= a.cp as hascp, " +  //boolean - do you have enough CP to buy this?
                "(t.value & a."+ column + " > 0 or s.prerequisite is null ) " +  //boolean do you have the prerequisite skill?
                "as prereq from alt a join skills s on (a."+ column + " & s.value = 0 ) " + //ensures you don't already have it
                "left outer join skills t on s.prerequisite=t.id where a.id=? and s.id=? order by s.name;";

            boolean hascp = false, prereq = false;
            boolean okToContinue = false;
            ResultSet rs = conn.psExecuteQuery( query, "error", altid, skillid );
            if( rs.next() )
            {
                hascp = rs.getBoolean("hascp");
                prereq = rs.getBoolean("prereq");
                okToContinue = hascp && prereq;
            }
            DatabaseUtility.close( rs );
            if( okToContinue )
            {
                query = "update alt set " + column + " = " + column + " | ? where id=?";
                conn.psExecuteUpdate( query, "error", s.getValue(), altid );
                query = "update alt set cp = cp - ? where id = ?";
                conn.psExecuteUpdate( query, "error", s.getCost(), altid );
                AltFactory.uncache( altid );
                out.write("<font color=\"green\">Purchase succeeded...reloading page.</font>");
            }
            else
                out.write("<font color=\"red\">Purchase failed...reloading page.</font>");
        }
        catch(Exception e)
        { e.printStackTrace();}
        finally
        { DatabaseUtility.close(conn); }

    }


    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}


