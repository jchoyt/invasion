/*
 *  Copyright 2011 Jeffrey Hoyt.  All rights reserved.
 */
package invasion;

/**
 * Class created so critical errors can be flagged.  There should be an &lt;error-page&gt; entry in web.xml to catch this and use a bot to announce the error
 * the admin channel
 */
public class BotReportException extends Exception
{

    //{{{ Members
    //}}}

    //{{{ Constuctors
    BotReportException()
    {
        super();
    }

    BotReportException(String message)
    {
        super(message);
    }

    BotReportException(String message, Throwable cause)
    {
        super(messageg, cause);
    }

    BotReportException(Throwable cause) )
    {
        super(cause);
    }
    //}}}

    //{{{ Methods
    //}}}

    //{{{ Getters and Setters
    //}}}

}

// :wrap=none:noTabs=true:collapseFolds=1:folding=explicit:

