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

<div style="margin-left:420px;padding:1.5em;border:1px solid black;">
    Invasion is a browser-based massively-multiplayer online roleplaying game wherein characters and their cadres struggle for control over resources and territories within an isolated space station.<br/>
    <br/>
    Humanity has spread to the stars and has seeded itself amongst the void. Generations have been born, lived, and died on the many space stations built throughout the cosmos.<br/>
    <br/>
    But now something strange is happening on these deep space stations. Some residents are finding that they can read thoughts and move objects with their minds. Others are finding their bodies developing new organs and body parts. But all of them feel their grip on sanity loosen in the celestial emptiness.<br/>
    <br/>
    As characters grow in experience, they discover new powers of immense caliber and discover the price of such powers. There are those who feel their minds expand in consciousness and ability and develop psionic skills. There are those whose bodies warp and mutate with traits of tumorous horror that grant unnatural strength and primal weaponry. But both types of the Invaded - the Psions and the Mutates - soon realize that the greater their powers become the more of their humanity is lost.<br/>
    <br/>
    Welcome to a game of science horror where power always has its price.<br/>
    <br/>
    Welcome to INVASION <br/>
</div>
<a href="http://english-186714478924.spampoison.com" style="display:none"><img src="http://pics5.inxhost.com/images/sticker.gif" border="0" width="80" height="15"/></a>
</body>
</html>
