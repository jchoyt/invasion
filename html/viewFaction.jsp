<%@ page import="invasion.util.*,org.json.*,invasion.dataobjects.*,invasion.ui.*,java.io.*,java.sql.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String id_string = WebUtils.getRequiredParameter(request, "id");
    int id = Integer.parseInt(id_string);
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    Alt alt = null;
    if( wazzit != null )
    {
        alt = wazzit.getAlt();
    }
    Faction thisFaction = Faction.getFaction( id );
    if( thisFaction == null )
    {
        response.sendRedirect( WebUtils.BASE + "index.jsp?error=That faction does not exist.");
        return;
    }
    String query = "";
    InvasionConnection conn = null;
    try
    {
        conn = new InvasionConnection();
        %><html>
        <head>
            <link type="text/css" href="${css}/redmond/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
            <link type="text/css" href="${css}/main.css" rel="stylesheet" />
            <script type="text/javascript" src="${js}/jquery-1.6.2.min.js"></script>
            <script type="text/javascript" src="${js}/jquery-ui-1.8.14.custom.min.js"></script>
            <script type="text/javascript" src="${js}/jquery.validate.js"></script>
            <style type="text/css">
                .box { width:50%; height:250px;padding:10px; }
                .toomuch { color: gray;  }
                .human-banner { width: 700px; padding:10px; border: solid 3px #666666; background-color:#cccccc; color:black; font-size: 40px; text-align: center; vertical-align:middle;}
                .tikkun-banner { width: 700px; padding:10px; border: solid 3px #990033; background-color:#ffcccc; color:black; font-size: 40px; text-align: center; vertical-align:middle;}
                .tohu-banner { width: 700px; padding:10px; border: solid 3px #006633; background-color:#99ff99; color:black; font-size: 40px; text-align: center; vertical-align:middle;}
            </style>
            <script type="text/javascript">
                $(document).ready(function() {
                    // Dialog
                    $('#dialog').dialog({
                        autoOpen: false,
                        width: 400,
                        buttons: {
                            "Cancel": function() {
                                $(this).dialog("close");
                            },
                            "Yes": function() {
                                $("#confirmjoin").submit();
                            }
                        }
                    });

                    // set up accordion
                    $("#accordion").accordion({ header: "h3" });

                    //set up join button
                    $("#joinbutton").button().click(function() { $('#dialog').dialog('open'); });;

                });
            </script>


        </head>
        <body>
            <center>
                <%-- if the faction has a banner...
                <img alt="logo" src="${images}/banner.png"/>--%>
                <br/>
                <div class="human-banner"><%=thisFaction.getName()%></div>
                <br/>
            </center>
            <div id="summary" style="width:700px;border:solid 1px black;margin:auto ">
                <div class="box" style="float:right;">
                    <div id="accordion">
                        <h3><a href="#">Members</a></h3>
                        <div>
                            <p>Mauris mauris ante, blandit et, ultrices a, suscipit eget, quam. Integer ut neque. Vivamus nisi metus, molestie vel, gravida in, condimentum sit amet, nunc. Nam a nibh. Donec suscipit eros. Nam mi. Proin viverra leo ut odio. Curabitur malesuada. Vestibulum a velit eu ante scelerisque vulputate.</p>
                        </div>
                        <h3><a href="#">Captured Flags</a></h3>
                        <div>
                            <p>Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In suscipit faucibus urna. </p>
                        </div>
                        <h3><a href="#">Politics</a></h3>
                        <div>
                            <p>Nam enim risus, molestie et, porta ac, aliquam ac, risus. Quisque lobortis. Phasellus pellentesque purus in massa. Aenean in pede. Phasellus ac libero ac tellus pellentesque semper. Sed ac felis. Sed commodo, magna quis lacinia ornare, quam ante aliquam nisi, eu iaculis leo purus venenatis dui. </p>
                            <ul>
                                <li>List item one</li>
                                <li>List item two</li>
                                <li>List item three</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="box">
                    <b><%=thisFaction.getName()%></b>
                    <br/><i><%=thisFaction.getDescription()%></i>
                    <br/><b>Race:</b> <%=Constants.RACENAMES[thisFaction.getType()]%>
                    <br/><b>Prestige:</b> <%=thisFaction.getPrestige()%>
                    <br/><b>Created by:</b> <%=Alt.load(conn, thisFaction.getCreatedby()).getName()%>
                    <%  if( alt != null //a character is logged in}
                            && ( alt.getRace() == Constants.HUMAN || alt.getRace() == thisFaction.getType() )  //correct race)
                            && alt.getFactionId() != thisFaction.getId()  //not already in the faction
                        )
                        {
                            %><br/><button id="joinbutton">Join <%=thisFaction.getName()%></button>
                      <%}%>
                </div>
            </div>

            <center>
                <br clear="all"/><%-- <a href="${base}map/index.jsp">Back</a> --%>
                <a href="javascript: history.go(-1)">Back</a> | <a href="javascript: alert('Not implemented yet');">Purchase Faction Banner</a>
            </center>

            <!-- ui-dialog -->
            <div id="dialog" title="Skill Purchase Attempt" style="text-align:center;">
                Are you sure you want to join <%=thisFaction.getName()%>?
                <form id="confirmjoin" action="map/joinFaction">
                    <input type="hidden" name="factionid" value="<%=thisFaction.getId()%>"/>
                </form>
            </div>
        </body>
        </html>
<%
    }
    catch(SQLException e)
    {
        throw new RuntimeException(e);
    }
    finally
    {
        conn.close();
    }
%>
