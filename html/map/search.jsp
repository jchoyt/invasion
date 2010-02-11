<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%!
    public final static String KEY = "/map/search.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}%><%@

    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%

    String count = WebUtils.getRequiredParameter(request, "count");
    int reps = Integer.parseInt(count);
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    if( wazzit == null )
    {  //nobody is logged in
        response.sendRedirect("/index.jsp");
        return;
    }
    //do DB inserts
    String query = "insert into messages (altid, message) values (?,?)";
    InvasionConnection conn = new InvasionConnection();
    conn.setAutoCommit(false);
    PreparedStatement ps = null;
    try{
        for(int i = 0; i < reps; i++)
        {
            int itemFound = Search.performSearch(2);
            ps = conn.prepareStatement(query);
            if( itemFound == -1 )
            {
                //found nothing
                ps.setInt(1, wazzit.getAlt().getId());
                ps.setString(2, "You search and find nothing.");
            }
            else
            {
                Item item = new Item(conn, itemFound, wazzit.getAlt().getId());
                ps.setInt(1, wazzit.getAlt().getId());
                ps.setString(2, "You search and find a " + ItemType.getItemType(itemFound).getName() + ".");
            }
            ps.executeUpdate();
        }
        conn.commit();
    }
    catch(Exception e)
    {
        conn.rollback();
        log.throwing( KEY, "body", e);
        //TODO - return error in JSON format
    }
    finally
    {
        DatabaseUtility.close(ps);
        conn.close();
    }

    JSONObject inventory = Item.getItems(wazzit.getAlt().getId());
    JSONObject msgs = Message.getInitialMessages(wazzit.getAlt().getId());
    inventory.put("msgs", msgs.getJSONArray("msgs"));
    // System.out.println( String.valueOf(inventory) );
    out.write(String.valueOf(inventory));
%>

