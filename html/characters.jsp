<%@ page import="invasion.util.*" %>
<html>
<head>
    <link type="text/css" href="${css}/redmond/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
    <link type="text/css" href="${css}/main.css" rel="stylesheet" />
    <script type="text/javascript" src="${js}/jquery-1.6.2.min.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.8.14.custom.min.js"></script>
    <script type="text/javascript" src="${js}/jquery.validate.js"></script>
</head>
<body>
    <center><img alt="logo" src="${images}/banner.png"/></center>
    <table border="0" cellpadding="2" cellspacing="0" width="100%">
        <thead>
            <tr><th>Name</th><th>AP</th><th>IP</th><th>HP</th><th>Station</th><th>Location</th></tr>
        </thead>
        <tbody>
            <tags:CharacterList/>
        </tbody>
    </table>
</body>
</html>
