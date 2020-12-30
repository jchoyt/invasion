package invasion.pets;

import invasion.bot.VasionBot;
import invasion.dataobjects.Alt;
import invasion.util.DatabaseUtility;
import invasion.util.InvasionConnection;
import invasion.util.WebUtils;
import java.io.File;
import java.lang.reflect.Constructor;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;

public class BroodManager
{
  public static final String KEY = BroodManager.class.getName();
  public static final Logger log = Logger.getLogger(KEY);

  protected static Map<Integer, Brood> playerBroods = new ConcurrentHashMap<Integer, Brood>();
  protected static List<Brood> feralBroods = new CopyOnWriteArrayList<Brood>();
  protected static File serializedFileLocation = null;

  public BroodManager(String file)
  {
    serializedFileLocation = new File(file);
  }

  @SuppressWarnings("unused")
  private BroodManager() {}

  /**
   *  make all the broods do something
   */
  public static void workBroodsForTick()
  {
    InvasionConnection conn = null;

    try
    {
      conn = new InvasionConnection();
      log.entering(KEY, "workBroodsForTick");

      for (Integer key : playerBroods.keySet())
      {
        playerBroods.get(key).act(conn, conn);
      }

      for (Brood b : feralBroods)
      {
        b.act(conn, conn);
      }
      log.exiting(KEY, "workBroodsForTick");
    }
    catch (SQLException e)
    {
      log.throwing(KEY, "a useful message", e);
      throw new RuntimeException(e);
    }
    catch (RuntimeException e)
    {
      log.throwing(KEY, "act() threw a runtime exception", e);
    }
    finally
    {
      DatabaseUtility.close(conn);
    }
  }

  public static void workBroods()
  {
    InvasionConnection conn = null;

    try
    {
      conn = new InvasionConnection();

      for (Integer key : playerBroods.keySet())
        if (playerBroods.get(key).getActive())
          playerBroods.get(key).act(conn, conn);
      for (Brood b : feralBroods) {
        if (b.getActive()) {
          b.act(conn, conn);
        }
      }
    } catch (SQLException e) {
      log.throwing(KEY, "a useful message", e);
      throw new RuntimeException(e);
    }
    finally
    {
      DatabaseUtility.close(conn);
    }
  }

  public static Critter getCritter(int id, JSONArray alerts)
  {
    for (Brood b : playerBroods.values())
      for (Critter c : b.getMembers())
        if (c.getId() == id) return c;
    for (Brood b : feralBroods)
      for (Critter c : b.getMembers())
        if (c.getId() == id) return c;
    return null;
  }

  public static JSONArray petsAtLocation(Alt alt)
    throws JSONException
  {
    int locid = alt.getLocation();
    JSONArray ret = new JSONArray();
    for (Brood b : feralBroods)
      if (b.getLocation() == locid)
        for (Critter c : b.getMembers())
          ret.put(c.toJson(alt));
    for (Brood b : playerBroods.values())
      if (b.getLocation() == locid)
        for (Critter c : b.getMembers())
          ret.put(c.toJson(alt));
    return ret;
  }

  public static void load()
  {
    InvasionConnection conn = null;

    String query = "select * from brood";
    ResultSet rs = null;
    ResultSet rs2 = null;

    try
    {
      conn = new InvasionConnection("postgres");
      rs = conn.executeQuery(query);
      while (rs.next())
      {
        Brood ret = new Brood();
        ret.setLocation(rs.getInt("location"));
        ret.setType(rs.getInt("type"));
        ret.setGoal(0, rs.getInt("goal_survive"));
        ret.setGoal(1, rs.getInt("goal_protect"));
        ret.setGoal(2, rs.getInt("goal_killpsi"));
        ret.setGoal(3, rs.getInt("goal_killmut"));
        ret.setGoal(4, rs.getInt("goal_killhuman"));
        ret.setOwnerId(rs.getInt("owner"));
        ret.setId(rs.getInt("id"));

        query = "select id as critterid from critters where brood = ?";
        rs2 = conn.psExecuteQuery(query, "Error message", new Object[] { Integer.valueOf(ret.getId()) });
        while (rs2.next())
          ret.addMember(loadCritter(conn, rs2.getInt("critterid"), ret));
        DatabaseUtility.close(rs2);
        ret.buildTargetList(conn);
        if (ret.getOwnerId() < 1) {
          feralBroods.add(ret);
        } else
          playerBroods.put(Integer.valueOf(ret.getOwnerId()), ret);
      }
      DatabaseUtility.close(rs);
    }
    catch (SQLException e)
    {
      log.throwing(KEY, "a useful message", e);
      throw new RuntimeException(e);
    }
    finally
    {
      log.finer("Loaded " + feralBroods.size() + " feral broods and " + playerBroods.size() + " player broods.");
      DatabaseUtility.close(rs);
      conn.close();
    }
  }

