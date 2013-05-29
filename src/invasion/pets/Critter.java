package invasion.pets;

import invasion.dataobjects.Alt;
import invasion.dataobjects.Attacker;
import invasion.dataobjects.CombatResult;
import invasion.dataobjects.Defender;
import invasion.util.DatabaseUtility;
import invasion.util.InvasionConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.logging.Logger;
import org.json.JSONObject;

public abstract class Critter implements Attacker, Defender
{
  public static final String KEY = Critter.class.getName();
  public static final Logger log = Logger.getLogger(KEY);

  protected String description = null;
  protected String name = null;
  protected char damageType = 'p';
  protected float attackAccuracy = 0.4F;
  protected float defendAccuracy = 0.1F;
  protected int ap = 50;
  protected int apmax = 50;
  protected int armor = 50;
  protected int armorMax = 50;
  protected invasion.util.DiceRoller attackDamage = new invasion.util.DiceRoller("2d5");
  protected int cost = 10;
  protected int hpCost = 0;
  protected int maintenanceRate = 10;
  protected int hp = 30;
  protected int hpmax = 0;
  protected int id = 0;
  protected int lasthurtby = 0;
  protected int shield = 0;
  protected int shieldMax = 0;
  protected Brood brood = null;
  protected int typeid = -1;
  protected int location = 0;
  protected String[] deathKnells = { "You have landed the killing blow." };
  protected long stunned = 0L;
  private static Map<Integer, String> critterClasses = new java.util.HashMap();
  protected String[] summonMessages = { "", "" };

  public void setBroodGoals() {}

  public JSONObject toJson(Alt alt)
    throws org.json.JSONException
  {
    JSONObject obj = new JSONObject();
    obj.put("name", this.name);
    obj.put("id", this.id);
    obj.put("hp", Alt.calcHpCategory(this.hp, this.hpmax));
    String cssClass = null;
    if (alt.getId() == this.brood.getOwnerId())
    {
      cssClass = "fc-self";
    }
    else {
      cssClass = invasion.dataobjects.FactionPolitics.getPolitics(alt.getFactionId(), this.brood.getFactionId()).getCssClass();
    }
    obj.put("css-class", cssClass);

    return obj;
  }

  public boolean insert()
  {
    String query = "insert into critters (brood, typeid, name, ap, hp,armor, shield) values (?,?,?,?,?,?,?)";
    InvasionConnection conn = null;
    ResultSet rs = null;
    try
    {
      conn = new InvasionConnection("postgres");
      conn.setAutoCommit(false);
      conn.psExecuteUpdate(query, "Error adding new brood to the database", new Object[] { brood.getId(), typeid, name, ap, hp, armor, shield });

      query = "select max(id) as id from critters";
      rs = conn.executeQuery(query);
      rs.next();
      this.id = rs.getInt("id");
      LocationCache.incrementCritters(this.brood.getLocation());

      return true;
    }
    catch (SQLException e) {
      try {
        conn.rollback(); } catch (Exception e2) { e2.printStackTrace(System.out); }
      log.throwing(KEY, "a useful message", e);
      return false;
    }
    finally {
      try {
        conn.commit(); } catch (Exception e2) { e2.printStackTrace(System.out); }
      DatabaseUtility.close(rs);
      DatabaseUtility.close(conn);
    }
  }

  public boolean update()
  {
    String query = "update critters set name=?, ap=?, hp=?, armor=?, shield=?, lasthurtby=? where id=?";
    InvasionConnection conn = null;
    try
    {
      conn = new InvasionConnection("postgres");
      int count = conn.psExecuteUpdate(query, "Error updating brood in the database", new Object[] { this.name, Integer.valueOf(this.ap), Integer.valueOf(this.hp), Integer.valueOf(this.armor), Integer.valueOf(this.shield), Integer.valueOf(this.lasthurtby), Integer.valueOf(this.id) });
      if (count != 1)
      {
        log.warning("Critter " + this.id + " not updated");
        return false;
      }

      return true;
    }
    catch (SQLException e) {
      boolean bool;
      log.throwing(KEY, "a useful message", e);
      return false;
    }
    finally
    {
      DatabaseUtility.close(conn);
    }
  }

