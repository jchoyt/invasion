<%@ page import="invasion.util.*, java.sql.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String locid = WebUtils.getOptionalParameter(request, "locid", "none");
    if(locid.equals("none"))
    {
        String stationid = WebUtils.getRequiredParameter(request, "id" );
        String query = "select id from location where station = ? and x=25 and y=25";
        InvasionConnection conn = null;
        try
        {
            conn = new InvasionConnection();
            ResultSet rs = conn.psExecuteQuery( query, "", Integer.decode(stationid) );
            if(rs.next())
            {
                locid = rs.getString( 1 );
            }
            else throw new RuntimeException("Borked attempt to grab the center of the station.");
            rs.close();
            <%
        }
        catch(Exception e)
        { e.printStackTrace();}
        finally
        { conn.close(); }
    }
%>
<html>
    <head>
        <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
        <link type="text/css" href="${css}/main.css" rel="stylesheet" />
        <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
        <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
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
			    resource = "editLocation.jsp?locid=" + id;
                $('#dialog').load(resource);
                $('#dialog').dialog('open');
                return false;
			}
			</script>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>
        <div style="border:1px solid black;margin-left:2em;width:400px;float:left;" id="descbox"></div>
        <br clear="all"/>
        <tags:AdminMap locid="<%=locid%>"/>
        		<!-- ui-dialog -->
		<div id="dialog" title="Dialog Title">
			<p>There has been an exception.  Check <a href="editLocation.jsp?locid=1001625">here</a> to see what the problem may have been</p>
		</div>
    </body>
</html>

