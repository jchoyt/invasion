<%@ page import="invasion.pets.*, java.util.List" %><%
List<String> list = LocationCache.verify();
for( String bug : list )
{
    out.write( bug );
    out.write(  "<br/> ");
}
%>
Done.  <a href="${base}admin/index.jsp">Back to admin main</a>

