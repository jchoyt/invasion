<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%!
    public final static String KEY = "/map/search.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}%><%@

    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%

    String count = WebUtils.getRequiredParameter(request, "count");
    int reps = Integer.parseInt(count);
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    //do DB inserts
    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
        conn.setAutoCommit(false);
        for(int i = 0; i < reps; i++)
        {
            int itemFound = Search.performSearch(2);
            if( itemFound == -1 )
            {
                new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You search and find nothing.");
            }
            else
            {
                new Item(conn, itemFound, wazzit.getAlt().getId());
                new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You search and find a " + ItemType.getItemType(itemFound).getName() + ".");
            }
        }
        wazzit.getAlt().decrementAp(conn, reps);
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
        Poll.fullPoll( conn, out, wazzit, null );
        conn.close();
    }

    // JSONObject inventory = Item.getItems(wazzit.getAlt().getId());
    // JSONObject msgs = Message.getInitialMessages(wazzit.getAlt().getId());
    // inventory.put("msgs", msgs.getJSONArray("msgs"));
    // // System.out.println( String.valueOf(inventory) );
    // out.write(String.valueOf(inventory));
%>

