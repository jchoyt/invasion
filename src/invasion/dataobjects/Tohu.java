package invasion.dataobjects;

import invasion.util.InvasionConnection;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;

public class Tohu
  extends Alt
{
  public static final String KEY = Tohu.class.getName();
  public static final Logger log = Logger.getLogger(KEY);
  static { log.setLevel(Level.FINER); }

  protected long tohuSkills = 0L;
  protected int summonerLevel = 0;

  public boolean hasSkill(Skill what)
  {
    log.finer("In Tohu, checking to see if " + this.name + " has the skill, " + what.getName());
    if (what.getRace().equals(invasion.util.Constants.RACENAMES[2]))
    {
      log.finer("Well, does he?  " + (this.tohuSkills & what.getValue()));
      return (this.tohuSkills & what.getValue()) > 0L;
    }

    log.finer("Not a Tohu Skill");
    return super.hasSkill(what);
  }

  public JSONArray attack(Defender defender, InvasionConnection conn)
  {
    return null;
  }

  public boolean isPetmaster()
  {
    if (this.summonerLevel > 0)
    {
      return true;
    }

    return false;
  }

  public long getTohuSkills() { return this.tohuSkills; }
  public void setTohuSkills(long tohuSkills) { this.tohuSkills = tohuSkills; }
  public int getSummonerLevel() { return this.summonerLevel; }
  public void setSummonerLevel(int summonerLevel) { this.summonerLevel = summonerLevel; }
}
