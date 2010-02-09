<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%

    String itemid = WebUtils.getRequiredParameter(request, "itemid");
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    if( wazzit == null )
    {  //nobody is logged in
        response.sendRedirect("/index.jsp");
        return;
    }
    //do DB inserts
    String query = "delete from item where itemid = ? and locid = ?";
    InvasionConnection conn = new InvasionConnection();
    PreparedStatement ps = conn.prepareStatement(query);
    try{
        ps.setInt(1, Integer.parseInt(itemid));
        ps.setInt(2, wwazzit.getAlt().getId());
        ps.executeUpdate();
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

     JSONObject inventory = Item.getItems(wazzit.getAlt().getId());
     out.write(String.valueOf(inventory));
%>

