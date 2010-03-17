<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
    page import="invasion.util.*, java.sql.*,java.util.logging.*" %><%
%><html>
    <head>
		<link type="text/css" href="../css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
		<link type="text/css" href="../css/main.css" rel="stylesheet" />
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js"></script>
		<script type="text/javascript">

			function shloc(id)
			{
			    show = "#desc-" + id;
			    contents = $(show).html();
			    $("#descbox").html(contents);
			};

			</script>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>
        <div style="float:left;width:400px;border:1px solid black" id="descbox">
        </div>
        <br clear="all" />
        <tags:WholeStation />
    </body>
<html>
