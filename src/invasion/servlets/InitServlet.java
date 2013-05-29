/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.bot.*;
import invasion.dataobjects.*;
import invasion.pets.*;
import invasion.ui.VelocityUtil;
import invasion.util.*;
import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *  This allows for initial setup, inlcuding
 *  <ul>
 *    <li> Setting application-wide variables for css, js, and image files</li>
 *    <li> Loading static lookup information</li>
 *    <li> Setting up the Velocity template engine</li>
 *    <li> </li>
 *  </ul>
 *@author     Jeffrey Hoyt
 */
@WebServlet(urlPatterns={"/94yTsFEk7tU8igXn6vPPW4fRi6qv49mTRYydlmIkTpL9ypVpl1CSH5fI7Uji7cx"}, loadOnStartup=1)
public class InitServlet extends HttpServlet
{

    public final static String KEY = InitServlet.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    protected static Thread botThread = null;

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

        /* initialize the velocity template utility so we can use the same templates serverside as client side. */
        String base_path = config.getServletContext().getRealPath( "/" );
        String config_dir = base_path + "WEB-INF/";
        VelocityUtil.init( config_dir + "templates");

        WebUtils.BASE = webapp;
        WebUtils.IMAGES = webapp + "i";
        WebUtils.BASE_PATH = base_path;

        /* pre-load itemtype and locationtype data */
        ItemType.load();
        LocationType.load();
        /* pre-load the Search information */
        Search.load();
        log.info("--> Search tables loaded");

        Critter.loadClassNames();
        log.info("--> Critter types loaded");

        /* pre-load the Skill values */
        Skills.load();
        log.info("--> Skills loaded");

        /* Load up the location occupant counts  */
        LocationCache.load();
        log.info("--> Location cache set up");

        /* load up the broods */
        BroodManager.load();
        log.info("--> Broods loaded");

        /* load up factions */
        Faction.loadCache();
        log.info("--> Factions loaded");
        /* start up the error reporting bot */
        botThread = new Thread( new BotRunner( "vasionbot.properties" ), "VasionBot" );
        botThread.start();
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

class BotRunner implements Runnable
{
    String configLoc;

    private BotRunner()
    {}


    public BotRunner( String key )
    {
        configLoc = key;
    }

    /**
     *  Main processing method for the AsynchronousMetaDataLoader object
     */
    public void run()
    {
        new VasionBot( configLoc );
    }
}


