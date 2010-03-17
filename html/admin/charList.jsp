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
            <% String query = "select * from alt a where name ~* ? limit 20";
                InvasionConnection conn = new InvasionConnection();
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
                <form action="smite.jsp">
                <h3>Smite</h3>
                    ID: <input type="text" name="id"/><br/>
                    Message: <input type="text" name="message" value="The system's automated defenses suddenly activate and reduce your body to ash."/><br/>
                    <input type="submit"/>
                </form>
            </div>
        </center>
    </body>
<html>
