<%@ tag import="java.util.*, invasion.dataobjects.*, invasion.util.*, invasion.pets.*, java.sql.*,java.util.logging.*" %><%!


    InvasionConnection conn = null;
    int locid = -1337;
    int BOX_SIZE = 55;
    int MAP_SIDE = 5;
    int TOTAL_SIZE = BOX_SIZE * MAP_SIDE;
    String DEEP_SPACE = "Deep Space";

    /**
     *  Does the data retrieval
     */
    protected ResultSet getData() {
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            String query = "select x, y, station from location where id = ?";
            ps = conn.prepareStatement(query);
            ps.setInt(1, locid);
            rs = ps.executeQuery();
            int x = 0;
            int y = 0;
            int station = -1;
            if(rs.next())
            {
                x = rs.getInt(1);
                y = rs.getInt(2);
                station = rs.getInt(3);
            }
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            int spread = (MAP_SIDE)/2;
            query = "select  id, station, level, x, y, l.name as locname, lt.name as typename, lt.typeid as typeid, description, cssname from Location l join locationtype lt on (l.typeid = lt.typeid) where x between ? and ? and y between ? and ? and station = ? order by y,x";
            ps = conn.prepareStatement(query);
            ps.setInt(1, x - spread );
            ps.setInt(2, x + spread);
            ps.setInt(3, y - spread);
            ps.setInt(4, y + spread);
            ps.setInt(5, station);
            return ps.executeQuery();
        } catch (SQLException e) {
            DatabaseUtility.close(rs);
            Logger log = Logger.getLogger( "NavPanel.tag" );
            log.log(Level.WARNING, "Error retrieving map data", e);
            return null;
        }
    }
%>
<script type="text/javascript">
			function shloc(id)
			{
			    show = "#desc-" + id;
			    contents = $(show).html();
			    $("#descbox").html(contents);
			};
</script>
<%
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    if( wazzit == null )
    {  //nobody is logged in
        response.sendRedirect( WebUtils.BASE + "/index.jsp");
        return;
    }
    locid = wazzit.getAlt().getLocation();
    if( locid == -1337 )
    {
        out.write("There has been an error and you seem to be lost in some unknown location.  You're basically screwed.");
        return;
    }
%>
<div class="descbox" id="descbox">&nbsp;</div>
<div id="mapbox" style="position:relative;" onmouseout="shloc('<%=locid%>')">
<%
    conn = new InvasionConnection();
    int x = 0;
    int y = 0;
    int boxNum = 0;
    String cloc;
    ResultSet rs = getData();
    if( rs ==null )
    {
        out.write("There has been an error and you seem to be lost in some unknown location.  You're basically screwed.");
    }
    else
    {
        while(rs.next())
        {
            boxNum = x + ( y * 5 );
            cloc = rs.getString("id");
            locid = Integer.parseInt( cloc );
            out.write("   <div class=\"me " + rs.getString("cssname") + "\" style=\"left: " + Integer.toString(x*BOX_SIZE) + "px; top:");
            out.write(Integer.toString(y*BOX_SIZE) + "px;\" onmouseover=\"shloc('" + cloc);
            out.write("')\">");
            /* movement */
            if( !Constants.DISALLOWED_LOCATIONS.contains( rs.getInt("typeid") ) )
            {
                out.write( WebUtils.getMovementClass(boxNum) );
            }

            // add character and pet icons on 5x5 map
            int charcount = LocationCache.getCharactersAtLoc( locid );
            if( charcount == 0 )
            {
                //move along
            }
            else if( charcount == 1 )
            {
                out.write("<img src=\"../i/pop1.gif\" style=\"position: absolute; top: 15px; left: 15px;z-index: 1;\"/>");
            }
            else if( charcount == 2 )
            {
                out.write("<img src=\"../i/pop2.gif\" style=\"position: absolute; top: 15px; left: 15px;z-index: 1;\"/>");
            }
            else //three or more
            {
                out.write("<img src=\"../i/pop3.gif\" style=\"position: absolute; top: 15px; left: 15px;z-index: 1;\"/>");
            }

            int crittercount = LocationCache.getBroodsAtLoc( locid );
            if( crittercount == 0 )
            {
                //move along
            }
            else if( crittercount == 1 )
            {
                out.write("<img src=\"../i/critter-1.png\" style=\"position: absolute; top: 32px; left: 26px;z-index: 3;\"/>");
            }
            else if( crittercount == 2 )
            {
                out.write("<img src=\"../i/critter-2.png\" style=\"position: absolute; top: 32px; left: 26px;z-index: 3;\"/>");
            }
            else //three or more
            {
                out.write("<img src=\"../i/critter-3.png\" style=\"position: absolute; top: 32px; left: 26px;z-index: 3;\"/>");
            }

            /* metadata - hidden until mouseover */
            out.write("<div style=\"display:none\" id=\"desc-" + cloc + "\">");
            out.write("<strong>Name:</strong> " + rs.getString("locname"));
            out.write("<br/><strong>Type:</strong> " + rs.getString("typename"));
            out.write("<br/><strong>Location:</strong> " + rs.getString("x") + ", " + rs.getString("y") + " (S" + rs.getString("station") + "L" + rs.getString("level") + ")" );
            out.write("</div>\n</div>\n");
            if (x < MAP_SIDE - 1) {
                x++;
            } else {
                x = 0; y++;
            }
        }
    }
    DatabaseUtility.close(rs);
    conn.close();
%>
<script type="text/javascript">
    shloc('<%=locid%>');
</script>
</div>


