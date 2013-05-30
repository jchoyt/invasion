<%@ page import="invasion.util.*,org.json.*,invasion.dataobjects.*,invasion.ui.*,java.io.*,java.sql.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%!

/**
 * prints the list of members - suitable only for fitting into the accordion
 * @param
 * @return
 *
 */
protected void printMemberList( InvasionConnection conn, JspWriter out, Faction faction)
{
    String query = "select name, factionrank, level, race from alt where factionid=? order by factionrank desc";
    ResultSet rs = null;
    try
    {
        conn = new InvasionConnection();
        rs = conn.psExecuteQuery(query, "Error pulling member list for " + faction.getName(), faction.getId() );
        String name = null;
        while(rs.next())
        {
            name = rs.getString("name");
            if( rs.getInt("factionrank") == Constants.FACTION_LEADER )
            {
                name += " (Leader)";
            }

            out.write( name + " - level " + rs.getString( "level" ) + " " + Constants.RACENAMES[rs.getInt("race")] + "<br/>" );
        }
        DatabaseUtility.close(rs);
    }
    catch(Exception e)
    {
        throw new RuntimeException(e);
    }
    finally
    {
        DatabaseUtility.close(rs);
    }
}

/**
 * prints the faction politics - suitable only for fitting into the accordion
 * @param
 * @return
 *
 */
protected void printPolitics( InvasionConnection conn, JspWriter out, Faction faction)
{
    String query = "select name, setting from politics p join factions f on p.target=f.id where setter=? and f.id!=? order by setting desc";
    ResultSet rs = null;
    try
    {
        conn = new InvasionConnection();
        rs = conn.psExecuteQuery(query, "Error pulling politics for " + faction.getName(), faction.getId(), faction.getId() );
        String name = null;
        out.print("<b><u>Factions Considered Friendly</u></b><br/>");
        boolean switched = false;
        while(rs.next())
        {
            // show when we swtich from friently to hostile
            if( !switched && rs.getInt("setting") == Constants.HOSTILE_STATUS )
            {
                switched = !switched;
                out.print("<br/><b><u>Factions Considered Hostile</u></b><br/>");
            }
            out.write( rs.getString("name") + "<br/>" );
        }
        DatabaseUtility.close(rs);
    }
    catch(Exception e)
    {
        throw new RuntimeException(e);
    }
    finally
    {
        DatabaseUtility.close(rs);
    }
}


/**
 * prints the list of captured flags - suitable only for fitting into the accordion
 * @param
 * @return
 *
 */
protected void printMCapturedFlags( InvasionConnection conn, JspWriter out, Faction faction)
{
    String query = "select name from flagscaptured fc join factions f on fc.owner=f.id where holder=?";
    ResultSet rs = null;
    try
    {
        conn = new InvasionConnection();
        rs = conn.psExecuteQuery(query, "Error pulling politics for " + faction.getName(), faction.getId() );
        String name = null;
        boolean switched = false;
        while(rs.next())
        {
            out.write( rs.getString("name") + "<br/>"  );
        }
        DatabaseUtility.close(rs);
    }
    catch(Exception e)
    {
        throw new RuntimeException(e);
    }
    finally
    {
        DatabaseUtility.close(rs);
    }
}

%>

