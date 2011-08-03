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
@WebServlet(urlPatterns = { "/map/saveSkillConfig" } )
public class SaveSkillConfig extends HttpServlet
{

    public final static String KEY = SaveSkillConfig.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Description of the Method
     *
     */
    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
         PrintWriter out = response.getWriter();
         Whatzit wazzit = (Whatzit) request.getSession().getAttribute(Whatzit.KEY);
         Alt alt = wazzit.getAlt();

         alt.getSkillsUsed().clear();
         //process firearms skill
         String firearmsSkill = WebUtils.getOptionalParameter(request, "firearms", "None" );
         if( !firearmsSkill.equals("None") )
             alt.getSkillsUsed().add( firearmsSkill );

         out.write("OK");
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


