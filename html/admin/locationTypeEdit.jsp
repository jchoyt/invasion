<%@ page import="invasion.util.*,org.json.*,invasion.dataobjects.*,invasion.ui.*,java.io.*,java.sql.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String id_string = WebUtils.getRequiredParameter(request, "id");
    int id = Integer.parseInt(id_string);
    InvasionConnection conn = new InvasionConnection();
    request.setAttribute("conn", conn);
    LocationType loctype = LocationType.getLocationType(id);
%><html>
<head>
    <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
    <link type="text/css" href="${css}/main.css" rel="stylesheet" />
    <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
    <script type="text/javascript" src="${js}/jquery.validate.js"></script>
    <style type="text/css">
        .box { width:250px;padding:10px; }
    </style>
    <script type="text/javascript">
        $(function(){
            // Tabs
            $('#tabs').tabs( { selected: 0 });

            // Dialog
            $('#dialog').dialog({
                autoOpen: false,
                width: 600,
                buttons: {
                    "Cancel": function() {
                        $(this).dialog("close");
                    }
                }
            });
        });

        function buildSrForm( srid )
        {
            var whichone = "td#sr" + srid;
            // alert(whichone);
            form = "<form action=\"editSrRate.jsp\">New search rate: <input name=\"newrate\" type=\"text\" size=\"3\"/><input type=\"hidden\" name=\"srid\" value=\"" + srid + "\"/>";
            form = form + "<input type=\"hidden\" name=\"locid\" value=\"" + <%=id_string%> + "\"/><br/><input type=\"submit\"/></form>";
            $(whichone).html(form);
            // alert(form);
            return false;
        }

        function allTimes10()
        {
            $.post("editSrRateTimes10.jsp", { "locid": "<%=id_string%>" }, function(data){ location.reload(true); } );
        }

        function deleteSr( srid )
        {
            $.post("deleteSrRate.jsp", { "srid": srid }, function(data){ location.reload(true); } );
        }

        function add()
        {
            $('#dialog').dialog('open');
        }
    </script>


</head>
<body>
    <center>
        <img alt="logo" src="${images}/banner.png"/>
        <br/>
        <h3><%=loctype.getName()%></h3>
        <br/>
        <br/>
        <i>Search rate:</i>  <%= (loctype.getSearchrate() * 100) %>%
        <br/>
        <br/>
        <div id="tabs" style="width:500px;">
            <ul>
                <li><a href="#tabs-1">Search Rates</a></li>
                <li><a href="#tabs-2">Flavor</a></li>
            </ul>
            <div id="tabs-1">
                <table cellpadding="0">
                    <thead><tr><th>Item Type</th><th>Search Weight<sup>1</sup></th><th>Action</th></tr></thead>
                    <tbody>
                    <%
                        String query = "select t.name, o.odds, o.id from itemtype t join searchodds o on t.typeid=o.return where locationtype=? order by t.name";
                        ResultSet rs = conn.psExecuteQuery(query, "Blew chunks pulling search odds", id);
                        String srid = null;
                        while(rs.next())
                        {
                            srid = rs.getString("id");
                            out.write( "<tr><td>" + rs.getString("name") + "</td><td>" + rs.getString("odds") + "</td>");
                            out.write("<td id=\"sr" + srid + "\"><img src=\"/i/pencil.png\" onclick=\"buildSrForm(" + srid + ");\" title=\"edit search rate\"/><img src=\"/i/delete.png\" onclick=\"deleteSr(" + srid + ");\" title=\"delete this item from this location\"/></td></tr>\n");
                        }
                        DatabaseUtility.close(rs);
                    %>
                    </tbody>
                </table>
                <input type="button" onclick="alert('show the raw search percentages');" value="Show %"/> <input type="button" onclick="add();" value="Add" /> <input type="button" onclick="allTimes10();" value="All *10"/>

            </div>
            <div id="tabs-2">
                <div class="<%=loctype.getCssname() %>" style="width:55px;height:55px;">Color Test</div>
                <br/><br/>
                <b><u>Descriptions</u></b>
                <span style="text-align:left;">
                    <ul>
                    <%  query = "select * from locationdescriptions where typeid=?";
                        rs = conn.psExecuteQuery(query, "Blew chunks pulling search odds", id);
                        while(rs.next())
                        {
                            out.write( "<li>" + rs.getString("description") + "</li>\n");
                        }
                        DatabaseUtility.close(rs);
                    %>
                    </ul>
                </span>
                <!-- todo add descriptions tag -->
                <br/><br/>
                <b><u>Descriptions when you are insane (pending)</u></b>
                <%--
                <br/>
                <b><u>Psi Skills</u></b>
                <br/>
                <%
                    for( Skill s : Skills.getPsiSkills() )
                    {
                        printHave(thisguy, s, true, out);
                        out.write("<br/>");
                    }
                %>
                <br/>
                <br/>
                <b><u>Psi Skills</u></b>
                <br/>
                <%
                    for( Skill s : Skills.getPsiSkills() )
                    {
                        printHave(thisguy, s, true, out);
                        out.write("<br/>");
                    }
                %>
                --%>
            </div>
        </div>
        <br clear="all"/><a href="/map/index.jsp">Back</a>
    </center>
    <!-- ui-dialog -->
    <div id="dialog" title="Add a new item" style="text-align:center;">
        <form action="addSrRate.jsp">
            Item: <select name="itemid"><tags:Itemtypes/></select><br/>
            Search Weight: <input name="newrate" type="text" size="3"/><br/>
            <input type="submit" value="Add Item to <%=loctype.getName()%>">
            <input type="hidden" name="locid" value="<%=id_string%>"/>
        </form>
    </div>

</body>
    <div class="notes"><sup>1</sup> <b>Search Weight</b> is NOT the percent chance of finding a certain item.  It's the relative chances that once something is found, it's this object.  Examples:
        <ul>
            <li>Example 1:  Say the location has a search rate of 25% and two items, each with a weight of 1.  There would be a 75% chance of finding nothing, 12.5% chance of finding item 1 and 12.5% chance of finding item 2.</li>
            <li>Example 2:  Same as above, but Item 1 has a weight of 1 and Item 2 a weight of 4.   There would still be a 75% chance of finding nothing.  However a 5% chance of finding item 1 and a 20% chance of finding item 2.  You are 4 times more likely to find item 2 than item 1.</li>
        </ul>
    </div>
</html>
<% conn.close(); %>
