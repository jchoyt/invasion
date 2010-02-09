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
    JSONObject inventory = null;
    try{
        ps.setInt(1, Integer.parseInt(itemid));
        ps.setInt(2, wazzit.getAlt().getId());
        int count = ps.executeUpdate();
        //TODO drop a random object if count==0
        inventory = Item.getItems(conn, wazzit.getAlt().getId());
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    finally
    {
        DatabaseUtility.close(ps);
        conn.close();
        out.write(String.valueOf(inventory));
    }
%>

