<%@ page import="invasion.util.*,java.sql.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String searchString = WebUtils.getOptionalParameter(request, "searchString", "");
%>
<html>
    <head>
        <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
        <link type="text/css" href="${css}/main.css" rel="stylesheet" />
        <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
        <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>
        <center>
            <% String query = "select * from station a where name ~* ? limit 20";
                InvasionConnection conn = new InvasionConnection();
                ResultSet rs = conn.psExecuteQuery( query, "", searchString );
                DatabaseUtility.genericTable(rs, out);
                rs.close();
            %>
            <hr/>
            <div class="descbox" style="width:400px;">
                <form action="stationList.jsp">
                <h3>Filter by name</h3>
                    Name contains: <input type="text" name="searchString"/><br/>
                    *note this is case insensitive<br/>
                    <input type="submit"/>
                </form>
                <form action="stationEdit.jsp">
                <h3>Edit</h3>
                    ID: <input type="text" name="id"/><br/>
                    <input type="submit"/>
                </form>
                <form action="fullStationView.jsp">
                <h3>Ubermap</h3>
                    ID: <input type="text" name="id"/><br/>
                    <input type="submit"/>
                </form>
                <form action="showOccupants.jsp">
                <h3>Occupants</h3>
                    ID: <input type="text" name="station"/><br/>
                    <input type="submit"/>
                </form>
                <form action="sendStationMessage.jsp">
                <h3>Send message to entire station</h3>
                    ID: <input type="text" name="station"/><br/>
                    Type: <select name="type"><option value="0">Normal (black)</option>
                            <option value="1">Self (green)</option>
                            <option value="2">Broadcast (cyan)</option>
                            <option value="3" selected="true">Etherial (purple)</option>
                            <option value="4">Effect (red)</option>
                        </select><br/>
                    Message: <input type="text" name="msg" size="40"/></br>
                    <input type="submit"/>
                </form>
            </div>
        </center>
    </body>
<html>
