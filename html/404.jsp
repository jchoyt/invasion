<%@ page isErrorPage="true"%><html>
<head>
    <script type="text/javascript" src="${js}/jquery-1.5.1.min.js"></script>
	<style type="text/css">
	.naughty {
	    width:750;
        height:600;
        /* background-image:url('/i/naughty.jpg'); */
        text-align:left;
        /* vertical-align:middle; */
        color:green;
        font-size:18pt;
        font-style:Lucida Console, Monaco5, monospace;
    }
	</style>
	<script>
        var messages = [
            "# Your head spins. You're having trouble remembering the simplest details  How did you get here?",
            "# This part of the station is dimly lit and in disrepair.  You look around. Something isn't right, but you can't pin it down. Your head starts to pound.",
            "# The hallway fades into the darkness behind you. It's getting harder to see.",
            "# Was that sound a ventilation system glitch?  Or something...else?  Nah...must be the ventilation - But it's getting closer and you're not moving.",
            "# The station PA system booms, \"Rude alert! Rude alert! An electrical fire has knocked out my voice recognition unicycle! Many Wurlitzers are missing from my database. Abandon shop! This is not a daffodil. Repeat: This is not a daffodil.\"",
            "# You hear a quiet laugh from behind you.",
            "# You are well and truly screwed.  Also, your file isn't here.  404 Error."
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
          }, 2000);
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


