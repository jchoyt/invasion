<%@ page import="invasion.util.*,invasion.ui.*,java.sql.*,invasion.dataobjects.*, java.util.logging.*;" %><%!
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
    <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="${js}/vel2jstools.js"></script>
    <script type="text/javascript" src="${js}/vel2js.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
    <script type="text/javascript" src="${js}/jquery.validate.js"></script>
    <script type="text/javascript" src="${js}/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="${js}/jquery.layout.min-1.2.0.js"></script> <%--}}}--%>

    <%--  {{{ css --%>
	<style type="text/css">
        td { border:none;}
        table { border:none; }
	</style> <%--}}} --%>

	<%--{{{  javascript --%>
	<script type="text/javascript">
        var myLayout; // init global vars
        $(document).ready( function() {

            myLayout = $('body').layout({
                // RESIZE Accordion widget when panes resize
            	// west__onresize:		function () { $("#accordion1").accordion("resize"); },
            	//east__onresize:		function () { $("#accordion").accordion("resize"); },
            	east:  {initClosed: true, slideTrigger_open: "click", size: 350 },
                west: { size: 320, resizable: false }

            });

                // ACCORDION - in the East pane - in a 'content-div'
            $("#accordion").accordion({
                //fillSpace: true,
                active: 0,
                collapsible: true,
                autoHeight: false
            });

            $("#west-sections").addClass("ui-accordion ui-widget ui-helper-reset")
            .find("h6")
                .addClass("ui-accordion-header ui-helper-reset ui-state-default ui-corner-top ui-corner-bottom")
                .prepend('<span class="ui-icon ui-icon-triangle-1-e"/>')
                .click(function() {
                    $(this).toggleClass("ui-accordion-header-active").toggleClass("ui-state-active")
                        .toggleClass("ui-state-default").toggleClass("ui-corner-bottom")
                    .find("> .ui-icon").toggleClass("ui-icon-triangle-1-e").toggleClass("ui-icon-triangle-1-s")
                    .end().next().toggleClass("ui-accordion-content-active").toggle();
                    return false;
                })
                .next().addClass("ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom").hide();


            $("#center-sections").addClass("ui-accordion ui-widget ui-helper-reset")
            .find("h6")
                .addClass("ui-accordion-header ui-helper-reset ui-state-default ui-corner-top ui-corner-bottom")
                .prepend('<span class="ui-icon ui-icon-triangle-1-e"/>')
                .click(function() {
                    $(this).toggleClass("ui-accordion-header-active").toggleClass("ui-state-active")
                        .toggleClass("ui-state-default").toggleClass("ui-corner-bottom")
                    .find("> .ui-icon").toggleClass("ui-icon-triangle-1-e").toggleClass("ui-icon-triangle-1-s")
                    .end().next().toggleClass("ui-accordion-content-active").toggle();
                    return false;
                })
                .next().addClass("ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom").hide();

            $("#map").click();
            $("#occupants").click();
            $("#msgs-hdr").click();
            $("#basic").click();

            // assumption is on polling, we do $(document).trigger('POLL_COMPLETE', <json data>);
            $(document).bind('POLL_COMPLETE', function(e, data){ updateMessagePane(data); });
            $(document).bind('POLL_COMPLETE', function(e, data){ updateOccupantPane(data); });
            //$(document).bind('POLL_COMPLETE', function(e, data){ updateInventory(data); });
        });

        function drop( itemid )
        {
            var url = "drop.jsp?itemid=" + itemid;
            $.getJSON(url, function(json){
                //$(document).trigger('POLL_COMPLETE', json)
                updateInventory(json);
            });
        }

        function eat( itemid )
        {
            var url = "eat.jsp?itemid=" + itemid;
            $.getJSON(url, function(json){
                //$(document).trigger('POLL_COMPLETE', json)
                updateInventory(json);
            });
        }

        function drink( itemid )
        {
            var url = "drink.jsp?itemid=" + itemid;
            $.getJSON(url, function(json){
                //$(document).trigger('POLL_COMPLETE', json)
                updateInventory(json);
            });
        }


        function updateMessagePane(data)
        {
            v2js_inventory(data);
            // var d = new Date();
            // $.each(data.msgs, function(i,item){
            //     $('#msg-box').append("<li>" + item.msg + " (" + d + ")</li>");
            // });
            $("#amessages").attr({ scrollTop: $("#amessages").attr("scrollHeight") });
        }

        function updateOccupantPane(data)
        {
            $('#occ-pane').html("");
            $.each(data.occ, function(i, item){
                $('#occ-pane').append( item.name );
            });
        }

        function updateInventory(data)
        {
            if(true)
            {
                $("#inv-body").html( v2js_inventory(data) );
            }
        }

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

	<%--{{{  north pane--%>
    <div class="ui-layout-north">
        <% //get char stats
        InvasionConnection conn = null;
        ResultSet rs = null;
        try{
            String query = "select * from alt where id=" + alt.getId();
            log.finer(query);
            conn = new InvasionConnection();
            rs = conn.executeQuery(query);
            if( rs.next() )
            {

        %>
        <center>
        <table border="0" width="100%" cellspacing="0">
            <tbody>
                <tr>
                    <td style="width:250px"><img alt="Invasion banner" src="${images}/banner_sm.png"/></td>
                    <td style="text-align:left;"><strong><a href="/viewCharacter.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("name")%></a></strong><br/>
                        <strong>XP:</strong> <%=rs.getString("xp")%><br/>
                        <%-- <strong>Faction:</strong>  HA! Not even implemented! --%>
                    </td>
                    <td class="stat"><span class="stat_name">HP</span><br/><span class="hp"><%=rs.getString("hp")%></span></td>
                    <td class="stat"><span class="stat_name">IP</span><br/><span class="ip"><%=rs.getString("ip")%></span></td>
                    <td class="stat"><span class="stat_name">AP</span><br/><span class="ap"><%=rs.getString("ap")%></span></td>
                    <td style="text-align:right;padding-right:15px;"><a href="/disconnect.jsp" class="link_button ui-state-default ui-corner-all">Disconnect</a></td>
                </tr>
            </tbody>
        </table>
        </center>

        <%
            }
            else
            {
                log.warning("Alt " + alt.getId() + " not found.");
                response.sendRedirect("/index.jsp");
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
            out.write("Error retrieving stats");
        }
        finally
        {
            DatabaseUtility.close(rs);
            conn.close();
        }

        %>

    </div> <%--}}}--%>

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
        <div id="center-sections" class="ui-layout-content">
            <h6 id="msgs-hdr"><a href="#">Messages and Basic Actions</a></h6>
            <div>
                <div id="messcontainer" class="mapbox" style="height:250px;width:100%;float:left">
                    <div id="amessages" style="height: 200px;border:1px solid black;margin-bottom:5px;" class="ui-layout-content">
                        <ul id="msg-box" class="msgs">
                        <% VelocityUtil.applyTemplate(Message.getInitialMessages(wazzit.getAlt().getId()), "messages.vm", out);%>
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
                <p>You are standing inside <i>Forgotten Office Building.</i> (A <a target="_new" href="http://wiki.nexuswar.com/index.php/Forgotten_Office_Building">Forgotten Office Building</a>)</p>
                <p>The building's floors are filled with empty, cobweb ridden cubicles. The elevators no longer work.  The door has been left <i>open</i>. Lights are <i>on</i> inside.</p>
                <p>The mists in the void are producing very little light.  Marquai's symbol shines brightly in the mists.  There is a corpse here.</p>
                <p>Someone has written <i>Dude. Not cool. </i> in chalk on a wall.</p>
                <p>This location has been <i>infused</i> and is aligned to <a class="pln" href="http://www.nexuswar.com/factions/view.do?factionID=908">The Watchers</a>.</p>
            </div>
            <h6><a href="#">Skills</a></h6>
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
            <h6><a href="#">Attack</a></h6>
            <div>
                <p>
                Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
                purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
                velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
                suscipit faucibus urna.
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
            <h6 id="occupants"><a href="#">Occupants</a></h6>
            <div id="occ-pane">
                <%--
                <% VelocityUtil.applyTemplate(Message.getInitialMessages(alt.getId()), "messages.vm", out);%>
                --%>
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
                        <% VelocityUtil.applyTemplate(Location.getOccupants(wazzit.getLocid(), alt.getId()), "occupants.vm", out); %>
                    </tbody>
                </table>
                <%-- <script type="text/javascript" charset="utf-8">
                    $("#occ-table").dataTable( {
                        "aaSorting": [[ 0, "asc" ]],
                        //"aoColumns": [ null, null, null, null ],
                        "bJQueryUI": true,
                        "sDom":'<"H"lr>t<"F"p>',
                        "sPaginationType": "two_button"
                    } );
                </script> --%>
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
            <h3 id="inv-pane"><a href="#">Inventory</a></h3>
            <div>
                <%--
                <% VelocityUtil.applyTemplate(Message.getInitialMessages(alt.getId()), "messages.vm", out);%>
                --%>
                <form id="inv-form">
                <table style="width:320px" cellpadding="0" cellspacing="0" border="0">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <%-- <th>Qty</th> --%>
                            <th>Wt</th>
                            <th>Act</th>
                        </tr>
                    </thead>
                    <tbody id="inv-body">
                        <% VelocityUtil.applyTemplate(Item.getItems(alt.getId()), "inventory.vm", out); %>
                    </tbody>
                </table>
                </form>
            </div>
            <h3><a href="#">Other stuff</a></h3>
            <div>
                <p>
                Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
                purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
                velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
                suscipit faucibus urna.
                </p>
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

	</body>
</html>

<%-- :wrap=none:noTabs=true:collapseFolds=1:maxLineLen=160:indentSize=4:folding=explicit: --%>