<%@ page import="invasion.util.*,invasion.ui.*,java.sql.*,invasion.dataobjects.*,invasion.pets.*, java.util.logging.*,org.json.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String locString = WebUtils.getRequiredParameter(request, "locid");
    int loc = 0;
    try{ loc = Integer.parseInt( locString ); } catch (Exception e) {}
        //set up db connection
    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
        JSONObject ret = Location.getSummary( conn, loc );
        //critters
        JSONArray pets = BroodManager.petsAtLocation( loc );
        if( pets.length() > 0 )
        {
            ret.put("pets", pets );
        }
        //Occupants
        JSONArray occupants = Location.getOccupants(conn, loc, -1 );
        if( occupants.length() > 0 )
        {
            ret.put("occs", occupants);
        }

        VelocityUtil.applyTemplate( ret, "locationSummary.vm", out );
    }
    catch(Exception e)
    {
        e.printStackTrace();
        out.write("Error retrieving stats");
    }
    finally
    {
        DatabaseUtility.close(conn);
    }
%>

