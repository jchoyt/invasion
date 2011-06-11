/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import java.io.File;
import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import invasion.dataobjects.*;
import invasion.pets.*;
import invasion.ui.VelocityUtil;
import invasion.util.*;

/**
 *  This allows for initial setup, inlcuding
 *  <ul>
 *    <li> Setting application-wide variables for css, js, and image files</li>
 *    <li> Loading static lookup information</li>
 *    <li> Setting up the Velocity template engine</li>
 *    <li> </li>
 *  </ul>
 *
 *
 *@author     Jeffrey Hoyt
 *@version    1.0
 *@see        javax.servlet.http
 */
public class InitServlet extends HttpServlet
{

    public final static String KEY = InitServlet.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}

    public static String BASE_PATH = "/";

    /**
     *  Constructor for the Servlet object
     *
     *@since
     */
    public InitServlet()
    {
        super();
    }


    /**
     *  Description of the Method
     *
     *@param  config                Description of the Parameter
     *@exception  ServletException  Description of the Exception
     */
    public void init( ServletConfig config )
        throws ServletException
    {
        /*
         *  required for all Servlets
         */
        super.init( config );
        /* Set up logging */
        System.setProperty( "java.util.logging.config.class", "invasion.util.LogConfig" );
        LogConfig.reloadLogManagerProperties();
        System.out.println( LogConfig.getConfiguration() );
        /*
         *  Grab the name for the currently deployed webapp.  It's possible this could be in error if the webapp is deployed
         *  as a subdirectory (i.e., The docbase is http://localhost:8080/first/sub).  If this ever gets deployed that way it will
         *  have to be fixed.
         */
        String tempdir = String.valueOf(getServletContext().getAttribute("javax.servlet.context.tempdir"));
        String webapp = new File(tempdir).getName();
        if( webapp.equals("_") )  //"_" is the ROOT webapp
        {
            webapp = "/";
        }
        else webapp = "/" + webapp + "/";
        getServletContext().setAttribute("base",  webapp );
        getServletContext().setAttribute("images",  webapp + "i");
        getServletContext().setAttribute("js",  webapp + "js");
        getServletContext().setAttribute("css",  webapp + "css");
        System.out.println("Attributes set in InitServlet");

        BASE_PATH = webapp;

        /* initialize the velocity template utility so we can use the same templates serverside as client side. */
        String base_path = config.getServletContext().getRealPath( "/" );
        String config_dir = base_path + "WEB-INF/";
        VelocityUtil.init( config_dir + "templates");

        /* pre-load itemtype and locationtype data */
        ItemType.load();
        LocationType.load();
        /* pre-load the Search information */
        Search.load();
        /* pre-load the Skill values */
        Skills.load();
        /* Load up the location occupant counts */
        LocationCache.load();
        /* load up the broods */
        BroodManager.load();
    }

    /**
     *  Description of the Method
     *
     *@param  req                   Description of the Parameter
     *@param  resp                  Description of the Parameter
     *@exception  ServletException  Description of the Exception
     *@exception  IOException       Description of the Exception
     */
    public void doGet( HttpServletRequest req, HttpServletResponse resp )
        throws IOException, ServletException
    {
        doPost( req, resp );
    }


    /**
     *  Description of the Method
     *
     *@param  req                   Description of the Parameter
     *@param  resp                  Description of the Parameter
     *@exception  ServletException  Description of the Exception
     *@exception  IOException       Description of the Exception
     */
    public void doPost( HttpServletRequest req, HttpServletResponse resp )
    {
    }
}

