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
@WebServlet(urlPatterns = { "/map/throw" } )
public class ThrowItem extends HttpServlet
{

    public final static String KEY = ThrowItem.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}

    public ThrowItem()
    {
        super();
    }

    /**
     *  Standard get method.  doPost redirects here.
     *
     */
    @Override
    public void doGet( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
        PrintWriter out = response.getWriter();
        String target = WebUtils.getRequiredParameter(request, "target");
        int targetid = Integer.parseInt(target);
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        JSONArray alerts = null;
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            Defender defender = Alt.load( targetid );
            alerts = wazzit.getAlt().attack( defender, conn );
            if( wazzit.getAlt().getReload() )
            {
                Poll.sendReloadCommand(out);
                wazzit.getAlt().setReload(false);
                return;
            }
            Poll.fullPoll( conn, out, wazzit, alerts );
        }
        catch (Exception e)
        {
            log.throwing(KEY, "body", e);
            alerts = new JSONArray();
            alerts.put( Poll.createErrorAlert(e.getMessage()) );
        }
        finally
        {
            DatabaseUtility.close(conn);
        }
    }


    /**
     *  Redirect to doGet()
     *
     */
    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
        throws IOException, ServletException
    {
            doGet( request, response );
    }

}


