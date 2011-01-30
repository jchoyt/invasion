<%@ page import="invasion.util.*,java.sql.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String searchString = WebUtils.getOptionalParameter(request, "searchString", "");
%>
<html>
    <head>
        <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
        <link type="text/css" href="${css}/main.css" rel="stylesheet" />
        <link type="text/css" href="${css}/jquery.cluetip.css" rel="stylesheet" />
        <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
        <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
        <script type="text/javascript" src="${js}/jquery.cluetip.js"></script>
        <style type="text/css">
            h3 { border-top:solid black 1px;}
        </style>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>
        <center>
            <%  String query = "select typeid, name from locationtype where name ~* ? order by typeid";
                InvasionConnection conn = null;
                try {
                    conn = new InvasionConnection();
                    ResultSet rs = conn.psExecuteQuery( query, "", searchString );
                    DatabaseUtility.genericTable(rs, out);
                    rs.close();
            %>
            <hr/>
            <div class="descbox" style="width:400px;">
                <form action="locationTypeList.jsp" >
                <h3>Filter by name</h3>
                    Name contains: <input type="text" name="searchString"/><br/>
                    *note this is case insensitive<br/>
                    <input type="submit"/>
                </form>
                <form action="locationTypeEdit.jsp">
                <h3>Edit</h3>
                    ID: <input type="text" name="id"/><br/>
                    <input type="submit"/>
                </form>
            </div>
            <br/>
            <div>To delete or change the colors, contact Entomo</div>
            <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
        </center>
    </body>
    <script type="text/javascript">
        $(".locpopup").cluetip({activation: 'click', width: 500, closePosition: 'title', arrows: true});
    </script>

<html><%
    }
    catch(Exception e)
    { e.printStackTrace();}
    finally
    { conn.close(); }
%>
