<!DOCTYPE HTML>
<%@ page import="invasion.util.*,invasion.ui.*,java.sql.*,invasion.dataobjects.*, invasion.pets.*,java.util.logging.*,org.json.*, java.io.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%!
    public final static String KEY = WebUtils.BASE + "map/index.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    // static{log.setLevel(Level.FINER);}%><%
    log.finer("entering /map/index.jsp");
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    Alt alt = wazzit.getAlt();
    if( alt == null )
    {  //nobody is logged in
        log.warning("didn't find the alt in wazzit");
        response.sendRedirect( WebUtils.BASE + "index.jsp");
        return;
    }
    String errorMsg = wazzit.getAlt().getName() + " is dead. <a href=\"" + WebUtils.BASE + "disconnect\">Go back</a> and select another character.";
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
    <link type="text/css" href="${css}/redmond/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
    <link type="text/css" href="${css}/main.css" rel="stylesheet" />
    <link type="text/css" href="layout-default-latest.css" rel="stylesheet" />
    <link type="text/css" href="pop.css" rel="stylesheet" />
    <script type="text/javascript" src="${js}/jquery-1.6.2.min.js"></script>
    <script type="text/javascript" src="${js}/vel2jstools.js"></script>
    <script type="text/javascript" src="${js}/vel2js.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.8.14.custom.min.js"></script>
    <script type="text/javascript" src="jquery.pop.js"></script>
    <script type="text/javascript" src="${js}/map.js"></script>
    <script type="text/javascript" src="${js}/jquery.layout.min-1.3.0rc29.js"></script>
    <%--}}}--%>

    <%--  {{{ css --%>
	<style type="text/css">
        td { border:none;}
        table { border:none; }
	</style>
	<%--}}} --%>
</head>
	<body id="wholeEnchilada" style="height:100%;">

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
                VelocityUtil.applyTemplate(obj, "stats.vm", out);
            %></span></span>
            <span style="float:right;margin-right:10px"><span id="poll-indicator"><img alt="" src="${images}/transmit.gif"/></span> Menu<div class="pop">
                    <p><a href="${base}disconnect">Disconnect</a></p>
                    <p><hr/></p>
                    <p><a href="#" onclick="setInterval( 'poll()', 10000);">Engage periodic poll</a></p>
                    <p><hr/></p>
                    <p><a href="#" onclick="alert('No uber map yet');">Uber Map</a></p>
                    <p><a href="http://soulcubes.com/docs" target="_blank" >Documentation</a></p>
                    <p><a href="http://soulcubes.com/boards" target="_blank" >Forums</a></p>
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
                            VelocityUtil.applyTemplate(obj, "messages.vm", out);
                        %>
                        </ul>
                    </div>
                    <form method="post" action="speak">
                        <button type="submit">Speak (<span id="spts">0</span> AP)</button>
                        <input name="words" type="input" size="50">
                    </form>
                </div>
            </div>
            <h6 id="basic"><a href="#">Location Description</a></h6>
            <div id="basic-description">
                You are dead. There is no sensation or concept of time. For some reason you can still manage your inventory. Go figure.
            </div>
        </div>
    </div> <%--}}}--%>

    <%--{{{  east pane --%>
    <div class="ui-layout-east">
        <div id="accordion" class="ui-layout-content">
            <h3><a href="#">Character Info</a></h3>
            <div>
                <img alt="Invasion banner" src="${images}/banner_sm.png"/>
                <br/>You are <a href="${base}viewCharacter.jsp?id=<%=alt.getId()%>"><%=alt.getName()%></a>
                <br/>Faction: None
                <br/><span id="stats-area2">
                <%
                    VelocityUtil.applyTemplate(obj, "stats2.vm", out);
                %></span>
            </div>
            <h3 id="inv-pane"><a href="#">Inventory</a></h3>
            <div>
                <form id="inv-form">
                <table style="width:100%" cellpadding="0" cellspacing="0" border="0">
                    <thead><tr><th>Name</th><th>#</th></th><th>Wt</th><th>Act</th></tr></thead>
                    <tbody id="inv-body">
                        <%
                            VelocityUtil.applyTemplate(obj, "inventory.vm", out);
                        %>
                    </tbody>
                </table>
                <center><a href="#" onclick="$('#inv-mgmt-dlg').dialog('open');return false;" class="command">Manage Inventory</a></center>
                </form>
            </div>
            <h3><a href="#">Skills</a></h3>
            <div>
                <p>
                <tags:UseSkill/>
                </p>
            </div>
        </div>

        <%-- <h4>Accordion inside DIV.ui-layout-content</h4> --%>
    </div>
    <%--}}}--%>

    <%--{{{ dialogs --%>
    <div id="inv-mgmt-dlg" title="Inventory Management">
        <form>
            <select name="action">
                <option>Drop</option>
                <option>Place on Ground</option>
                <option>Give to...</option>
                <option>Put in locker...</option>
                <option>Put in faction safe</option>
            </select>
            <br/>
            <select style="float:left;" name="itemid" id="inv-list" size="10" multiple="true">
                <%
                    VelocityUtil.applyTemplate(obj, "inventoryManagement.vm", out);
                %>
            </select> * Ctrl+click to select multiple items to operate on at once.
        </form>
    </div>
    <%--}}}--%>
    <%
        }
        catch(Exception e)
        {
            log.throwing(KEY, "Body", e);
            String errFile = WebUtils.dumpError(e);
            out.write("Error retrieving stats. Details can be found at " + errFile );
        }
        finally
        {
            DatabaseUtility.close(conn);
        }
    %>
	<%--{{{  javascript --%>
	<script type="text/javascript">
		// Never try to jquery without making sure the DOM is ready. Ready() ensures that...once working, move this stuff to map.js
		$(document).ready(function() {
			$("#amessages").scrollTop($("#amessages").attr("scrollHeight"));
			// Scroll the message pane.

			// Dialog
            $('#inv-mgmt-dlg').dialog({
                autoOpen: false,
                width: 400,
                buttons: {
                    "Cancel": function() {
                        $(this).dialog("close");
                    },
                    "Submit": function() {
                        alert('Do ajax submit');
                    }
                }
            });
		});
	</script>
    <%--}}}--%>

	</body>
</html>

<%-- :wrap=none:noTabs=true:collapseFolds=1:maxLineLen=160:indentSize=4:folding=explicit: --%>