/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.servlets;

import java.sql.*;
import java.util.logging.Logger;
import java.util.logging.Level;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import java.util.*;
import invasion.util.*;
import invasion.dataobjects.*;

/**
 * Filter to check when you're freshly dead or awaiting a respawn.  Also ensures you are logged in - this should only apply to stuff in /map
 *
 */

@WebFilter(
    filterName = "DeathFilter",
    urlPatterns = {"/map/attack", "/map/drink","/map/eat","/map/move","/map/search","/map/speak", "/map/index.jsp", "/map/throw", "/map/chalk"}
    )
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
        Whatzit wazzit = (Whatzit) ((HttpServletRequest) request).getSession().getAttribute(Whatzit.KEY);
        if( wazzit == null || wazzit.getAlt() == null )  //nobody is logged in
        {
            log.finer("no character is logged in");
            filterConfig.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }
        Alt alt = wazzit.getAlt();
        int locid = alt.getLocation();
        log.finer( alt.getName() + "location is " + locid + " and hp is " + alt.getHp() );
        if( locid == -1337 )
        {
            //TODO make LOST IN SPACE page
            log.finer("Locid = -1337 - character is basically screwed.");
            filterConfig.getServletContext().getRequestDispatcher( "/index.jsp?error=" + alt.getName() + " is lost somewhere and you have no idea where...you'll need mod help<br/>Get on irc - #soulcubes on irc.freenode.net.").forward(request, response);
            return;
        }
        else if( alt.getStunned() > System.currentTimeMillis() )
        {
            log.finer(WebUtils.BASE + "map/index.jsp?error=You are stunned and cannot take any action until the effect wears off.");
            filterConfig.getServletContext().getRequestDispatcher( "/map/index.jsp?error=You are stunned and cannot take any action until the effect wears off.").forward(request, response);
            return;
        }
        else if( locid == Constants.DEAD_LOCATION || alt.getHp() < 1 )
        {
            log.finer("Character is dead.");
            filterConfig.getServletContext().getRequestDispatcher( "/map/dead.jsp" ).forward(request, response);
            return;
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

