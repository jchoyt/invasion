package invasion.dataobjects;

import invasion.util.DatabaseUtility;
import invasion.util.InvasionConnection;
import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

public class Skills
  implements Serializable
{
  public static final String KEY = Skills.class.getName();
  public static final Logger log = Logger.getLogger(KEY);

  private static Map<String, Skill> byName = new HashMap();
  private static Map<Integer, Skill> byId = new HashMap();
  protected static List<Skill> humanSkills = new ArrayList<Skill>();
  protected static List<Skill> tohuSkills = new ArrayList<Skill>();
  protected static List<Skill> tikkunSkills = new ArrayList<Skill>();

  public static void load()
  {
    String query = "select s.*, t.id as prereqid, t.name prereqname from skills s left outer join skills t on s.prerequisite = t.id order by s.id";

    InvasionConnection conn = null;
    ResultSet rs = null;
    try
    {
      conn = new InvasionConnection();
      rs = conn.executeQuery(query);
      while (rs.next())
      {
        Skill s = new Skill();
        s.setId(rs.getInt("id"));
        s.setValue(rs.getLong("value"));
        s.setRace(rs.getString("race"));
        s.setName(rs.getString("name"));
        s.setPrereq(rs.getInt("prereqid"));
        s.setCost(rs.getInt("cost"));
        s.setHelplink(rs.getString("helplink"));
        addSkill(s);
        log.finer("Loaded " + s.getName());
      }
    }
    catch (SQLException e)
    {
      log.throwing(KEY, "Massive problem - error loading Skills list", e);
      throw new RuntimeException(e);
    }
    finally
    {
      DatabaseUtility.close(rs);
      conn.close();
    }
  }

  public static void addSkill(Skill s)
  {
    byName.put(s.getName(), s);
    byId.put(Integer.valueOf(s.getId()), s);

    if (s.getRace().equals(invasion.util.Constants.RACENAMES[1]))
    {
      if (s.getPrereq() == 0) {
        humanSkills.add(s);
      }
    } else if (s.getRace().equals(invasion.util.Constants.RACENAMES[2]))
    {
      if (s.getPrereq() == 0) {
        tohuSkills.add(s);
      }
    } else if (s.getRace().equals(invasion.util.Constants.RACENAMES[3]))
    {
      if (s.getPrereq() == 0) {
        tikkunSkills.add(s);
      }
    } else
      throw new RuntimeException("Database fucked up. Race needs to be 1 , 2 , or 3.  It's set as " + s.getRace());
    if (s.getPrereq() > 0)
    {
      Skill parent = (Skill)byId.get(Integer.valueOf(s.getPrereq()));
      parent.addChild(s);
      log.finer(s.getName() + " should be added as a child of " + parent.getName());
    }
  }

  public static Long getValue(String skill)
  {
    return Long.valueOf(((Skill)byName.get(skill)).getValue());
  }

  public static Skill getById(int id)
  {
    return (Skill)byId.get(Integer.valueOf(id));
  }

  public static double calculateAttackChance(double baserate, int attackerLevel, int dodgeLevel)
  {
    return (1D + baserate - Math.pow(baserate, attackerLevel / 6.0D)) * (1D - Math.cos(1.5707963267948966D - dodgeLevel * 3.141592653589793D / 15.0D));
  }

  public static List<Skill> getHumanSkills()
  {
    return humanSkills;
  }
  public static List<Skill> getTikkunSkills() { return tikkunSkills; }
  public static List<Skill> getTohuSkills() {
    return tohuSkills;
  }
}
