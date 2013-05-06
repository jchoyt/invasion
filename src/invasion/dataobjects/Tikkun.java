package invasion.dataobjects;

import invasion.util.InvasionConnection;
import org.json.JSONArray;

public class Tikkun
  extends Alt
{
  protected long tikkunSkills = 0L;
  protected int summonerLevel = 0;

  public boolean hasSkill(Skill what)
  {
    if (what.getRace().equals(invasion.util.Constants.RACENAMES[3]))
    {
      return (this.tikkunSkills & what.getValue()) > 0L;
    }

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

  public long getTikkunSkills() { return this.tikkunSkills; }
  public void setTikkunSkills(long tikkunSkills) { this.tikkunSkills = tikkunSkills; }
}
