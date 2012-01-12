<%@ page import="java.util.*, invasion.dataobjects.*, invasion.util.*, java.sql.*" %>
<html>
<head>
    <link type="text/css" href="${css}/redmond/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
    <link type="text/css" href="${css}/main.css" rel="stylesheet" />
            <link type="text/css" href="${css}/cssfly.css" rel="stylesheet" />
    <script type="text/javascript" src="${js}/jquery-1.6.2.min.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.8.14.custom.min.js"></script>
    <script type="text/javascript" src="${js}/jquery.validate.js"></script>
    <style type="text/css">
        .desc { text-align:left; }
        td { border:none; text-align:center; }
	</style>

</head>
<body>
    <jsp:include page="sitenav.jsp" />
    <center>
        <img alt="logo" src="${images}/banner.png"/><br/>
        <table border="0" cellpadding="2" cellspacing="0" width="700px">
            <thead>
                <tr><th>Name</th><th>Station</th><th>Members</th><th>Level</th><th>Prestige</th><th>Policy</th><th>Type</th></tr>
            </thead>
            <tbody>
            <%
                String player = request.getRemoteUser();

                String query = "select f.id, f.name, (select count(*) from alt where factionid=f.id) as members, s.name as sname, f.level, f.prestige, f.open, f.type, f.description from factions f join station s on (f.station=s.id) where f.id > 0 order by level desc, name desc";
                InvasionConnection conn = new InvasionConnection();
                ResultSet rs = conn.executeQuery(query);
                while(rs.next())
                {
                    String id = rs.getString("id");
                    String name = rs.getString( "name" );
                    out.write( "<tr><td class=\"desc\">");
                    out.write( "<a href=\"" + WebUtils.BASE + "viewFaction.jsp?id=" + id + "\">" + name + "</a></td><td>");
                    out.write( rs.getString( "sname" ) );
                    out.write( "</td><td>");
                    out.write( rs.getString( "members" ) );
                    out.write( "</td><td>");
                    out.write( rs.getString( "level" ) );
                    out.write( "</td><td>");
                    out.write( rs.getString( "prestige" ) );
                    out.write( "</td><td>");
                    if( rs.getBoolean( "open" ) )
                        out.write( "Open</td><td>");
                    else
                        out.write( "Closed</td><td>");
                    out.write( Constants.RACENAMES[rs.getInt( "type" )] );
                    out.write( "</td></tr>" );
                    out.write( "<tr><td colspan=\"7\" class=\"desc\">");
                    out.write( rs.getString("description") );
                    out.write( "</td></tr>\n" );
                }
                DatabaseUtility.close(rs);
                conn.close();
            %>
            </tbody>
        </table>
        <a href="newFaction.html">Create a new faction</a> | <a href="javascript: history.go(-1)">Back</a>
    </center>
</body>
</html>
