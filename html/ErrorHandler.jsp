<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<%@ page isErrorPage="true"%><%@ page import="java.io.*, java.util.Date, org.mitre.mrald.util.*" %>
    <%-- Exception Handler --%><%
    /* exceptions get put into the request object under one of two names
     * "javax.servlet.jsp.jspException"  or "javax.servlet.error.exception",
     * depending on the specification number.
     * Tomcat 4.1.x grabs only from the former, so we look for the latter if
     * the exception is null (i.e., it wasn't found by the default location
     * by Tomcat)
     */
    if ( exception==null )
    {
        exception = (Throwable)request.getAttribute("javax.servlet.error.exception");
    }

    boolean messageGiven = true;
    String message = exception.getMessage();
    if( message == null )
    {
        message = "No message provided.";
        messageGiven = false;
    }
    else
    {
        message.replaceAll("\n", "\n<br />");
    }
    %>
<html>
  <head>
    <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
    <title>
      Ooops!
    </title>
  </head>
  <body>
  <center>
        <div class="floating-text" style="margin-top:10em;width:750px">
            <p>
             Well.  This is embarassing.  There was an error that Entomo didn't catch properly.   Package up a little love note for him explaining what you were doing when this occurred.  The URL of this page would be very helpful, as would the time.  It is now <%=new Date()%>.
            </p>
        </div>
    </center>
  </body>
</html>


