<%@ page import="java.util.*, invasion.dataobjects.*, invasion.util.*, java.util.logging.*;" %><%
    session.removeAttribute(Whatzit.KEY);
    response.sendRedirect( "/index.jsp" );
%>
