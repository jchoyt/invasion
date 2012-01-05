<%@ page import="invasion.util.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><html>
<%
    String errorMsg = WebUtils.getOptionalParameter(request, "error");
    String infoMsg = WebUtils.getOptionalParameter(request, "info");
%>
<head>
    <link type="text/css" href="${css}/redmond/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
    <link type="text/css" href="${css}/main.css" rel="stylesheet" />
    <script type="text/javascript" src="${js}/jquery-1.6.2.min.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.8.14.custom.min.js"></script>
    <script type="text/javascript" src="${js}/jquery.validate.js"></script>
</head>
<body>
    <center><img alt="logo" src="${images}/banner.png"/>
        <br/><br/>
        <%  if( !errorMsg.equals(WebUtils.EMPTY_STR) )
        {
            out.write( "<h3 class=\"error\">" + errorMsg + "</h3>");
        }
        if( !infoMsg.equals(WebUtils.EMPTY_STR) )
        {
            out.write( "<h3 class=\"info\">" + infoMsg + "</h3>");
        }%>
        <tags:CharacterList/>
        <br/><br/><a href="${base}newCharacter.html">Create a new character</a> | <a href="${base}logout">Log out</a>
        <%
            if( request.isUserInRole("Admin") )
            {
                out.write(" | <a href=\"" + WebUtils.BASE + "/admin\">Admin area</a>");
            }
        %>
        <br/><a href="http://soulcubes.com/boards" target="_blank">Forums</a> | <a href="http://soulcubes.com/docs" target="_blank">Documentation</a>
    </center>
</body>
</html>
