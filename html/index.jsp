<%@ page import="invasion.util.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><html>
<head>
    <link type="text/css" href="${css}/redmond/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
    <link type="text/css" href="${css}/main.css" rel="stylesheet" />
    <script type="text/javascript" src="${js}/jquery-1.5.1.min.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.8.14.custom.min.js"></script>
    <script type="text/javascript" src="${js}/jquery.validate.js"></script>
</head>
<body>
    <center><img alt="logo" src="${images}/banner.png"/>
        <br/><br/>
        <tags:CharacterList/>
        <br/><br/><a href="${base}newCharacter.html">Create a new character</a> | <a href="/logout">Log out</a>
        <%
            if( request.isUserInRole("Admin") )
            {
                out.write(" | <a href=\"" + WebUtils.BASE + "/admin\">Admin area</a>");
            }
        %>
        <br/><a href="http://soulcubes.com/boards" target="_blank">Forums</a> | <a href="http://soulcubes.com/docs" target="_blank">Wiki</a>
    </center>
</body>
</html>