  public static void loadClassNames()
  {
    String query = "select * from crittertype";
    InvasionConnection conn = null;
    ResultSet rs = null;
    try
    {
      conn = new InvasionConnection();
      rs = conn.executeQuery(query);
      while (rs.next())
      {
        critterClasses.put(rs.getInt("id"), rs.getString("class"));
      }
    }
    catch (SQLException e)
    {
      log.throwing(KEY, "Massive problem - error loading the critter class reference list", e);
      throw new RuntimeException(e);
    }
    finally
    {
      DatabaseUtility.close(rs);
      conn.close();
    }
  }

  public static String getCritterClass(int id)
  {
    return (String)critterClasses.get(id);
  }

  public abstract boolean checkSummoner(Alt paramAlt);

  public abstract void init();

  public void insertMessage(String message, int type, InvasionConnection conn) {}

  public CombatResult hit(Attacker attacker, int rawAmount, char damagetype, InvasionConnection conn, boolean updateNow)
    throws SQLException
  {
    CombatResult result = new CombatResult(rawAmount);
    log.finer("Critter " + this.id + " getting hit for " + rawAmount + " damage.");

    if ((damagetype == 'p') && (this.armor > 0))
    {
      int maxSoak = (int)(0.75D * rawAmount);
      if (maxSoak > this.armor)
      {
        result.setArmorSoak(this.armor);
        this.armor = 0;
      }
      else
      {
        result.setArmorSoak(maxSoak);
        this.armor -= maxSoak;
      }
    }
    else if ((damagetype == 'e') && (this.shield > 0))
    {
      int maxSoak = (int)(0.95D * rawAmount);
      if (maxSoak > this.shield)
      {
        result.setShieldSoak(this.shield);
        this.shield = 0;
      }
      else
      {
        result.setShieldSoak(maxSoak);
        this.shield -= maxSoak;
      }
    }

    this.lasthurtby = attacker.getAttackerId();
    this.hp -= result.getDamageDone();

    if (this.hp < 1)
    {
      kill(attacker, conn, result);
      attacker.setReload(true);
    }
    else if (updateNow) {
      update(); }
    return result;
  }

  public void notifyAttacked(Attacker attacker, InvasionConnection conn)
  {
    Defender defender = (Defender)attacker;
    if (this.hp > 0) {
      attack(defender, conn);
    }
  }

  public void kill(Attacker attacker, CombatResult result)
  {
    InvasionConnection conn = null;
    try
    {
      conn = new InvasionConnection();
      kill(attacker, conn, result);
    }
    catch (SQLException e)
    {
      log.throwing(KEY, "a useful message", e);
    }
    finally
    {
      DatabaseUtility.close(conn);
    }
  }

  public void kill(Attacker attacker, InvasionConnection conn, CombatResult result)
    throws SQLException
  {
    if (this.lasthurtby > 0)
    {
      Alt alt = (Alt)attacker;
      alt.setXp(alt.getXp() + 10);

      int ipHit = 2;

      String message = invasion.util.RandomUtilities.pickRandom(this.deathKnells) + "  You have been awarded an additional 10 XP.";
      if (ipHit > 0)
      {
        message = message + "  As you view the remanants of your slaughter, your stomach churns (+" + ipHit + " IP).";
        alt.setIp(alt.getIp() + ipHit);
      }
      alt.update();
      invasion.dataobjects.Stats.addChange(this.lasthurtby, 9, 1);
      invasion.dataobjects.ActionLog.addAction(this.lasthurtby, 3, this.id);

      if (result == null)
      {
        new invasion.dataobjects.Message(conn, this.lasthurtby, 0, message);
      }
      else {
        result.getAttackerMessages().add(message);
      }
      invasion.dataobjects.Message.locationBroadcast(conn, alt.getLocation(), 0, alt.getName() + " killed " + this.name + "!  Poor, innocent critter.", alt.getId());
    }

    String query = "delete from critters where id=" + this.id;

    if (this.brood != null)
    {
      LocationCache.decrementCritters(this.brood.getLocation());
      this.brood.removeMember(this, conn);
    }

    try
    {
      conn.executeUpdate(query);
    }
    catch (SQLException e)
    {
      log.throwing(KEY, "a useful message", e);
      throw new RuntimeException(e);
    }
  }

