/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

import invasion.pets.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.*;
import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;


/**
 *  Have active pets attack every 8 seconds
 *
 * @author     jchoyt
 */
@WebServlet(urlPatterns = { "/petTick" }, loadOnStartup=99 )
public class PetTickServlet extends HttpServlet
{

    public final static String KEY = PetTickServlet.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}
    protected static Timer timer = null;

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public PetTickServlet()
    {
        super();
    }



    /**
     *  Description of the Method
     *
     * @param  config                Description of the Parameter
     * @exception  ServletException  Description of the Exception
     */
    @Override
    public void init( ServletConfig config )
        throws ServletException
    {
        log.entering( KEY, "init" );
        /*
         *  required for all Servlets
         */
        super.init( config );

        try
        {
            PetTickTask task = new PetTickTask();
            //set period in milliseconds - numbers are ms/sec * sec/min * min/hour * hour/day * days
            long period = 1000 * 8;// 8 seconds
            timer = new Timer( true );

            timer.scheduleAtFixedRate( task, 15*1000, period );
        }
        catch ( Exception e )
        {
            log.throwing( KEY, "Problem in PetTickServlet", e );
            throw new ServletException( "Problem in PetTickServlet", e );
        }
        log.exiting( KEY, "init" );
    }


    public static void killTimer()
    {
        timer.cancel();
    }

    /**
     *  Description of the Method
     *
     * @param  req                   Description of the Parameter
     * @param  resp                  Description of the Parameter
     * @exception  IOException       Description of the Exception
     * @exception  ServletException  Description of the Exception
     */
    @Override
    public void doGet( HttpServletRequest req, HttpServletResponse resp )
        throws IOException, ServletException {
            resp.sendRedirect("http://disney.com");
        }


    /**
     *  Description of the Method
     *
     * @param  req                   Description of the Parameter
     * @param  resp                  Description of the Parameter
     * @exception  IOException       Description of the Exception
     * @exception  ServletException  Description of the Exception
     */
    @Override
    public void doPost( HttpServletRequest req, HttpServletResponse resp )
        throws IOException, ServletException {
            resp.sendRedirect("http://disney.com");
    }

}

/**
 *  This class is a repeating task to process pet attacks
 *
 * @author     jchoyt
 */


class PetTickTask extends TimerTask
{

    public final static String KEY = PetTickTask.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    /**
     *  Constructor for the TickTask object
     */
    public PetTickTask() { }


    /**
     *  Main processing method for the TickTask object
     */
    public void run()
    {
        log.entering( KEY, "run" );
        BroodManager.processAttacks();
        log.exiting( KEY, "run" );
    }
}

