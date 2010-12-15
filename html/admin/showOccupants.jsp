<%@ page import="invasion.util.*,java.sql.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String station = WebUtils.getRequiredParameter(request, "station");
    int sid = Integer.parseInt(station);
%>
<html>
    <head>
        <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
        <link type="text/css" href="${css}/main.css" rel="stylesheet" />
        <link type="text/css" href="${css}/jquery.cluetip.css" rel="stylesheet" />
        <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
        <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
        <script type="text/javascript" src="${js}/jquery.cluetip.js"></script>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>
        <div style="float:left;margin:2em;">
            <h3>Character Location Summary</h3>
            <% String query = "select location, count(id) as count from alt a where station=? group by location";
                InvasionConnection conn = new InvasionConnection();
                ResultSet rs = conn.psExecuteQuery( query, "", sid );
                DatabaseUtility.genericTable(rs, out);
                DatabaseUtility.close(rs);
            %>
        </div>
        <div style="float:left;margin:2em;">
            <h3>Critter Location Summary</h3>
            <%  query = "select location, count(c.id) from critters c join brood b on c.brood = b.id join location l on b.location = l.id where station=? group by location order by location;";
                rs = conn.psExecuteQuery( query, "", sid );
                DatabaseUtility.genericTable(rs, out);
                DatabaseUtility.close(rs);
            %>
        <script type="text/javascript">
            $(".locpopup").cluetip({activation: 'click', width: 500, closePosition: 'title', arrows: true});
        </script>
        </div>
    </body>
<html>