<%
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
    InvasionConnection conn = null;
    try
    {
        conn = new InvasionConnection();
        %><html>
        <head>
            <link type="text/css" href="${css}/redmond/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
            <link type="text/css" href="${css}/main.css" rel="stylesheet" />
            <link type="text/css" href="${css}/factionpages.css" rel="stylesheet" />
            <link type="text/css" href="${css}/cssfly.css" rel="stylesheet" />
            <script type="text/javascript" src="${js}/jquery-1.6.2.min.js"></script>
            <script type="text/javascript" src="${js}/jquery-ui-1.8.14.custom.min.js"></script>
            <script type="text/javascript" src="${js}/jquery.validate.js"></script>
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

                    $('#quitdialog').dialog({
                        autoOpen: false,
                        width: 400,
                        buttons: {
                            "Cancel": function() {
                                $(this).dialog("close");
                            },
                            "Yes": function() {
                                $("#confirmquit").submit();
                            }
                        }
                    });

                    // set up accordion
                    $("#accordion").accordion({ header: "h3" });
                    $("#summary").height($("#accordion").height() + 30 );
                    console.log($("#accordion"));

                    //set up join or quit button
                    $("#joinbutton").button().click(function() { $('#dialog').dialog('open'); });;
                    $("#quitbutton").button().click(function() { $('#quitdialog').dialog('open'); });;

                });
            </script>


        </head>
        <body>
            <jsp:include page="sitenav.jsp" />
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
                            <% printMemberList( conn, out, thisFaction ); %>
                        </div>
                        <h3><a href="#">Captured Flags</a></h3>
                        <div>
                            <% printMCapturedFlags( conn, out, thisFaction ); %>
                        </div>
                        <h3><a href="#">Politics</a></h3>
                        <div>
                            <% printPolitics( conn, out, thisFaction ); %>
                        </div>
                    </div>
                </div>
                <div class="box">
                    <b><%=thisFaction.getName()%></b>
                    <br/><i><%=thisFaction.getDescription()%></i>
                    <br/><b>Stronghold Location:</b>
                    <br/><b>Race:</b> <%=Constants.RACENAMES[thisFaction.getType()]%>
                    <br/><b>Prestige:</b> <%=thisFaction.getPrestige()%>
                    <br/><b>Created by:</b> <%=AltFactory.load(conn, thisFaction.getCreatedby()).getName()%>
                    <br/><b>Stronghold Ammenities: </b>
                    <%
                        //if lt. or leader, allow send faction messages
                        if( alt != null && alt.getFactionId() == thisFaction.getId() && alt.getFactionrank() > Constants.FACTION_MEMBER )
                        {
                            %>
                            <form action="factionMessage">
                            Send a message to the entire faction:<br/>
                            <input type="text" width="100px" name="words"/><input type="submit"/>
                            </form>
                            <%
                        }

                        //add join or quit button
                        if( alt != null //a character is logged in}
                            && ( alt.getRace() == Constants.HUMAN || alt.getRace() == thisFaction.getType() )  //correct race)
                            && alt.getFactionId() != thisFaction.getId()  //not already in the faction
                        )
                        {
                           out.write( "<br/><button id=\"joinbutton\">Join " + thisFaction.getName() + "</button>" );
                        }
                        else if( alt != null && alt.getFactionId() == thisFaction.getId() )
                        {
                            out.write( "<br/><button id=\"quitbutton\">Quit " + thisFaction.getName() + "</button>" );
                        }
                    %>
                </div>
            </div>

            <center>
                <br clear="all"/><%-- <a href="${base}map/index.jsp">Back</a> --%>
                <a href="javascript: history.go(-1)">Back</a>
                <%
                    if( alt != null //a character is logged in}
                        && alt.getFactionId() == thisFaction.getId()  //is in the faction
                        && alt.getFactionrank() > Constants.FACTION_MEMBER )
                    {
                        out.write( " | <a href=\"javascript: alert('Not implemented yet');\">Purchase Faction Banner</a> | <a href=\"editFaction.jsp\">Edit Faction</a>");
                    }

                %>
            </center>

            <!-- ui-dialog -->
            <div id="dialog" title="Join Faction Attempt" style="text-align:center;">
                Are you sure you want to join <%=thisFaction.getName()%>?
                <form id="confirmjoin" action="map/joinFaction">
                    <input type="hidden" name="factionid" value="<%=thisFaction.getId()%>"/>
                </form>
            </div>
            <div id="quitdialog" title="Quit Faction Attempt" style="text-align:center;">
                Are you sure you want to join <%=thisFaction.getName()%>?
                <form id="confirmquit" action="map/quitFaction">
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
