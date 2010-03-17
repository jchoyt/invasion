<%@ page import="invasion.util.*,invasion.ui.*,java.sql.*,invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%!
    public final static String KEY = "/map/index.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}%><%@

    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%

    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    if( wazzit == null )
    {  //nobody is logged in
        log.finer("Player is not logged in");
        response.sendRedirect("/index.jsp");
        return;
    }
    Alt alt = wazzit.getAlt();
    if( alt == null )
    {  //nobody is logged in
        log.finer("didn't find the alt in wazzit");
        response.sendRedirect("/index.jsp");
        return;
    }
    String errorMsg = WebUtils.getOptionalParameter(request, "error");
    String infoMsg = WebUtils.getOptionalParameter(request, "info");
    // log.entering(KEY, "html section.  Alt id is " + alt.getId());

    //set up db connection
    InvasionConnection conn = null;
    try{
        conn = new InvasionConnection();
    %>
<html style="overflow: hidden; height: 100%;" >
<head>

    <%--{{{  imports, etc. --%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="language" content="en">

	<title>Invasion - power has it's price</title>
    <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
    <link type="text/css" href="${css}/main.css" rel="stylesheet" />
    <link type="text/css" href="layout-default-latest.css" rel="stylesheet" />
    <link type="text/css" href="datatables.css" rel="stylesheet" />
    <link type="text/css" href="demo_table_jui.css" rel="stylesheet" />
    <link type="text/css" href="pop.css" rel="stylesheet" />
    <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="${js}/vel2jstools.js"></script>
    <script type="text/javascript" src="${js}/vel2js.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
    <script type="text/javascript" src="${js}/jquery.validate.js"></script>
    <script type="text/javascript" src="${js}/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="${js}/map.js"></script>
    <script type="text/javascript" src="jquery.pop.js"></script>
    <script type="text/javascript" src="${js}/jquery.layout.min-1.2.0.js"></script> <%--}}}--%>

    <%--  {{{ css --%>
	<style type="text/css">
        td { border:none;}
        table { border:none; }
	</style> <%--}}} --%>

	<%--{{{  javascript --%>
	<script type="text/javascript">
        function poll()
        {
            $.getJSON("json.js", function(json){
                $(document).trigger('POLL_COMPLETE', json)
            });
        }
	</script>
<%--}}}--%>

</head>
	<body>

    <%--{{{  center pane--%>
    <div class="ui-layout-center">
        <%  if( !errorMsg.equals(WebUtils.EMPTY_STR) )
        {
            out.write( "<h3 class=\"error\">" + errorMsg + "</h3>");
        }
        if( !errorMsg.equals(WebUtils.EMPTY_STR) )
        {
            out.write( "<h3 class=\"info\">" + infoMsg + "</h3>");
        }%>
        <div id="announcements"></div>
        <div class="header ui-accordion-header ui-helper-reset ui-corner-top ui-accordion-header-active ui-state-active">
            <span style="float:left"><i>Welcome to Invasion!</i> &nbsp; You are <%=alt.getName()%><span id="stats-area">
            <%
                JSONObject obj2 = Alt.getStats(conn, alt.getId());
                JSONObject stats = new JSONObject();
                stats.put("stats", obj2);
                VelocityUtil.applyTemplate(stats, "stats.vm", out);
            %></span></span><span style="float:right;margin-right:10px">Menu<div class="pop">
                    <p><a href="/disconnect.jsp">Disconnect</a></p>
                    <p><hr/></p>
                    <p><a href="#" target="_blank">Uber Map</a></p>
                    <p><a href="http://wiki.chaoschaoschaos.com/wiki/Invasion" target="_blank">Wiki</a></p>
                    <p><a href="#" target="_blank">Forums</a></p>
                 </div>
             </span><br clear="all"/>


        </div>
        <div id="center-sections" class="ui-layout-content">
            <h6 id="msgs-hdr"><a href="#">Messages and Basic Actions</a></h6>
            <div>
                <div id="messcontainer" class="mapbox" style="height:250px;width:100%;float:left">
                    <div id="amessages" style="height: 200px;border:1px solid black;margin-bottom:5px;" class="ui-layout-content">
                        <ul id="msg-box" class="msgs">
                        <%
                            JSONArray a = Message.getInitialMessages(conn, wazzit.getAlt().getId());
                            JSONObject obj = new JSONObject();
                            obj.put("msgs", a);
                            VelocityUtil.applyTemplate(obj, "messages.vm", out);
                        %>
                        </ul>
                    </div>
                    <form method="post" action="speak.jsp" onsubmit="speak(this); return false">
                        <button type="submit">Speak (<span id="spts">0</span> AP)</button>
                        <input name="words" type="input" size="50">
                    </form>
                    <%-- <a href="#" onclick="poll();">Test updateMessagePane()</a> --%>
                   <script type="text/javascript">
                        $("#amessages").attr({ scrollTop: $("#amessages").attr("scrollHeight") });
                   </script>

                </div>
            </div>
            <h6 id="basic"><a href="#">Location Description</a></h6>
            <div id="basic-description">
                <p>Nice descriptions were provide by Sam and Stretch, but Entomo's a lazy ass and hasn't put them in yet. </p>
                <p><input type="button" onclick="dosearch(1);" value="Search (1 AP)"/>  <input type="button" value="Search 5 times (5 AP)" onclick="dosearch(5);"/></p>
            </div>
            <h6><a href="#">Actions</a></h6>
            <div>
                <p>
                <form method="post" action="attack.jsp" onsubmit="attack(this); return false">
                    <select name="target" id="attacklist">
                        <%
                            a = Location.getOccupants(conn, wazzit.getLocid(), wazzit.getAlt().getId());
                            obj = new JSONObject();
                            obj.put("occs", a);
                            VelocityUtil.applyTemplate(obj, "attacklist.vm", out);
                        %>
                    </select>
                    <input type="submit" value="Attack"/>
                </form>
                <form method="post" action="equip.jsp" onsubmit="equip.jsp">
                    <select name="weaponid" id="equiplist">
                    <%
                        a = Item.getItems(conn, alt.getId());
                        obj = new JSONObject();
                        obj.put("inv", a);
                        VelocityUtil.applyTemplate(obj, "equiplist.vm", out);
                    %>
                    </select>
                    <input type="submit" value="Equip Weapon"/>
                </form>
                </p>
            </div>
        </div>
    </div> <%--}}}--%>

    <%--{{{  west pane --%>
    <div class="ui-layout-west">
        <div id="west-sections" class="ui-layout-content">
            <h6 id="map"><a href="#">Map</a></h6>
            <div style="height:340px">
                 <tags:NavPanel/>
            </div>
            <script type="text/javascript">
                function showtarget(id)
                {
                    show = "#desc-" + id;
                    $("#att-box").html($(show).html());
                };
            </script>

            <h6 id="occupants"><a href="#">Occupants</a></h6>
            <div id="occ-pane">
                <table style="width:290px" cellpadding="0" cellspacing="0" border="0" id="occ-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Lvl</th>
                            <th>HP</th>
                            <th>Act</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            a = Location.getOccupants(conn, wazzit.getLocid(), wazzit.getAlt().getId());
                            obj = new JSONObject();
                            obj.put("occs", a);
                            VelocityUtil.applyTemplate(obj, "occupants.vm", out);
                        %>
                    </tbody>
                </table>
                <center><div id="att-box" style="color:red"></div></center>
            </div>
            <h6><a href="#">Critters</a></h6>
            <div>
                <p>
                Nam enim risus, molestie et, porta ac, aliquam ac, risus. Quisque lobortis.
                Phasellus pellentesque purus in massa. Aenean in pede. Phasellus ac libero
                ac tellus pellentesque semper. Sed ac felis. Sed commodo, magna quis
                lacinia ornare, quam ante aliquam nisi, eu iaculis leo purus venenatis dui.
                </p>
                <ul>
                    <li>List item one</li>
                    <li>List item two</li>
                    <li>List item three</li>
                </ul>
            </div>
            <h6><a href="#">Items</a></h6>
            <div>
                <p>
                Cras dictum. Pellentesque habitant morbi tristique senectus et netus
                et malesuada fames ac turpis egestas. Vestibulum ante ipsum primis in
                faucibus orci luctus et ultrices posuere cubilia Curae; Aenean lacinia
                mauris vel est.
                </p>
                <p>
                Suspendisse eu nisl. Nullam ut libero. Integer dignissim consequat lectus.
                Class aptent taciti sociosqu ad litora torquent per conubia nostra, per
                inceptos himenaeos.
                </p>
            </div>
        </div>
    </div> <%--}}}--%>

    <%--{{{  east pane --%>
    <div class="ui-layout-east">
        <div id="accordion" class="ui-layout-content">
            <h3><a href="#">Character Info</a></h3>
            <div>
                <img alt="Invasion banner" src="${images}/banner_sm.png"/>
                <br/>You are <a href="/viewCharacter.jsp?id=<%=alt.getId()%>"><%=alt.getName()%></a>
                <br/>Faction: None
                <br/><span id="stats-area2">
                <%
                    VelocityUtil.applyTemplate(stats, "stats2.vm", out);
                %></span>
            </div>
            <h3 id="inv-pane"><a href="#">Inventory</a></h3>
            <div>
                <form id="inv-form">
                <table style="width:320px" cellpadding="0" cellspacing="0" border="0">
                    <thead><tr><th>Name</th><th>Wt</th><th>Act</th></tr></thead>
                    <tbody id="inv-body">
                        <%
                            a = Item.getItems(conn, alt.getId());
                            obj = new JSONObject();
                            obj.put("inv", a);
                            VelocityUtil.applyTemplate(obj, "inventory.vm", out);
                        %>
                    </tbody>
                </table>
                </form>
            </div>
            <h3><a href="#">I haven't</a></h3>
            <div>
                <p>
                Nam enim risus, molestie et, porta ac, aliquam ac, risus. Quisque lobortis.
                Phasellus pellentesque purus in massa. Aenean in pede. Phasellus ac libero
                ac tellus pellentesque semper. Sed ac felis. Sed commodo, magna quis
                lacinia ornare, quam ante aliquam nisi, eu iaculis leo purus venenatis dui.
                </p>
                <ul>
                    <li>List item one</li>
                    <li>List item two</li>
                    <li>List item three</li>
                </ul>
            </div>
            <h3><a href="#">decided on yet</a></h3>
            <div>
                <p>
                Cras dictum. Pellentesque habitant morbi tristique senectus et netus
                et malesuada fames ac turpis egestas. Vestibulum ante ipsum primis in
                faucibus orci luctus et ultrices posuere cubilia Curae; Aenean lacinia
                mauris vel est.
                </p>
                <p>
                Suspendisse eu nisl. Nullam ut libero. Integer dignissim consequat lectus.
                Class aptent taciti sociosqu ad litora torquent per conubia nostra, per
                inceptos himenaeos.
                </p>
            </div>
        </div>

        <%-- <h4>Accordion inside DIV.ui-layout-content</h4> --%>
    </div> <%--}}}--%>
    <%
        }
        catch(Exception e)
        {
            e.printStackTrace();
            out.write("Error retrieving stats");
        }
        finally
        {
            conn.close();
        }
    %>
	</body>
</html>

<%-- :wrap=none:noTabs=true:collapseFolds=1:maxLineLen=160:indentSize=4:folding=explicit: --%>