<%@ page isErrorPage="true"%><%@ page import="java.io.*, invasion.util.*,invasion.bot.*" %><%

    boolean messageGiven = true;
    String message = exception.getMessage();
    VasionBot.announce( message );
    if( message == null )
    {
        message = "No message provided.";
        messageGiven = false;
    }
    else
    {
        message.replaceAll("\n", "\n<br />");
    }
    %><html>
<head>
    <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
    <title>Critical Failure</title>
    <script type="text/javascript" src="${js}/jquery-1.6.2.min.js"></script>
	<style type="text/css">
	.naughty {
	    width:750;
        height:600;
        /* background-image:url('/game/i/naughty.jpg'); */
        text-align:left;
        /* vertical-align:middle; */
        color:red;
        font-size:18pt;
        font-style:Lucida Console, Monaco5, monospace;
    }
	</style>
	<script>
        var messages = [
            "# Something has gone wrong with the laws of Physics.  You should never see this page.",
            "# As a matter of fact, I've just pinged the mods in the admin channel on irc.  If you want to provide additional information, swing by #soulcubes on irc.freenode.net and talk to one of the mods.",
            "# If you don't have a client already configured, a) why not? there's a lot of good info and people on irc and b) freenode has a <a href=\"http://webchat.freenode.net\" target=\"_blank\">web client</a> ",
            "# Head back <a href=\"map/index.jsp\">to the world</a>"
            ];
        var msgIndex = 0;

        function showText()
        {
          setTimeout(function() {
              $msgDiv = $("#message");
              $msgDiv.append(messages[msgIndex]);
              $msgDiv.append("<br/>");
              msgIndex = msgIndex + 1
              if(msgIndex < messages.length)
                showText();
          }, 2500);
        }

        $(function() { showText(); } );

    </script>
</head>
<body style="background-color:black;" >
<center>
    <div class="naughty">
    <br/><br/><br/><br/><br/><br/>
        <div id="message"></div>
    </div>
</center>
</body>
</html>
