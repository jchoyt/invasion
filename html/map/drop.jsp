<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%

    String itemid = WebUtils.getRequiredParameter(request, "itemid");
    int id = Integer.parseInt(itemid);
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    String query = "delete from item where itemid = ? and locid = ? and equipped='f'";
    InvasionConnection conn = null;
    PreparedStatement ps = null;
    JSONObject inventory = null;
    JSONArray alerts = null;
    try{
        conn = new InvasionConnection();
        ps = conn.prepareStatement(query);
        String itemName = Item.getName(conn, id);
        if( itemName == null )
        {
            alerts = new JSONArray();
            alerts.put( Poll.createErrorAlert("You do not own that item.") );
            return;
        }
        ps.setInt(1, Integer.parseInt(itemid));
        ps.setInt(2, wazzit.getAlt().getId());
        int count = ps.executeUpdate();
        //TODO drop a random object if count==0
        new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You drop your " + itemName + ".");
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    finally
    {
        DatabaseUtility.close(ps);
        Poll.fullPoll( conn, out, wazzit, alerts );
        conn.close();
        // out.write(String.valueOf(inventory));
    }
%>

