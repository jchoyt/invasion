<%@ page import="invasion.util.*,org.json.*,invasion.dataobjects.*,invasion.ui.*,java.io.*" %><%!

/**
 * Recursively prints all the skills and child skills a character owns
 * @param
 * @return
 *
 */
protected void printHave( Alt thisguy, Skill skill, boolean rootSkill, JspWriter out )
    throws IOException
{
    if(!rootSkill)
        out.write( " &raquo " );
    if( Skills.hasSkill( thisguy, skill ) )
    {
        out.write( skill.getName() );
        for( Skill s : skill.getChildren() )
        {
            if( Skills.hasSkill( thisguy, s ) )
            {
                printHave( thisguy, s, false, out );
            }
        }
    }

}

/**
 * Recursively prints all the skills and child skills a character owns, then appends a link to allow they to purchase skills they don't
 * @param
 * @return
 *
 */
protected void printCanBuy( Alt thisguy, Skill skill, boolean rootSkill, JspWriter out )
    throws IOException
{
    if(!rootSkill)
    {
        out.write( " &raquo " );
    }
    if( Skills.hasSkill( thisguy, skill ) )
    {
        out.write( "<b>" + skill.getName() + "</b>" );
        for( Skill s : skill.getChildren() )
        {
            printCanBuy( thisguy, s, false, out );
        }
    }
    else if( thisguy.getCp() >= skill.getCost() )
    {
        out.write( "<a href=\"#\" onclick=\"doPurchase( " + thisguy.getId() + ", " + skill.getId() + ");setTimeout('location.reload();', 1500);\">Purchase " + skill.getName() + " ( " + skill.getCost() + " CP )" + "</a>" );
    }
    else
    {
        out.write( "<span class=\"toomuch\">" + skill.getName() + " ( " + skill.getCost() + " CP )</span>" );
    }
}

%><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String id_string = WebUtils.getRequiredParameter(request, "id");
    int id = Integer.parseInt(id_string);
    InvasionConnection conn = null;
    try
    {
        conn = new InvasionConnection();
        //load the alt
            Alt thisguy = Alt.load(conn, id);
            Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
        %><html>
        <head>
            <link type="text/css" href="${css}/redmond/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
            <link type="text/css" href="${css}/main.css" rel="stylesheet" />
            <script type="text/javascript" src="${js}/jquery-1.5.1.min.js"></script>
            <script type="text/javascript" src="${js}/jquery-ui-1.8.14.custom.min.js"></script>
            <script type="text/javascript" src="${js}/jquery.validate.js"></script>
            <style type="text/css">
                .box { width:250px;padding:10px; }
                .toomuch { color: gray;  }
            </style>
            <script type="text/javascript">
                $(function(){
                    // Tabs
                    $('#tabs').tabs( { selected: 0 });

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

                function doPurchase( altid, skillid, skilltype)
                {
                    resource = "purchaseSkill?altid=" + altid + "&skillid=" + skillid;
                    $('#dialog').load(resource);
                    $('#dialog').dialog('open');
                    return false;
                }

            </script>


        </head>
        <body>
            <center>
                <img alt="logo" src="${images}/banner.png"/>
                <br/>
                <h3>This is <%=thisguy.getName()%></h3>
                <i>Unfactioned</i>
                <br/>
                <div id="tabs" style="width:500px;">
                    <ul>
                        <li><a href="#tabs-1">Summary</a></li>
                        <li><a href="#tabs-2">Skills</a></li>
                        <li><a href="#tabs-3">Achievments</a></li>
                        <%
                        if( thisguy.getUsername().equals( request.getRemoteUser() ) )
                        {
                            out.write("<li><a href=\"#tabs-4\">Purchase Skills</a></li>");
                        }
                        %>
                    </ul>
                    <div id="tabs-1">
                        <div style="float:left;border:1px solid blue;">
                            <%
                                JSONObject obj2 = Alt.getStats(conn, id);
                                JSONObject stats = new JSONObject();
                                stats.put("stats", obj2);
                                VelocityUtil.applyTemplate(stats, "stats2.vm", out);

                            %>
                        </div>
                        <%
                            //do summary

                            //do clothing
                            if(thisguy.getClothing().size() > 0)
                            {
                                out.write("<br/>" + Constants.getHeShe( thisguy.getGender(), true) + " is wearing ");
                                for(int i = 0; i < thisguy.getClothing().size(); i++)
                                {
                                    if( i > 0 )
                                        out.write(", ");
                                    if( thisguy.getClothing().size() > 1 && i == (thisguy.getClothing().size() - 1) )
                                        out.write("and ");
                                    out.write( thisguy.getClothing().get(i) );
                                }
                            }
                        %>
                    </div>
                    <div id="tabs-2">
                        <b><u>Human Skills</u></b>
                        <br/>
                        <%
                            for( Skill s : Skills.getHumanSkills() )
                            {
                                printHave(thisguy, s, true, out);
                                out.write("<br/>");
                            }
                        %>
                        <br/>
                        <%--
                        <br/>
                        <b><u>Psi Skills</u></b>
                        <br/>
                        <%
                            for( Skill s : Skills.getPsiSkills() )
                            {
                                printHave(thisguy, s, true, out);
                                out.write("<br/>");
                            }
                        %>
                        <br/>
                        <br/>
                        <b><u>Psi Skills</u></b>
                        <br/>
                        <%
                            for( Skill s : Skills.getPsiSkills() )
                            {
                                printHave(thisguy, s, true, out);
                                out.write("<br/>");
                            }
                        %>
                        --%>
                    </div>
                    <div id="tabs-3">
                        <table cellpadding="0">
                            <thead><tr><th>Stat</th><th>Count</th></tr></thead>
                            <tbody>
                                <tags:CharBadges id="<%=id_string%>"/>
                            </tbody>
                        </table>
                    </div>
                    <%
                    if( thisguy.getUsername().equals( request.getRemoteUser() ) )
                    {
                        out.write( "<div id=\"tabs-4\">");
                        for( Skill s : Skills.getHumanSkills() )
                        {
                            printCanBuy(thisguy, s, true, out);
                            out.write("<br/>");
                        }
                        out.write( "</div>" );
                    } %>
                </div>
                <br clear="all"/><a href="${base}map/index.jsp">Back</a>
            </center>
            <!-- ui-dialog -->
            <div id="dialog" title="Skill Purchase Attempt" style="text-align:center;">
                <p>Processing...</p>
            </div>

        </body>
        </html>
        <%
    }
    catch(Exception e)
    { e.printStackTrace();}
    finally
    {  DatabaseUtility.close(conn); }
%>
