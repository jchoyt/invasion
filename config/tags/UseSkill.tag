<%@ tag import="java.util.*, invasion.dataobjects.*, invasion.util.*" %>

<script type="text/javascript">

function saveConfig()
{
    var dataString = "";
    if( $('#firearms') )
    {
        dataString = dataString + "firearms=" + $('input[name="firearms"]:checked').val();
    }
    // alert(dataString);//return false;
    $.ajax({
        type: "POST",
        url: "/map/saveSkillConfig",
        data: dataString
        /* ,
        success: function() {
            alert("success");
            $('#firearms').append("<div id='message'></div>");
            $('#message').html("<h2>Change saved!</h2>")
            .hide()
            .fadeIn(1500, function() {
              $("#message").fadeOut("slow", function () {
                  $("#message").remove();
              });
            }, 2000);

        } */
    });
}

</script>
<%
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    Alt alt = wazzit.getAlt();
    // out.write(alt.getHumanSkills() + " is right?");
    if( ( alt.getHumanSkills() & Skills.getValue(Skill.FIREARMS4) ) > 0 )
    {  //show Firearms skills box
        %>
        <form>
            <div id="fireamrs" align="" class="skillsbox"><h2>Firearms Skills</h2>
                <input type="radio" name="firearms" value="None" checked="true" onchange="saveConfig();" />None &nbsp;
                <input type="radio" name="firearms" value="<%=Skill.DOUBLE_SHOT%>" onchange="saveConfig();" />Double Shot
                <% if( ( alt.getHumanSkills() & Skills.getValue(Skill.FIREARMS5) ) > 0 ) { %>
                    &nbsp; <input type="radio" name="firearms" value="<%=Skill.KILL_SHOT %>" onchange="saveConfig();" />Kill Shot (3 AP)
                <%}%>

            </div>
        </form>
    <%}%>

<script type="text/javascript">
    <%  if( alt.getSkillsUsed().contains( Skill.DOUBLE_SHOT ) )
        {%>
            $("input:radio[value='<%=Skill.DOUBLE_SHOT%>']").attr('checked', 'true');
        <%}
        else if( alt.getSkillsUsed().contains( Skill.KILL_SHOT ) )
        {%>
            $("input:radio[value='<%=Skill.KILL_SHOT%>']").attr('checked', 'true');
        <%}%>
</script>