  public static void addBrood(Brood b)
  {
    log.finer("new brood is owned by " + b.getOwnerId());
    if (b.getOwnerId() == -1) {
      feralBroods.add(b);
    } else {
      playerBroods.put(Integer.valueOf(b.getOwnerId()), b);
    }
  }

  public static void removeBrood(Brood b)
  {
    if (b.getOwnerId() < 1) {
      feralBroods.remove(b);
    } else {
      playerBroods.remove(Integer.valueOf(b.getOwnerId()));
    }
  }

  public static Brood getFeralBrood(int id) {
    for (Brood b : feralBroods)
      if (b.getId() == id)
        return b;
    return null;
  }

  public static Brood getPlayerBrood(int id)
  {
    return playerBroods.get(Integer.valueOf(id));
  }

  public static void processAttacks()
  {
    InvasionConnection conn = null;
    try
    {
      conn = new InvasionConnection();
      for (Brood b : feralBroods)
        if (b.getActive())
        {
          log.finer("Brood " + b.getId() + " is active.");
          b.attack(conn);
        }
      for (Brood b : playerBroods.values()) {
        if (b.getActive()) {
          b.attack(conn);
        }
      }
    } catch (Exception e) {
      log.throwing(KEY, "processAttacks", e);
      String errFile = WebUtils.dumpError(e);
      VasionBot.announce("Error processing pet attacks.  If this repeats, things are going to get very spammy. Details can be found at " + errFile);
    }
    finally
    {
      DatabaseUtility.close(conn);
    }
  }

  public static Critter loadCritter(InvasionConnection conn, int critterId, Brood brood)
  {
    String query = "select class, b.id as broodid, ap, hp, armor, shield, typeid, c.name, location  from critters c join crittertype t on c.typeid=t.id join brood b on c.brood=b.id where c.id=?";
    ResultSet rs = null;
    Critter ret = null;
    try
    {
      rs = conn.psExecuteQuery(query, "Error message", new Object[] { Integer.valueOf(critterId) });
      if (rs.next())
      {
        Class<?> clazz = Class.forName(rs.getString("class"));
        Constructor<?> constructor = clazz.getConstructor(new Class[] { Brood.class });

        ret = (Critter)constructor.newInstance(new Object[] { brood });
        ret.setId(critterId);
        ret.setAp(rs.getInt("ap"));
        ret.setHp(rs.getInt("hp"));

        ret.setArmor(rs.getInt("armor"));
        ret.setShield(rs.getInt("shield"));
        ret.setName(rs.getString("name"));
        ret.setTypeid(rs.getInt("typeid"));
        ret.setLocation(rs.getInt("location"));
        ret.setBrood(brood);
      }

      DatabaseUtility.close(rs);
    }
    catch (Exception e)
    {
      log.throwing(KEY, "a useful message", e);
      throw new RuntimeException(e);
    }
    finally
    {
      DatabaseUtility.close(rs);
    }

    return ret;
  }

  public static List<Brood> getFeralBroods() { return feralBroods; }
  public static Collection<Brood> getPlayerBroods() { return playerBroods.values(); }
}
