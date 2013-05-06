package invasion.servlets;

import invasion.dataobjects.Alt;
import invasion.dataobjects.Message;
import invasion.dataobjects.Skills;
import invasion.util.AltFactory;
import invasion.util.BotReportException;
import invasion.util.DatabaseUtility;
import invasion.util.InvasionConnection;
import invasion.util.WebUtils;
import java.io.IOException;
import java.security.Principal;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns={"/newCharacter"})
public class CreateNewCharacter
  extends HttpServlet
{
  public static final String KEY = CreateNewCharacter.class.getName();
  public static final Logger log = Logger.getLogger(KEY);

  public void init(ServletConfig config)
    throws ServletException
  {
    log.entering(KEY, "init");

    super.init(config);
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    String charname = WebUtils.getRequiredParameter(request, "name");
    if (charname.length() < 2)
    {
      response.sendRedirect(WebUtils.BASE + "index.jsp?error=Your character's name should have at least 2 characters, don't you think?  It's just cruel otherwise.  Try again.");
      return;
    }
    String skill_string = WebUtils.getRequiredParameter(request, "skill");
    String station_string = WebUtils.getRequiredParameter(request, "station");
    String race_string = WebUtils.getOptionalParameter(request, "race", "1");
    int skill = Integer.parseInt(skill_string);
    int station = Integer.parseInt(station_string);
    int race = Integer.parseInt(race_string);

    long humanSkill = 0L;
    long tohuSkill = 0L;
    long tikkunSkill = 0L;

    switch (skill)
    {
    case 0:
      humanSkill = Skills.getValue("Firearms 1").longValue();
      break;
    case 1:
      humanSkill = Skills.getValue("Melee 1").longValue();
      break;
    case 2:
      humanSkill = Skills.getValue("Tinkerer 1").longValue();
      break;
    case 20:
      tikkunSkill = Skills.getValue("Body Warp 1").longValue();
      break;
    case 21:
      tikkunSkill = Skills.getValue("Soul Sharer 1").longValue();
      break;
    case 22:
      tikkunSkill = Skills.getValue("Protector of the Nest 1").longValue();
      break;
    case 30:
      tohuSkill = Skills.getValue("Telekinesis 1").longValue();
      break;
    case 31:
      tohuSkill = Skills.getValue("Summoner 1").longValue();
      break;
    case 32:
      tohuSkill = Skills.getValue("Telepathy 1").longValue();
      break;
    }


    InvasionConnection conn = null;
    try
    {
      Alt alt = AltFactory.createNew(request.getUserPrincipal().getName(), charname, station, race);

      if (alt != null)
      {
        conn = new InvasionConnection();
        new Message(conn, alt.getId(), 1, "Welcome to Invasion's pre-alpha stage.  In reality, you can't do much yet.  Over time, more will be added and I'm relying on you to pass on lessons learned to others (via the boards, for example) who will follow you.  Also, I need bug reports, suggestions, etc. - put them in the issue tracker.  There are some loop holes in security right now; report them and have fun with them, but don't abuse them.  Mostly, enjoy.");
        String query = "update alt set humanskill=?, tohuskill=?, tikkunskill=? where id=?";
        int count = conn.psExecuteUpdate(query, "Error updating " + alt.getName() + " for their starting skills", new Object[] { Long.valueOf(humanSkill), Long.valueOf(tohuSkill), Long.valueOf(tikkunSkill), Integer.valueOf(alt.getId()) });
        if (count != 1)
        {
          throw new BotReportException("Error updating " + alt.getName() + " for their starting skills.  The character was not found under the id " + alt.getId());
        }

        response.sendRedirect(WebUtils.BASE + "");
      }

    }
    catch (Exception e)
    {
      log.log(Level.WARNING, "Error creating new character ", e);
    }
    finally
    {
      DatabaseUtility.close(conn);
    }
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    doGet(request, response);
  }
}
