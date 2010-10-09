/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.servlets;

import java.sql.*;
import java.util.logging.Logger;
import java.util.logging.Level;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import java.util.*;
import invasion.util.*;

/**
 * Filter to check when you're freshly dead or awaiting a respawn.  Also ensures you are logged in - this should only apply to stuff in /map
 *
 */
public class DeathFilter implements Filter
{

    public final static String KEY = DeathFilter.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    //{{{ Members
    private FilterConfig filterConfig = null;
    //}}}

    //{{{ Constuctors
    //}}}

    //{{{ Methods

    /**
     * Checks to see if the character is dead or not.  If they are, redirect any attempted action to dead.jsp.
     *
     */
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
        throws IOException, ServletException
    {
        log.finer("filter running");
        Whatzit wazzit = null;
        String endpoint = ((HttpServletRequest)request).getRequestURI();
        log.finer("processing " + endpoint );
        HttpSession session = ((HttpServletRequest)request).getSession(false);
        if (session != null) {
            wazzit = (Whatzit) session.getAttribute(Whatzit.KEY);
            if( wazzit == null || wazzit.getAlt() == null )  //nobody is logged in
                filterConfig.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
        }
        else
            filterConfig.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
        if( endpoint.endsWith("jsp") )
        {
            try{
                wazzit.reload();
            }
            catch (SQLException e)
            {
                filterConfig.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            }
            int locid = wazzit.getAlt().getLocation();
            log.finer( "Location id is: " + locid + " and HP total is " + wazzit.getAlt().getHp() );
            if( locid == -1337 )
            {
                //make LOST IN SPACE page
                // out.write("There has been an error and you seem to be lost in some unknown location.  You're basically screwed.");
                filterConfig.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            }
            else if( locid == -57005 || wazzit.getAlt().getHp() < 1 )
            {
                filterConfig.getServletContext().getRequestDispatcher("/map/dead.jsp").forward(request, response);
            }
            /* Add AP filter here and have it work off of Config */
        }
        else
        {
            log.finer( "Endpoint does not end in 'jsp', see? " + endpoint );
        }
        chain.doFilter(request, response);
    }


    public void init(FilterConfig filterConfig) throws ServletException
    {
        this.filterConfig = filterConfig;
    }

    public void destroy() {}


    //}}}

    //{{{ Getters and Setters
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

