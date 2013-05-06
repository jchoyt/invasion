/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.servlets;

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
 *  Do the tick every 15 minutes on the quarter hour
 *
 * @author     jchoyt
 */
@WebServlet(urlPatterns = { "/tick" }, loadOnStartup=10 )
public class TickServlet extends HttpServlet
{

    public final static String KEY = TickServlet.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}
    protected static Timer timer = null;

    /**
     *  Constructor for the Servlet object
     *
     * @since
     */
    public TickServlet()
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
            TickTask task = new TickTask();
            GregorianCalendar startTime = new GregorianCalendar();
            //due to the magic of integer math, this will go to the previous quarter hour
            int minuteOfHour = ( startTime.get( Calendar.MINUTE )/15 + 1) * 15;
            if( minuteOfHour == 60 )
            {
                minuteOfHour = 0;
                startTime.add(Calendar.HOUR, 1);
            }

            startTime.set( startTime.get( Calendar.YEAR ), startTime.get( Calendar.MONTH ), startTime.get( Calendar.DAY_OF_MONTH ), startTime.get( Calendar.HOUR_OF_DAY ), minuteOfHour, 0 );
            log.finer("start time is: " + startTime);
            //set delay in milliseconds - numbers are ms/sec * sec/min * min/hour * hour/day * days
            long delay = 1000 * 60 * 15;// 15 minutes
            timer = new Timer( true );

            timer.schedule( task, startTime.getTime(), delay );
        }
        catch ( Exception e )
        {
            log.throwing( KEY, "Problem in TickServlet", e );
            throw new ServletException( "Problem in TickServlet", e );
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

