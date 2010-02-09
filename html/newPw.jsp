<%@ page import="invasion.dataobjects.*,invasion.util.*,java.util.logging.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%


    String username = WebUtils.getRequiredParameter( request, "pw");
    out.write(Login.encodePassword( username, "SHA"));
%>


