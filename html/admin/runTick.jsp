<%@ page import="invasion.servlets.*,invasion.util.*" %><%
String locid = WebUtils.getOptionalParameter(request, "count", "1");
int tickCount = Integer.parseInt( locid );
if( tickCount > 100 )
{
    out.write( "Ticks will take a couple seconds each now.  Reducing count to 100." );
    tickCount = 100;
}
TickTask tick = new TickTask();
if( tickCount == 1 )
{
    tick.run();
}
else
{
    for(int i=0; i<tickCount; i++)
    {
        tick.run();
        out.write("Tick " + i + " forced.\n");
        out.flush();
    }
}
%><META HTTP-EQUIV="Refresh" CONTENT="1;URL=charList.jsp">


