<%@ page import="invasion.dataobjects.*,invasion.util.*,java.util.logging.*" %><%

String username = WebUtils.getRequiredParameter( request, "name");
String speciality = WebUtils.getRequiredParameter( request, "speciality");
String skill = WebUtils.getRequiredParameter( request, "skill");
skill="-1";
int station = 0;
InvasionConnection conn = null;
try
{
    int specialityid = Integer.parseInt( speciality );
    Alt alt = new Alt( request.getUserPrincipal().getName(), username, specialityid, Integer.parseInt(skill), station );

    if( alt != null )
    {
        session.setAttribute("character", alt.getId());
        response.sendRedirect( "/map" );
        return;
    }
    conn = new InvasionConnection();
    Message msg = new Message( conn, alt.getId(), Message.SELF, "Welcome to Invasion's pre-alpha stage.  In reality, you can't do much yet.  Over time, more will be added and I'm relying on you to pass on lessons learned to others (via the wiki, for example) who will follow you.  Also, I need bug reports, suggestions, etc. - put them on the forums.  There are some loop holes in security right now.  Report them and have fun with them, but don't abuse them.  Mostly, enjoy.");
}
catch (Exception e)
{
    Logger log = Logger.getLogger( "newCharacterProcess.jsp" );
    log.log(Level.WARNING, "Error creating new character ", e);
}
finally
{
    if( conn != null )
    {
        conn.close();
    }
}

%>
<jsp:forward page="newCharacter.html" >
    <jsp:param name="message" value="Didn't work" />
</jsp:forward>
