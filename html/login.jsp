<%@ page import="invasion.util.*" %><%

String message = WebUtils.getOptionalParameter(request, "message", null);
%><html>
<head>
    <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
    <link type="text/css" href="${css}/main.css" rel="stylesheet" />
    <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
    <script type="text/javascript" src="${js}/jquery.validate.js"></script>
    <style type="text/css">
        label { width: 10em; float: left; }
        label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
        p { clear: both; }
        em { font-weight: bold; padding-right: 1em; vertical-align: top; }
    </style>
    <script>
        $(document).ready(function(){
          $("#loginForm").validate();
        });
    </script>
</head>
<body>
<center><img alt="logo" src="${images}/banner.png"/></center>
<div style="float:left;">
    <% if(message!=null)
    {%>
        <center><div class="ui-state-error ui-corner-all" style="padding:1em;width:350px;text-align:center;">
            <%=message%>
        </div></center>
    <%}%>
    <!-- login -->
    <div id="login" style="width:400px">
     <form class="cmxform" id="loginForm" method="post" action="<%= response.encodeURL("j_security_check") %>" >
     <fieldset>
       <legend>Player Login</legend>
       <p>
         <label for="cname">User Name</label>
         <input id="cname" name="j_username" size="20" class="required" minlength="2" />
       </p>
       <p>
         <label for="passwd">Password</label>
         <input id="passwd" name="j_password" size="20" class="required" type="password" />
       </p>
       <p style="text-align:center">
         <input class="link_button ui-state-default ui-corner-all" type="submit" value="Submit"/><br/><br/>
         <a href="registration.jsp">Register a New Account</a>
       </p>

     </fieldset>
     </form>
     </div>
    <img alt="corridor-like image by aephius on deviant art" src="${images}/Spaceship_Corridor_by_aerphis.jpg"/>
</div>

<div style="margin-left:420px;padding:1.5em;border:1px solid black;font-size:1.5em;">
Invasion is a browser-based massively-multiplayer online roleplaying game wherein characters and their cadres struggle for control over resources and territories and maybe humanity itself within isolated space stations across space. Humanity has spread to the stars and has seeded itself amongst the void. Generations have been born, lived, and died on the many space stations built throughout the cosmos. But now something strange is happening on these deep space stations. It all started with the voices. Strange, ethereal messages received by people of all walks of life. What some hear is encouraging yet slightly disturbing while others hear fearful, cautionary thoughts. Some hear nothing and fear for the sanity of those around them.
<br/><br/>
Some time later, small cubes of fused crystal and metal appear in the quarters of those that heard the voices most strongly. They became a point of comfort and a focus for mediation...and then they were gone. In their place, people started displaying new abilities. Some residents found that they can read thoughts and move objects with their minds. Others are finding new control over their bodies - even the ability to change their shape in small ways. But all of them feel their grip on sanity loosen in the celestial emptiness. Some blamed the "soul cubes" as they became known. While those that build them see them as the salvation for what was invading their minds.
<br/><br/>
As characters grow in experience, they discover new powers of immense caliber and discover the price of such powers. There are those who feel their minds expand in consciousness and ability and develop psionic skills. There are those whose bodies warp and mutate with traits that grant unnatural strength and primal weaponry. But both types of the Invaded - the Psis and the Mutates - soon realize that the greater their powers become the more of their humanity is lost.
<br/><br/>
Humanity is being torn and brought into a racial civil war millennia old. Will it choose sides or resist the split that destroyed a race so long ago? Welcome to a game of science horror where power always has its price.
<br/><br/>
Welcome to INVASION
</div>
<a href="http://english-186714478924.spampoison.com" style="display:none"><img src="http://pics5.inxhost.com/images/sticker.gif" border="0" width="80" height="15"/></a>
</body>
</html>
