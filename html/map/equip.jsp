<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%

    String itemid = WebUtils.getRequiredParameter(request, "weaponid");
    int id = Integer.parseInt(itemid);
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    //do DB inserts
    String query = "select * from item i join itemtype t on i.typeid=t.typeid where itemid = ? and locid = ? and type='weapon'";
    InvasionConnection conn = new InvasionConnection();
    PreparedStatement ps = conn.prepareStatement(query);
    ResultSet rs = null;
    boolean newWeaponNeedsAmmo = false;
    JSONObject inventory = null;
    try{
        ps.setInt(1, id);
        ps.setInt(2, wazzit.getAlt().getId());
        rs = ps.executeQuery();
        String weaponName = null;
        if( rs.next() )
        {
            weaponName = rs.getString("name");
            newWeaponNeedsAmmo = rs.getBoolean("usesammo");
        }
        else
            response.sendRedirect( "/map/index.jsp?error=That item is not a weapon or you do not own it.");
        DatabaseUtility.close(rs);
        DatabaseUtility.close(ps);
        //do both updates in one statement
        query = "update alt set equippedweapon = ? where id = ?;update item set equipped='f' where locid = ?;update item set equipped='t' where itemid = ?";
        ps = conn.prepareStatement(query);
        ps.setInt(1, id);
        ps.setInt(2, wazzit.getAlt().getId());
        ps.setInt(3, wazzit.getAlt().getId());
        ps.setInt(4, id);
        ps.execute();
        wazzit.getAlt().setEquippedWeapon( id );
        //update wazzit - weapon name, ammo, etc
        wazzit.reload();
        DatabaseUtility.close(ps);
        //now decrement AP
        wazzit.getAlt().decrementAp(conn, 1);
        new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You switch your equipped weapon. You will now use your " + weaponName + ".");
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

