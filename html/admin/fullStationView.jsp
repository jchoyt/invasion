<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
    page import="invasion.util.*, java.sql.*,java.util.logging.*" %><%
    String locid = WebUtils.getOptionalParameter(request, "locid", "1021631");
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
		<style type="text/css">
			/*demo page css*/
			body{ font: 62.5% "Trebuchet MS", sans-serif; margin: 50px; background: #201913}
			.white-background { background:#fff; color:#000; }
		</style>
    </head>
    <body>
        <div style="border:1px solid white;margin:2em;color:white;" id="descbox">
        </div>
        <tags:WholeStation />
    </body>
<html>
