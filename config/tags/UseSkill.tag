<%@ tag import="java.util.*, invasion.dataobjects.*, invasion.util.*" %>

<script type="text/javascript">

function saveConfig()
{
    var dataString = "a=1";
    if( $('#firearms') )
    {
        dataString = dataString + "&firearms=" + $('input[name="firearms"]:checked').val();
    }
    if( $('#melee') )
    {
        dataString = dataString + "&melee=" + $('input[name="melee"]:checked').val();
    }
    // alert(dataString);//return false;
    $.ajax({
        type: "POST",
        url: "${base}map/saveSkillConfig",
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
    <%}

    if( ( alt.getHumanSkills() & Skills.getValue(Skill.MELEE4) ) > 0 )
    {  //show Melee skills box
        %>
        <form>
            <div id="melee" align="" class="skillsbox"><h2>Melee Skills</h2>
                <input type="radio" name="melee" value="None" checked="true" onchange="saveConfig();" />None &nbsp;
                <input type="radio" name="melee" value="<%=Skill.WHIRLWIND%>" onchange="saveConfig();" />Whirlwind
                <% if( ( alt.getHumanSkills() & Skills.getValue(Skill.MELEE5) ) > 0 ) { %>
                    &nbsp; <input type="radio" name="melee" value="<%=Skill.BRUTALITY %>" onchange="saveConfig();" />Brutality (2 AP)
                <%}%>

            </div>
        </form>
    <%}%>

<script type="text/javascript">
    <%
        for( String skill : alt.getSkillsUsed() )
        {
            out.write("$(\"input:radio[value='" + skill + "']\").attr('checked', 'true');");
        }
    %>
</script>

