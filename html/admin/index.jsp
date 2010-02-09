<%@ page import="invasion.util.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String locid = WebUtils.getOptionalParameter(request, "locid", "1002192");
%>
<html>
    <head>
        <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
        <link type="text/css" href="${css}/main.css" rel="stylesheet" />
        <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
        <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
        <script type="text/javascript" src="${js}/jquery.validate.js"></script>
		<script type="text/javascript">
			$(function(){

				// Tabs
				$('#tabs').tabs();

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
			    resource = "editLocation.jsp?locid=" + id;
                $('#dialog').load(resource);
                $('#dialog').dialog('open');
                return false;
			}

			</script>
    </head>
    <body>
		<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Map</a></li>
				<li><a href="#tabs-2">Character</a></li>
			</ul>
			<div id="tabs-1">
			    <div style="border:1px solid black;margin:2em;" id="descbox">
                </div>
                <tags:AdminMap locid="<%=locid%>" />
                </div>
			<div id="tabs-2"><jsp:include page="../release.txt" /></div>
		</div>

		<!-- ui-dialog -->
		<div id="dialog" title="Dialog Title">
			<p>There has been an exception.  Check <a href="editLocation.jsp?locid=1001625">here</a> to see what the problem may have been</p>
		</div>

    </body>
<html>
