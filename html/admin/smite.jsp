<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%

    String altid = WebUtils.getRequiredParameter(request, "id");
    String message = WebUtils.getRequiredParameter(request, "message");
    String query = "update alt set hp=0, lasthurtby=null where id=?";
    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(altid));
        int count = ps.executeUpdate();
        new Message( conn, Integer.parseInt(altid), Message.EFFECT, message );
        Alt.kill( conn, Integer.parseInt(altid) );
        //LATER - lock account
    }
    catch(Exception e)
    {
        e.printStackTrace();
        throw e;
    }
    finally
    {
        DatabaseUtility.close(ps);
        DatabaseUtility.close(conn);
    }
%><META HTTP-EQUIV="Refresh" CONTENT="1;URL=charList.jsp">
(Sh/H)e's been smote

