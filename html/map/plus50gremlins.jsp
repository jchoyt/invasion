<%@ page import="invasion.pets.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    for(int i=0; i < 50; i++)
    {
        new Gremlin(0);
    }
    BroodManager.workBroods();
%>
<html><body>
50 Grelins added<br/>
<a href="${base}map/index.jsp"> back to map</a>

