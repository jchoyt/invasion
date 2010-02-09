<%@ page import="invasion.util.*" %><%

String username = WebUtils.getRequiredParameter( request, "name");
String password = WebUtils.getRequiredParameter( request, "passwd");

String loginResult = Login.login( request, response);

if( loginResult.equals( Login.LOGIN_OK ))
{
    response.sendRedirect( "map" );
    return;
}
%><jsp:forward page="/" >
    <jsp:param name="message" value="<%=loginResult%>" />
</jsp:forward>
