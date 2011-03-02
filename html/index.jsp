<%@ page import="invasion.util.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><html>
<head>
    <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
    <link type="text/css" href="${css}/main.css" rel="stylesheet" />
    <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
    <script type="text/javascript" src="${js}/jquery.validate.js"></script>
</head>
<body>
    <center><img alt="logo" src="${images}/banner.png"/>
        <br/><br/>
        <tags:CharacterList/>
        <br/><br/><a href="/newCharacter.html">Create a new character</a> | <a href="/logout">Log out</a>
        <%
            if( request.isUserInRole("Admin") )
            {
                out.write(" | <a href=\"/admin\">Admin area</a>");
            }
        %>
        <br/><a href="http://forums.soulcubes.com" target="_blank">Forums</a> | <a href="http://wiki.soulcubes.com" target="_blank">Wiki</a>
    </center>
</body>
</html>
