<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%

    String itemid = WebUtils.getRequiredParameter(request, "itemid");
    int id = Integer.parseInt(itemid);
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    //do DB inserts
    String query = "delete from item where itemid = ? and locid = ?";
    InvasionConnection conn = null;
    PreparedStatement ps = null;
    JSONObject inventory = null;
    try{
        conn = new InvasionConnection();
        ps = conn.prepareStatement(query);
        String category = Item.getCategory(conn, id);
        String itemName = Item.getName(conn, id);
        if( !category.equals("booze") )
        {
            throw new NaughtyException("That does not seem to be alcohol.");
        }
        ps.setInt(1, id);
        ps.setInt(2, wazzit.getAlt().getId());
        int count = ps.executeUpdate();
        if( count == 1 )
        {
            Stats.addChange(wazzit.getAlt().getId(), Stats.BOOZE, 1);
        }
        else
            throw new NaughtyException("What are you trying to do?");

        // inventory = Item.getItems(conn, wazzit.getAlt().getId());
        // out.write(String.valueOf(inventory));
        wazzit.getAlt().decrementAp(conn, 1);
        new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You open the " +  itemName + " and start drinking.  All too soon, it's gone.");

        //TODO death by alcohol poisoning
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    finally
    {
        DatabaseUtility.close(ps);
        Poll.fullPoll( conn, out, wazzit, null );
        conn.close();
    }
%>

