<%@ page import="invasion.pets.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    for(int i=0; i < 50; i++)
    {
        new Dalek(0);
    }
    BroodManager.workBroods();
%>
<html><body>
50 daleks added<br/>
<a href="/map/index.jsp"> back to map</a>

