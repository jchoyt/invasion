<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%

    String target = WebUtils.getRequiredParameter(request, "target");
    int targetid = Integer.parseInt(target);
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    if( wazzit == null )
    {  //nobody is logged in
        response.sendRedirect("/index.jsp");
        return;
    }

    InvasionConnection conn = new InvasionConnection();

    wazzit.setLastTargetId( targetid );
    wazzit.getAlt().decrementAp(conn,1);

    if(wazzit.getAmmoModNeeded())
    {
        //decrement ammo and reload if necessary
    }

    // check if you hit
    if( Math.random() < 0.25 )
    {
        //hit
        //TODO soaks
        // new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You attack XXXXX with your "  + wazzit.getEquippedWeaponName() + " and miss.");
        // new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, wazzit.getAlt().getName() + " attacked you with a "  + wazzit.getEquippedWeaponName() + " and missed.");

    }
    else
    {
        //miss
        new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You attack XXXXX with your "  + wazzit.getEquippedWeaponName() + " and miss.");
        new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, wazzit.getAlt().getName() + " attacked you with a "  + wazzit.getEquippedWeaponName() + " and missed.");
    }


    //=======================================delete or steal below when done
    //do DB inserts
    String query = "delete from item where itemid = ? and locid = ?";
    PreparedStatement ps = conn.prepareStatement(query);
    JSONObject inventory = null;
    try{
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

