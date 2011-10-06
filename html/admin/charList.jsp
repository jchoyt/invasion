<%@ page import="invasion.util.*,java.sql.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String searchString = WebUtils.getOptionalParameter(request, "searchString", "");
%>
<html>
    <head>
        <link type="text/css" href="${css}/redmond/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
        <link type="text/css" href="${css}/main.css" rel="stylesheet" />
        <link type="text/css" href="${css}/jquery.cluetip.css" rel="stylesheet" />
        <script type="text/javascript" src="${js}/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="${js}/jquery-ui-1.8.14.custom.min.js"></script>
        <script type="text/javascript" src="${js}/jquery.cluetip.js"></script>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>
        <center>
            <% String query = "select id, name, xp, level, station, factionid, ap, hp, cp, ip, location, speciality, level, ticksalive, lasthurtby from alt a where name ~* ? limit 20";
            InvasionConnection conn = null;
            try {
                conn = new InvasionConnection();
                ResultSet rs = conn.psExecuteQuery( query, "", searchString );
                DatabaseUtility.genericTable(rs, out);
                rs.close();
            %>
            <hr/>
            <div class="descbox" style="width:400px;">
                <form action="charList.jsp">
                <h3>Filter by name</h3>
                    Name contains: <input type="text" name="searchString"/><br/>
                    *note this is case insensitive<br/>
                    <input type="submit"/>
                </form>
                <form action="charEdit.jsp">
                <h3>Edit</h3>
                    ID: <input type="text" name="id"/><br/>
                    <input type="submit"/>
                </form>
                <form action="smite">
                <h3>Smite</h3>
                    ID: <input type="text" name="id"/><br/>
                    Message: <input type="text" name="message" value="The system's automated defenses suddenly activate and reduce your body to ash."/><br/>
                    <input type="submit"/>
                </form>
                <form action="stun">
                <h3>Stun</h3>
                    ID: <input type="text" name="id"/><br/>
                    Time: <input type="text" name="seconds" value="3600"/> seconds<br/>
                    Message: <input type="text" name="message" value="A disturbance in space-time distracts you and you stare at it, forgetting what you wanted to do."/><br/>
                    Prevents action for XX seconds.  The default (3600) is one hour...which is cruel.
                    <input type="submit"/>
                </form>
            </div>
        </center>
    </body>
    <script type="text/javascript">
        $(".locpopup").cluetip({activation: 'click', width: 500, closePosition: 'title', arrows: true});
    </script>

<html>
            <%
            } catch (Exception e)
            { e.printStackTrace(); }
            finally
            { DatabaseUtility.close(conn); }
            %>
