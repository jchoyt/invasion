<%@ page import="java.util.*, invasion.dataobjects.*, invasion.util.*, java.sql.*,javax.sql.*" %>

<form action="chalk" method="post">
    Message: <br/><textarea name="message" cols="50" rows="5"></textarea><br/>
    <input type="Submit" value="Write Message"/>
</form>
To write a message, just put it in the box above.  There are flavors of text:
<ul>
    <li>No prefix will read "Someone has written <i>&gt;your text&lt;</i> on the wall."</li>
    <li>!draw will read "Someone has drawn a picture of &gt;your text&lt; on the wall.".</li>
    <li>!scrawl will read "Someone has crudely scrawled a message here.  You can barely make out <i>&gt;your text&lt;</i>."</li>
</ul>
