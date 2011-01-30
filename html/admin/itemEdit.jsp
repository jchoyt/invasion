<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
page import="invasion.util.*, java.sql.*,java.util.logging.*" %><%
    String vals = WebUtils.getRequiredParameter(request, "newvalues");

    //example 37,Vodka,booze,1,s,15,1d3,1,true,p,false
    String[] values = vals.split(",");

    InvasionConnection conn = null;
    PreparedStatement ps = null;
    try{
        conn = new InvasionConnection();
        String query = "update itemtype set name=?, type=?, weight=?, size=?, accuracy=?, damage=?, capacity=?, consumable=?, damagetype=?, usesammo=? where typeid=?";
        ps = conn.prepareStatement(query);
        int i = 0;
        ps.setString(++i, values[i]);
        ps.setString(++i, values[i]);
        ps.setInt(++i, Integer.parseInt( values[i] ));
        ps.setString(++i, values[i]);
        ps.setInt(++i, Integer.parseInt( values[i] ));
        ps.setString(++i, values[i] );
        ps.setInt(++i, Integer.parseInt( values[i] ));
        ps.setBoolean(++i, Boolean.parseBoolean( values[i] ) );
        ps.setString(++i, values[i] );
        ps.setBoolean(++i, Boolean.parseBoolean( values[i] ) );
        ps.setInt(++i, Integer.parseInt( values[0]));
        ps.execute();
    }
    catch (SQLException e)
    {
        Logger log = Logger.getLogger( "itemEdit.tag" );
        log.log(Level.WARNING, "Error editing item.", e);
    }
    finally
    {
        DatabaseUtility.close(ps);
        conn.close();
    }

%><jsp:forward page="itemList.jsp" />
