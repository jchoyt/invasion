<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%@
    page import="invasion.util.*, java.sql.*,java.util.logging.*" %><%
%><html>
    <head>
		<link type="text/css" href="../css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
		<link type="text/css" href="../css/main.css" rel="stylesheet" />
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js"></script>
		<script type="text/javascript">
			$(function(){
				// Dialog
				$('#dialog').dialog({
					autoOpen: false,
					width: 600,
					buttons: {
						"Cancel": function() {
							$(this).dialog("close");
						}
					}
				});
			});

			function shloc(id)
			{
			    show = "#desc-" + id;
			    contents = $(show).html();
			    $("#descbox").html(contents);
			};

			function edit(id)
			{
			    resource = "uberEditLocation.jsp?locid=" + id;
                $('#dialog').load(resource);
                $('#dialog').dialog('open');
                return false;
			}
			</script>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>
        <div style="border:1px solid black;margin-left:2em;width:400px;height:150px;position:fixed;left:200px;top:10px;background-color:white;z-index:10;" id="descbox">
        </div>
        <br clear="all" />
        <tags:WholeStation />
        <!-- ui-dialog -->
		<div id="dialog" title="Dialog Title">
			<p>Place holder text.</p>
		</div>
    </body>
<html>
