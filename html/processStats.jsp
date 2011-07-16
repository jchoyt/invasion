<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%!
    public final static String KEY = WebUtils.BASE + "/map/processStats.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}%><%
    try
    {
        Stats.process();
    }
    catch (SQLException e)
    {
        Stats.writeLog(out);
        log.throwing(KEY, "body", e);
        out.write("FAIL");
        return;
    }
%>OK
