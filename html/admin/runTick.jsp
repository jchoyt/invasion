<%@ page import="invasion.servlets.*,invasion.util.*" %><%
String locid = WebUtils.getOptionalParameter(request, "count", "1");
int tickCount = Integer.parseInt( locid );
TickTask tick = new TickTask();
for(int i=0; i<tickCount; i++)
{
    tick.run();
    out.write("Tick forced.\n");
}
%><META HTTP-EQUIV="Refresh" CONTENT="1;URL=charList.jsp">


