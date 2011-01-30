<%@ page import="invasion.util.*,invasion.ui.*,java.sql.*,invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%!
    public final static String KEY = "/map/index.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}%><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    Alt alt = wazzit.getAlt();
    String errorMsg = wazzit.getAlt().getName() + " is dead. <a href=\"/disconnect.jsp\">Go back</a> and select another character.";

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

	<title>Invasion - power has its price</title>
    <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
    <link type="text/css" href="${css}/main.css" rel="stylesheet" />
    <link type="text/css" href="layout-default-latest.css" rel="stylesheet" />
    <link type="text/css" href="pop.css" rel="stylesheet" />
    <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="${js}/vel2jstools.js"></script>
    <script type="text/javascript" src="${js}/vel2js.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
    <script type="text/javascript" src="${js}/jquery.validate.js"></script>
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
        <h3 class="error"><%=errorMsg%></h3>
        <div class="header ui-accordion-header ui-helper-reset ui-corner-top ui-accordion-header-active ui-state-active">
            <span style="float:left"><i>Welcome to Invasion!</i> &nbsp; You are <%=alt.getName()%><span id="stats-area">
            <%
                JSONObject obj2 = Alt.getStats(conn, alt.getId());
                JSONObject stats = new JSONObject();
                stats.put("stats", obj2);
                VelocityUtil.applyTemplate(stats, "stats.vm", out);
            %></span></span>
            <span style="float:right;margin-right:10px">Menu<div class="pop">
                    <p><a href="/disconnect.jsp">Disconnect</a></p>
                    <p><hr/></p>
                    <p><a href="#" onclick="setInterval( 'poll()', 10000);">Engage regular poll</a></p>
                    <p><hr/></p>
                    <p><a href="#" target="_blank">Uber Map</a></p>
                    <p><a href="http://wiki.chaoschaoschaos.com/wiki/Invasion" target="_blank">Wiki</a></p>
                    <p><a href="#" target="_blank">Forums</a></p>
                 </div>
             </span><br clear="all"/>
        </div>
        <div id="center-sections" class="ui-layout-content">
            <h6 id="msgs-hdr"><a href="#">Messages</a></h6>
            <div>
                <div id="messcontainer" class="mapbox" style="width:100%;float:left">
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
                   <script type="text/javascript">
                        $("#amessages").attr({ scrollTop: $("#amessages").attr("scrollHeight") });
                   </script>

                </div>
            </div>
            <h6 id="basic"><a href="#">Location Description</a></h6>
            <div id="basic-description">
                <p>You are dead.  There is no sensation or concept of time.  For some reason you can still manage your inventory.  Go figure. </p>
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
            conn.close();
        }
    %>
	</body>
</html>

<%-- :wrap=none:noTabs=true:collapseFolds=1:maxLineLen=160:indentSize=4:folding=explicit: --%>