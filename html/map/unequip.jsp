<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%

    String itemid = WebUtils.getRequiredParameter(request, "weaponid");
    int id = Integer.parseInt(itemid);
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    if( wazzit == null )
    {  //nobody is logged in
        response.sendRedirect("/index.jsp");
        return;
    }
    //do DB inserts
    String query = "select * from item i join itemtype t on i.typeid=t.typeid where itemid = ? and locid = ? and type='weapon'";
    InvasionConnection conn = new InvasionConnection();
    PreparedStatement ps = conn.prepareStatement(query);
    ResultSet rs = null;
    JSONObject inventory = null;
    try{
        ps.setInt(1, id);
        ps.setInt(2, wazzit.getAlt().getId());
        rs = ps.executeQuery();
        String weaponName = null;
        if( rs.next() )
        {
            weaponName = rs.getString("name");
        }
        else
        {
            response.sendRedirect( "/map/index.jsp?error=That item is not a weapon or you do not own it.");
            return;
        }
        DatabaseUtility.close(rs);
        DatabaseUtility.close(ps);
        //do both updates in one statement
        query = "update alt set equippedweapon = ? where id = ?;update item set equipped='f' where itemid = ?";
        ps = conn.prepareStatement(query);
        ps.setNull(1, Types.INTEGER);
        ps.setInt(2, wazzit.getAlt().getId());
        ps.setInt(3, id);
        ps.execute();
        wazzit.getAlt().setEquippedWeapon( id );
        DatabaseUtility.close(ps);
        //now decrement AP
        wazzit.getAlt().decrementAp(conn, 1);
        new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You have unequipped your " + weaponName + ".");
        response.sendRedirect( "/map/index.jsp" );
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    finally
    {
        DatabaseUtility.close(ps);
        conn.close();
    }

%>

