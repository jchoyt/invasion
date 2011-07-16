<%@ page import="invasion.util.*,invasion.pets.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String searchString = WebUtils.getOptionalParameter(request, "searchString", "");
%>
<html>
    <head>
        <link type="text/css" href="${css}/redmond/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
        <link type="text/css" href="${css}/main.css" rel="stylesheet" />
        <link type="text/css" href="${css}/jquery.cluetip.css" rel="stylesheet" />
        <script type="text/javascript" src="${js}/jquery-1.5.1.min.js"></script>
        <script type="text/javascript" src="${js}/jquery-ui-1.8.14.custom.min.js"></script>
        <script type="text/javascript" src="${js}/jquery.cluetip.js"></script>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>
        <center>
            Feral Broods
            <table>
                <thead>
                    <tr><th rowspan="2">Location</th><th rowspan="2">Size</th><th colspan="5">Goals</th></tr>
                    <tr><th>Survive</th><th>Protect</th><th>Kill Psi</th><th>Kill Mut</th><th>Kill Human</th></tr>
                </thead>
                <tbody>
            <%
            for(Brood b : BroodManager.getFeralBroods())
            {
                out.write("<tr><td><a href=\"\" rel=\"locationPopup.jsp?locid="+ b.getLocation() +"\" title=\"Tile "+ b.getLocation() +"\" class=\"locpopup\">" + b.getLocation() + "</a>" );
                out.write("</td><td>" +  b.getMembers().size());
                out.write("</td><td>" + b.getGoals()[Brood.GOAL_SURVIVE]);
                out.write( "</td><td>" + b.getGoals()[Brood.GOAL_PROTECT] );
                out.write( "</td><td>" + b.getGoals()[Brood.GOAL_KILL_PSI] );
                out.write( "</td><td>" + b.getGoals()[Brood.GOAL_KILL_MUT] );
                out.write("</td><td>" +  b.getGoals()[Brood.GOAL_KILL_HUMAN] );
            }
            %>
                 </tbody>
            </table>
            Player Broods
            <table>
                <thead></thead>
                <tbody>
                    <%--
                  <%
                    for(Brood b : playerBroods.values())
                        for(Critter c : b.getMembers() )
                            ret.put(c.toJson());
                    %>
                     --%>
             </tbody>
        </table>
        </center>
        <script type="text/javascript">
            $(".locpopup").cluetip({activation: 'click', width: 500, closePosition: 'title', arrows: true});
        </script>
    </body>
<html>
