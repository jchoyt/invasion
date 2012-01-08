<%@ page import="invasion.util.*,invasion.ui.*,java.sql.*,invasion.dataobjects.*, invasion.pets.*,java.util.logging.*,org.json.*, java.io.*" %>
<%
    //set up db connection
    InvasionConnection conn = null;
    ResultSet rs = null;
    try{
        Whatzit wazzit =(Whatzit) request.getSession().getAttribute(Whatzit.KEY);
        Alt alt = wazzit.getAlt();
        if( alt == null || alt.getFaction() == null || alt.getFactionrank() < Constants.FACTION_LT )
        {
            //piss off, hacker
            throw new NaughtyException("Player's status within a faction is in question.");
        }

        conn = new InvasionConnection();
        String query = null;
%>
<html>
    <head>
        <link type="text/css" href="${css}/redmond/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
        <link type="text/css" href="${css}/main.css" rel="stylesheet" />
        <link type="text/css" href="${css}/factionpages.css" rel="stylesheet" />
        <script type="text/javascript" src="${js}/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="${js}/jquery-ui-1.8.14.custom.min.js"></script>
        <script type="text/javascript">
            $(function() {
                $( "#friendly, #neutral, #hostile" ).sortable({
                    connectWith: ".connectedSortable",
                    receive: function(event, ui) {
                        // console.log(ui);
                        console.log(event);
                        var newSetting = event.srcElement.parentElement.id;
                        var factionMoved = event.srcElement.id;
                        var dataString = "faction=" + factionMoved + "&newStatus=" + newSetting;
                        // alert(dataString);
                        $.ajax({
                            type: "POST",
                            url: "alterPolitics",
                            data: dataString
                        }).done(function( msg ) {
                            if( msg == "OK" )
                            {
                                $( "#status" ).html( "<span class=\"info\">Successfully set " + factionMoved + " to " + newSetting + "</span>" );
                            }
                            else
                            {
                                $( "#status" ).html( "<span class=\"error\">Despite what you see above, there was an error trying to reset the status of " + factionMoved + " to " + newSetting + ".  <a href=\"editFaction.jsp\">Click</a> to refresh the page.</span>" );
                            }

                        });
                    }
                }
            ).disableSelection();
            });
        </script>
    </head>
    <body>
        <center>
            <%-- if the faction has a banner...
            <img alt="logo" src="${images}/banner.png"/>--%>
            <br/>
            <div class="human-banner"><%=alt.getFaction().getName()%></div>
            <br/>
        </center>
        <div id="wrap">
            <div class="box">
                <h2>Edit Description</h2>
                <form action="editFaction">
                    <textarea name="description" style="min-width:550px;min-height:100px;"><%=alt.getFaction().getDescription() %></textarea>
                    <br/><input type="submit"/>
                </form>
            </div>
            <hr width="500px"/>
            <div class="box">
                <h2>Edit Faction Politics</h2>
                <div class="headers">Friendly</div>
                <div class="headers">Neutral</div>
                <div class="headers">Hostile</div>
                <br clear="all"/>
                    <ul id="friendly" class="connectedSortable">
                        <%
                        query = "select name, f.id, setting from politics p join factions f on p.target=f.id where setter=? and id > 0 and setting = 2 order by setting, name";
                        rs = conn.psExecuteQuery( query, "", alt.getFaction().getId() );
                        while( rs.next() )
                        {
                            out.write("<li id=" + rs.getString("id") + " class=\"ui-state-default\">" + rs.getString( "name" ) + "<li>\n" );
                        }
                        DatabaseUtility.close(rs);
                        %>
                    </ul>

                    <ul id="neutral" class="connectedSortable">
                        <%
                        query = "select name, f.id from factions f where id > 0 and id not in (select target from politics where setter=?) and id != ? order by name;";
                        rs = conn.psExecuteQuery( query, "", alt.getFaction().getId(), alt.getFaction().getId() );
                        while( rs.next() )
                        {
                            out.write("<li id=" + rs.getString("id") + " class=\"ui-state-highlight\">" + rs.getString( "name" ) + "<li>\n" );
                        }
                        DatabaseUtility.close(rs);
                        %>
                    </ul>

                    <ul id="hostile" class="connectedSortable">
                        <%
                        query = "select name, f.id, setting from politics p join factions f on p.target=f.id where setter=? and id > 0 and setting = 0 order by setting, name";
                        rs = conn.psExecuteQuery( query, "", alt.getFaction().getId() );
                        while( rs.next() )
                        {
                            out.write("<li id=" + rs.getString("id") + " class=\"ui-state-error\">" + rs.getString( "name" ) + "<li>\n" );
                        }
                        DatabaseUtility.close(rs);
                        %>

                    </ul>
                <%
                    }
                    catch(SQLException e)
                    {
                        String errFile = WebUtils.dumpError(e);
                        out.write("Error retrieving stats. Details can be found at " + errFile );
                    }
                    finally
                    {
                        DatabaseUtility.close(rs);
                        DatabaseUtility.close(conn);
                    }
                %>
            <br clear="all"/>
            <div style="width:750px;text-align:center;"id="status"></div>
            </div>
            <hr width="500px"/>
            <div class="box">
                <h2>Purchase ammenities</h2>
                <form action="editFaction">
                    <select name="ammenity">
                        <option value="1">Spare zero-gee toilet</option>
                        <option value="2">Charging Port</option>
                        <option value="4">Sonic Shower</option>
                        <option value="8">Faction Banner</option>
                        <%-- <EugeneKay> Toilets.
<EugeneKay> In space, people need to POOP.
<Player_1> I agree. Toilets would be humorous.
<Player_1> I see no reason for a 'change tile type'
<Player_1> Not if you'll be able to make a gun table and you can charge anywhere.
<corky> for different search possibilities
<Player_1> In that case, it doesn't make sense logically.
<Player_1> I mean, is the person that changes the tile type going to drag in a bunch of crap from all over the station and hide it?
<corky> locker room
<Player_1> The point of finding items is that they were stored there by someone else, or dropped somewhere by someone.
<corky> true
<corky> computer terminal
<Player_1> Add extra station protection.
<Player_1> Be it locked doors or automated weapons.
<corky> escape hatch / pods
<Player_1> That would be a flavor item, I think.
<corky> yep
<corky> unless you give them an option to use them to die in space rather than at the hands of any raiders
<Player_1> Or they could use it to move their character to any random port.
<Player_1> Instead of dying at raiders, they could flee like a pussy.
<corky> add a small chance to be rescued and moved to a random port?
<Player_1> Rescued by what?
<corky> no idea
<corky> a benevolent interdimenisonal traveller
<Player_1> That's fucktarded.
<corky> that was sort of the point
<Player_1> Well, you succeeded.
<corky> ability to bribe the cloning room technician / hack computer to give a higher chance of respawning to the one closest to the SH for a certain time
<Player_1> There should be the option of making minor portals to where ever it is that the psychic people summon shit from.
<Player_1> So random pets can break out and wander around.
<corky> definitely that
<Player_1> And when too many are open, really dangerous shit starts to come out.
<Player_1> That would give humans the incentive to actually raid.
<corky> bandersnatches!
<Player_1> I was thinking Cthulu.
<corky> I really love that name entomo
<Player_1> He's not in the channel.
<corky> who isn't here
<Player_1> Entomo
<corky> damnit --%>
                    </select>
                    <br/><input type="submit"/>
                </form>
            </div>
        </div>
    </body>
</html>
