/*
 *  Copyright 2013 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.servlets;

import invasion.bot.VasionBot;

class BotRunner implements Runnable
{
    String configLoc;

    private BotRunner()
    { }

    public BotRunner( String key )
    {
        this.configLoc = key;
    }

    public void run()
    {
        new VasionBot( this.configLoc );
    }
}
