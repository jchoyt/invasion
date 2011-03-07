<%@ page import="invasion.util.*,invasion.ui.*,java.sql.*,invasion.dataobjects.*, invasion.pets.*,java.util.logging.*,org.json.*, java.io.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%!
    public final static String KEY = "/map/index.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}%><%
    log.finer("entering /map/index.jsp");
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    Alt alt = wazzit.getAlt();
    if( alt == null )
    {  //nobody is logged in
        log.warning("didn't find the alt in wazzit");
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
        StringWriter pollJson = new StringWriter();
        JSONArray alerts = new JSONArray();
        Poll.fullPoll( conn, pollJson, wazzit, alerts );
        JSONObject obj = new JSONObject( pollJson.toString() );
    %>
<html style="overflow: hidden; height: 100%;" >
<head>

    <%--{{{  imports, etc. --%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="language" content="en">

	<title>Invasion - power has its price</title>
    <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
    <link type="text/css" href="${css}/main.css" rel="stylesheet" />
    <link type="text/css" href="layout-default-latest.css" rel="stylesheet" />
    <link type="text/css" href="pop.css" rel="stylesheet" />
    <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="${js}/vel2jstools.js"></script>
    <script type="text/javascript" src="${js}/vel2js.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
    <script type="text/javascript" src="jquery.pop.js"></script>
    <script type="text/javascript" src="${js}/map.js"></script>
    <script type="text/javascript" src="${js}/jquery.layout.min-1.2.0.js"></script>
    <%--}}}--%>

    <%--  {{{ css --%>
	<style type="text/css">
        td { border:none;}
        table { border:none; }
	</style>
	<%--}}} --%>
</head>
	<body>

    <%--{{{  center pane--%>
    <div class="ui-layout-center">
        <%  if( !errorMsg.equals(WebUtils.EMPTY_STR) )
        {
            out.write( "<h3 class=\"error\">" + errorMsg + "</h3>");
        }
        if( !infoMsg.equals(WebUtils.EMPTY_STR) )
        {
            out.write( "<h3 class=\"info\">" + infoMsg + "</h3>");
        }%>
        <div id="announcements"></div>
        <div id="topBar" class="header ui-accordion-header ui-helper-reset ui-corner-top ui-accordion-header-active ui-state-active">
            <span style="float:left"><i>Welcome to Invasion!</i> &nbsp; You are <%=alt.getName()%><span id="stats-area">
            <%
                // JSONObject obj2 = Alt.getStats(conn, alt.getId());
                // JSONObject stats = new JSONObject();
                // stats.put("stats", obj2);
                VelocityUtil.applyTemplate(obj, "stats.vm", out);
            %></span></span>
            <span style="float:right;margin-right:10px"><span id="poll-indicator"><img alt="" src="/i/transmit.gif"/></span> Menu<div class="pop">
                    <p><a href="/disconnect">Disconnect</a></p>
                    <p><hr/></p>
                    <p><a href="#" onclick="setInterval( 'poll()', 10000);">Engage periodic poll</a></p>
                    <p><hr/></p>
                    <p><a href="#" onclick="alert('No uber map yet');">Uber Map</a></p>
                    <p><a href="http://wiki.soulcubes.com" target="_blank" >Wiki</a></p>
                    <p><a href="http://forums.soulcubes.com" target="_blank" >Forums</a></p>
                 </div>
             </span>&nbsp; <!-- &nbsp (or anything, actually) prevents float from collapsing -->
        </div>
        <div id="center-sections" class="ui-layout-content">
            <h6 id="msgs-hdr"><a href="#">Messages and Basic Actions</a></h6>
            <div>
                <div id="messcontainer" class="mapbox" style="height:250px;width:100%;float:left">
                    <div id="amessages" style="height: 200px;border:1px solid black;margin-bottom:5px;" class="ui-layout-content">
                        <ul id="msg-box" class="msgs">
                        <%
                            // JSONArray a = Message.getInitialMessages(conn, wazzit.getAlt().getId());
                            // JSONObject obj = new JSONObject();
                            // obj.put("msgs", a);
                            VelocityUtil.applyTemplate(obj, "messages.vm", out);
                        %>
                        </ul>
                    </div>
                    <form method="post" action="speak" onsubmit="speak(this); return false">
                        <button type="submit">Speak (<span id="spts">0</span> AP)</button>
                        <input name="words" type="input" size="50">
                    </form>
                   <script type="text/javascript">
                        $("#amessages").scrollTop($("#amessages").attr("scrollHeight"));
                   </script>

                </div>
            </div>
            <h6 id="basic"><a href="#">Location Description</a></h6>
            <div id="basic-description">
                <%
                    obj.put("location", Location.getSummary( conn, wazzit.getAlt().getLocation() ) );
                    VelocityUtil.applyTemplate( obj, "locationDescription.vm", out );
                %>
            </div>
            <h6><a href="#">Actions</a></h6>
            <div>
                <p>
                <%--  <form method="post" action="#" onsubmit="attack(this.target.value); return false">
                    <select name="target" id="attacklist">
                        <%
                            //a = Location.getOccupants(conn, wazzit.getAlt().getLocation(), wazzit.getAlt().getId());
                            //obj = new JSONObject();
                            //obj.put("occs", a);
                            VelocityUtil.applyTemplate(obj, "attacklist.vm", out);
                        %>
                    </select>
                    <input type="submit" value="Attack"/>
                </form>
                <form method="post" action="equip" onsubmit="equip.jsp">
                    <select name="weaponid" id="equiplist">
                    <%
                        //a = Item.getItems(conn, alt.getId());
                        //obj = new JSONObject();
                        //obj.put("inv", a);
                        VelocityUtil.applyTemplate(obj, "equiplist.vm", out);
                    %>
                    </select>
                    <input type="submit" value="Equip Weapon"/>
                </form> --%>
                </p>
            </div>
        </div>
        <!-- ui-dialog -->
		<div id="dialog" title="Dialog Title">
			<p>There has been an exception.  Check <a href="editLocation.jsp?locid=1001625">here</a> to see what the problem may have been</p>
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
            <div>
                <table style="width:290px" cellpadding="0" cellspacing="0" border="0" id="occ-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Lvl</th>
                            <th>HP</th>
                            <th>Act</th>
                        </tr>
                    </thead>
                    <tbody id="occ-pane">
                        <%
                            // a = Location.getOccupants(conn, wazzit.getAlt().getLocation(), wazzit.getAlt().getId());
                            // obj = new JSONObject();
                            // obj.put("occs", a);
                            VelocityUtil.applyTemplate(obj, "occupants.vm", out);
                        %>
                    </tbody>
                </table>
                <center><div id="att-box" style="color:red"></div></center>
            </div>
            <h6 id="critters"><a href="#">Critters</a></h6>
            <div>
                <table style="width:100%" cellpadding="0" cellspacing="0" border="0" id="occ-table">
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>HP</th>
                            <th>Act</th>
                        </tr>
                    </thead>
                    <tbody id="pet-pane">
                        <%
                            // a = Critter.petsAtLocation( wazzit.getAlt().getLocation() );
                            // obj = new JSONObject();
                            // obj.put("pets", a);
                            VelocityUtil.applyTemplate(obj, "critterpane.vm", out);
                        %>
                    </tbody>
                </table>
                <center><div id="att-pet-box" style="color:red"></div></center>
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
    </div>
    <%--}}}--%>

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
                    VelocityUtil.applyTemplate(obj, "stats2.vm", out);
                %></span>
            </div>
            <h3 id="inv-pane"><a href="#">Inventory</a></h3>
            <div>
                <form id="inv-form">
                <table style="width:320px" cellpadding="0" cellspacing="0" border="0">
                    <thead><tr><th>Name</th><th>Wt</th><th>Act</th></tr></thead>
                    <tbody id="inv-body">
                        <%
                            // a = Item.getItems(conn, alt.getId());
                            // obj = new JSONObject();
                            // obj.put("inv", a);
                            VelocityUtil.applyTemplate(obj, "inventory.vm", out);
                        %>
                    </tbody>
                </table>
                </form>
            </div>
            <h3><a href="#">Skills</a></h3>
            <div>
                <p>
                There are skills.  Yours don't do anything.
                </p>
            </div>
        </div>

        <%-- <h4>Accordion inside DIV.ui-layout-content</h4> --%>
    </div>
    <%--}}}--%>
    <%
        }
        catch(Exception e)
        {
            e.printStackTrace();
            out.write("Error retrieving stats");
        }
        finally
        {
            DatabaseUtility.close(conn);
        }
    %>

	<!-- So apparently loading JS blocks download 'till it's done. Either way, it's easier to find here. -->
	<%--{{{  javascript --%>
	<script type="text/javascript">
        function chalkWall()
        {
            resource = "/map/chalk.jsp";
            $('#dialog').load(resource, function() {
				$('#dialog').dialog('open');
				$('#poll-indicator').hide();
			});
			$('poll-indicator').show();
            return false;
        }

		// Never try to jquery without making sure the DOM is ready. Ready() ensures that.
		$(document).ready(function() {
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
			
			$('.pop_menu > p > a').click(function() {
				$('.pop').removeClass('active');
				return false;
			});
		});
	</script>
    <%--}}}--%>

	</body>
</html>

<%-- :wrap=none:noTabs=true:collapseFolds=1:maxLineLen=160:indentSize=4:folding=explicit: --%>