  public int getDodgeLevel()
  {
    return 0;
  }

  public invasion.dataobjects.Faction getFaction()
  {
    if (this.brood.getOwnerId() > 0)
    {
      Alt owner = invasion.util.AltFactory.load(this.brood.getOwnerId());
      return owner.getFaction();
    }
    return null;
  }

  public org.json.JSONArray attack(Defender defender, InvasionConnection conn)
  {
    try
    {
      invasion.dataobjects.ActionLog.addAction(this.id, 2, defender.getId());

      if (Math.random() < this.attackAccuracy)
      {
        defender.hit(this, this.attackDamage.roll(), this.damageType, conn, true);
      }
      else
      {
        defender.insertMessage(this.name + " attacked you and missed.", 0, conn);
      }

      return null;
    }
    catch (Exception e)
    {
        log.throwing(KEY, "body", e);
        return null;
    }
  }

  public int getAttackerId()
  {
    return getBrood().getOwnerId();
  }

  public boolean getReload() {
    return false;
  }

  public void setReload(boolean reload) {}
  public String getDescription() { return this.description; }
  public String getName() { return this.name; }
  public char getDamageType() { return this.damageType; }
  public float getAttackAccuracy() { return this.attackAccuracy; }
  public float getDefendAccuracy() { return this.defendAccuracy; }
  public int getAp() { return this.ap; }
  public int getApmax() { return this.apmax; }
  public int getArmor() { return this.armor; }
  public int getCost() { return this.cost; }
  public int getHp() { return this.hp; }
  public int getHpmax() { return this.hpmax; }
  public int getId() { return this.id; }
  public int getLasthurtby() { return this.lasthurtby; }
  public int getShield() { return this.shield; }
  public void setAp(int ap) { this.ap = ap; }
  public void setApmax(int apmax) { this.apmax = apmax; }
  public void setArmor(int armor) { this.armor = armor; }
  public void setAttackAccuracy(float attackAccuracy) { this.attackAccuracy = attackAccuracy; }
  public void setCost(int cost) { this.cost = cost; }
  public void setDamageType(char damageType) { this.damageType = damageType; }
  public void setDefendAccuracy(float defendAccuracy) { this.defendAccuracy = defendAccuracy; }
  public void setDescription(String description) { this.description = description; }
  public void setHp(int hp) { this.hp = hp; }
  public void setHpmax(int hpmax) { this.hpmax = hpmax; }
  public void setId(int id) { this.id = id; }
  public void setLasthurtby(int lasthurtby) { this.lasthurtby = lasthurtby; }
  public void setName(String name) { this.name = name; }
  public void setShield(int shield) { this.shield = shield; }
  public Brood getBrood() { return this.brood; }
  public void setBrood(Brood brood) { this.brood = brood; }
  public int getTypeid() { return this.typeid; }
  public void setTypeid(int typeid) { this.typeid = typeid; }
  public int getLocation() { return this.location; }
  public void setLocation(int location) { this.location = location; }
  public long getStunned() { return this.stunned; }
  public void setStunned(long stunned) { this.stunned = stunned; }
  public String[] getSummonMessages() { return this.summonMessages; }
  public void setSummonMessages(String[] summonMessages) { this.summonMessages = summonMessages; }
  public int getHpCost() { return this.hpCost; }
  public void setHpCost(int hpCost) { this.hpCost = hpCost; }
}
