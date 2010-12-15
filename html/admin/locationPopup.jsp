<%@ page import="invasion.util.*,invasion.ui.*,java.sql.*,invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String locString = WebUtils.getRequiredParameter(request, "locid");
    int loc = 0;
    try{ loc = Integer.parseInt( locString ); } catch (Exception e) {}
        //set up db connection
    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
        VelocityUtil.applyTemplate( Location.getSummary( conn, loc ), "locationSummary.vm", out );
    }
    catch(Exception e)
    {
        e.printStackTrace();
        out.write("Error retrieving stats");
    }
    finally
    {
        conn.close();
    }
%>

