<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%

    String itemid = WebUtils.getRequiredParameter(request, "itemid");
    int id = Integer.parseInt(itemid);
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
        String category = Item.getCategory(conn, id);
        //TODO check for null
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

        ;
        // inventory = Item.getItems(conn, wazzit.getAlt().getId());
        // out.write(String.valueOf(inventory));
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    finally
    {
        DatabaseUtility.close(ps);
        Poll.fullPoll( conn, out, wazzit );
        conn.close();
    }
%>

