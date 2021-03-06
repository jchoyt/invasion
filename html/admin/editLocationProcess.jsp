<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
page import="invasion.util.*, java.sql.*,java.util.logging.*" %><%
    String locid = WebUtils.getRequiredParameter(request, "locid");
    String name = WebUtils.getRequiredParameter(request, "name");
    String type = WebUtils.getRequiredParameter(request, "type");
    String desc = WebUtils.getRequiredParameter(request, "desc");

    if( name.equals("") )
    {
        name = null;
    }
    if( desc.equals("") )
    {
        desc = null;
    }

    InvasionConnection conn = null;
    PreparedStatement ps = null;
    try{
        conn = new InvasionConnection();
        String query = "update location set name=?, typeid=?, description=? where id=?";
        ps = conn.prepareStatement(query);
        ps.setString(1, EscapeChars.forHTML(name));
        ps.setInt(2, Integer.parseInt( type ));
        ps.setString(3, EscapeChars.forHTML(desc));
        ps.setInt(4, Integer.parseInt(locid));
        ps.execute();
    }
    catch (SQLException e)
    {
        Logger log = Logger.getLogger( "AdminMap.tag" );
        log.log(Level.WARNING, "Error editing location " + locid, e);
    }
    finally
    {
        DatabaseUtility.close(ps);
        DatabaseUtility.close(conn);
    }

%><jsp:forward page="stationEdit.jsp" />
