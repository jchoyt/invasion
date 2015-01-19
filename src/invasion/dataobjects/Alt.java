package invasion.dataobjects;

import invasion.pets.Critter;
import invasion.pets.LocationCache;
import invasion.servlets.Recharge;
import invasion.util.AltFactory;
import invasion.util.Constants;
import invasion.util.DatabaseUtility;
import invasion.util.InvasionConnection;
import invasion.ui.Poll;
import java.io.Serializable;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class Alt
  implements Serializable, Attacker, Defender
{
  public static final String KEY = Alt.class.getName();
  public static final Logger log = Logger.getLogger(KEY);

  protected int location = -1;
  protected int locationType = -1;
  protected String name;
  protected int ap = 50;
  protected int apmax = 50;
  protected int ip = 0;
  protected int cp = 0;
  protected int hp = 50;
  protected int hpmax = 50;
  protected Item equippedWeapon = null;
  protected Item equippedShield = null;
  protected Item equippedArmor = null;
  protected boolean autoReload = true;
  protected int id = 0;
  protected String username = null;
  protected int xp = 0;
  protected Faction faction = null;
  protected int factionrank = 0;
  protected int level = 0;
  protected int lastHurtBy = 0;
  protected int race = 0;
  protected long humanSkills = 0L;
  protected long tohuskills = 0L;
  protected long tikkunskills = 0L;
  protected int firearmsAttackLevel = 0;
  protected int meleeAttackLevel = 0;
  protected int tinkererLevel = 0;
  protected boolean reload = false;
  protected List<String> skillsUsed = new ArrayList<String>();
  protected boolean equippedItemsLoaded = false;
  protected List<String> clothing = new ArrayList<String>();
  protected char gender = 'f';
  protected Effects effects = new Effects();
  protected int ticksalive = 0;
  protected long stunned = 0L;
  protected int station = 0;

  public static final int ENERGYPISTOL = 26;

  public static final int ENERGYPACK = 28;

  public static final int SWORD = 34;

  public void unequipWeapon()
  {
    this.equippedWeapon = null;
  }

  public void decrementAp(InvasionConnection conn, int count)
  {
    log.entering(KEY, "decrementAp");
    this.ap -= count;
    if (!update())
      log.severe("Update failed");
    log.exiting(KEY, "decrementAp");
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

  public boolean update(InvasionConnection conn)
  {
    log.entering(KEY, "update");
    String query = "update alt set ap=?, ip=?, hp=?, xp=?, lasthurtby=?, location=?, factionid=?, factionrank=?  where id=?";
    int factionid = -1;
    if (this.faction != null)
    {
      factionid = this.faction.getId();
    }

    int count = conn.psExecuteUpdate(query, "Error updating character in the database", new Object[] { Integer.valueOf(this.ap), Integer.valueOf(this.ip), Integer.valueOf(this.hp), Integer.valueOf(this.xp), Integer.valueOf(this.lastHurtBy), Integer.valueOf(this.location), Integer.valueOf(factionid), Integer.valueOf(this.factionrank), Integer.valueOf(this.id) });
    log.finer("query done");
    if (count != 1)
    {
      log.warning(new StringBuilder().append("Character ").append(this.id).append(" not updated").toString());
      return false;
    }
    if (!this.effects.update(conn, this.id))
      return false;
    return true;
  }

  public boolean update()
  {
    InvasionConnection conn = null;
    try
    {
      conn = new InvasionConnection();
      return update(conn);
    }
    catch (SQLException e)
    {
      log.throwing(KEY, "a useful message", e);
      return false;
    }
    finally
    {
      DatabaseUtility.close(conn);
    }
  }

  public static int calcHpCategory(int hp, int hpmax)
  {
    int hpPercent = 100 * hp / hpmax;
    if (hpPercent < 10)
      return 4;
    if (hpPercent < 25)
      return 3;
    if (hpPercent < 50)
      return 2;
    if (hpPercent < 99) {
      return 1;
    }
    return 0;
  }

  public void heal(int amt)
  {
    this.hp = (this.hp + amt <= this.hpmax ? this.hp + amt : this.hpmax);
  }

  public void healIp(int amt)
  {
    this.ip = (this.ip - amt > 0 ? this.ip - amt : 0);
  }

  public int getFactionId()
  {
    if (this.faction == null)
    {
      return -1;
    }
    return this.faction.getId();
  }

  public static JSONObject getStats(InvasionConnection conn, int altid)
    throws SQLException, JSONException
  {
    Alt alt = AltFactory.load(conn, altid);
    JSONObject obj = new JSONObject();
    obj.put("altid", alt.id);
    obj.put("hp", alt.hp);
    obj.put("ap", alt.ap);
    obj.put("ip", alt.ip);
    obj.put("xp", alt.xp);
    obj.put("cp", alt.cp);
    obj.put("level", alt.level);
    obj.put("ticksalive", alt.ticksalive);
    obj.put("daysalive", alt.ticksalive / 96);
    obj.put("firearms", alt.firearmsAttackLevel);
    obj.put("shields", alt.getEquippedShield() == null ? 0 : alt.getEquippedShield().getAmmoleft());
    obj.put("armor", alt.getEquippedArmor() == null ? 0 : alt.getEquippedArmor().getAmmoleft());
    if (alt.hp < 1) obj.put("reload", true);
    obj.put("effects", alt.effects.getEffectsString());
    return obj;
  }

  protected boolean checkReload(InvasionConnection conn)
    throws SQLException
  {
    if (this.equippedWeapon.getAmmoleft() < 1)
    {
      String reloadResult = Recharge.rechargeItem(conn, this, this.equippedWeapon);
      if (reloadResult != null)
      {
        new Message(conn, this.id, 0, "Your weapon is out of ammunition.  You don't have anything to reload it with.");
        return false;
      }

      new Message(conn, this.id, 0, "Your weapon is out of ammunition.  You reload your weapon.");
    }
    return true;
  }

  public boolean hasSkill(Skill what)
  {
    if (what.getRace().equals(Constants.RACENAMES[1]))
    {
      return (getHumanSkills() & what.getValue()) > 0L;
    }
    return false;
  }

  public void insertMessage(String message, int type, InvasionConnection conn)
  {
    new Message(conn, this.id, type, message);
  }

  public JSONArray attack(Defender defender, InvasionConnection conn)
  {
    JSONArray alerts = null;

    try
    {
      if (this.location != defender.getLocation())
      {
        log.finer("Defender no longer at the attacker's location");
        alerts = new JSONArray();
        alerts.put(Poll.createErrorAlert("Your target is no longer in the area."));
        return alerts;
      }

      if (this.equippedWeapon == null)
      {
        alerts = new JSONArray();
        log.finer("No weapon equipped");
        alerts.put(Poll.createErrorAlert("You must equip a weapon before attacking with it."));
        return alerts;
      }
      ActionLog.addAction(this.id, 2, defender.getId());
      if (this.equippedWeapon.getItemtype().getUsesammo())
      {
        attackWithFirearm(conn, defender);
      }
      else {
        attackWithMelee(conn, defender);
      }

      return null;
    }
    catch (Exception e)
    {
      log.throwing(KEY, "body", e);
      alerts = new JSONArray();
      alerts.put(Poll.createErrorAlert(e.getMessage())); }
    return alerts;
  }

  public void attackWithMelee(InvasionConnection conn, Defender defender)
    throws SQLException
  {
    log.entering(KEY, "attackWithMelee");
    int apIncrement = 1;
    int attackLevel = this.meleeAttackLevel;
    int damageBounus = 0;
    int damageMultiplier = 1;
    int shots = 1;

    if ((this.humanSkills & Skills.getValue("Melee 1").longValue()) > 0L) damageBounus++;
    if ((this.humanSkills & Skills.getValue("Melee 2").longValue()) > 0L) damageBounus += 2;
    if ((this.humanSkills & Skills.getValue("Melee 3").longValue()) > 0L) damageBounus += 2;
    if ((this.humanSkills & Skills.getValue("Melee 4").longValue()) > 0L) damageBounus += 2;
    if ((this.humanSkills & Skills.getValue("Melee 5").longValue()) > 0L) damageBounus += 3;

    if ((this.skillsUsed.contains("Whirlwind")) && ((this.humanSkills & Skills.getValue("Melee 4").longValue()) > 0L))
    {
      attackLevel = this.meleeAttackLevel - 2;
      shots = 2;
    }
    else if ((this.skillsUsed.contains("Brutality")) && ((this.humanSkills & Skills.getValue("Melee 5").longValue()) > 0L))
    {
      if (Math.random() < 0.8D)
        damageMultiplier = 3;
      apIncrement = 2;
    }

    if (!this.equippedWeapon.getItemtype().getName().equals("weapon"))
    {
      damageBounus = Math.round(damageBounus / 2F);
    }

    for (int i = 0; i < shots; i++)
    {
      if (Math.random() < this.equippedWeapon.getMods().getMisfireRate())
      {
        new Message(conn, this.id, 4, "As you swing the weapon, something feels terribly wrong and it takes you off-balance; you miss.");
      }
      else
      {
        double attackChance = Skills.calculateAttackChance(this.equippedWeapon.getItemtype().getAccuracy(), attackLevel, defender.getDodgeLevel());

        attackChance *= this.equippedWeapon.getMods().getScaleAccuracy();
        if (Math.random() < attackChance)
        {
          float rawDamage = (this.equippedWeapon.getItemtype().getDamage() + damageBounus) * damageMultiplier;

          int damage = Math.round(rawDamage * this.equippedWeapon.getMods().getScaleDamage());
          CombatResult result = defender.hit(this, damage, this.equippedWeapon.getItemtype().getDamageType(), conn, true);
          StringBuilder ret = new StringBuilder(new StringBuilder().append("You attack ").append(defender.getName()).append(" with your ").append(this.equippedWeapon.getItemtype().getName()).toString());
          ret.append(new StringBuilder().append(" and deal ").append(result.getDamageDone()).append(" points of damage.").toString());
          if (result.getArmorSoak() > 0)
            ret.append(new StringBuilder().append(" Your victim's armor soaked ").append(result.getArmorSoak()).append(" points.").toString());
          if (result.getShieldSoak() > 0) {
            ret.append(new StringBuilder().append(" Your victim's shields soaked ").append(result.getShieldSoak()).append(" points.").toString());
          }
          ret.append(applyXpGain(defender, result));
          new Message(conn, this.id, 0, ret.toString());
          for (String msg : result.getAttackerMessages()) {
            new Message(conn, this.id, 0, msg);
          }
          update(conn);

          if ((!this.equippedWeapon.getItemtype().getName().equals("weapon")) && (this.equippedWeapon.getItemtype().isConsumable()) && (Math.random() < 0.85D))
          {
            Item.delete(conn, this.equippedWeapon.getId());
            this.equippedWeapon = null;
            update(conn);
          }

        }
        else
        {
          new Message(conn, this.id, 0, new StringBuilder().append("You attack ").append(defender.getName()).append(" with your ").append(this.equippedWeapon.getItemtype().getName()).append(" and miss.").toString());
          defender.insertMessage(new StringBuilder().append(this.name).append(" attacked you with a ").append(this.equippedWeapon.getItemtype().getName()).append(" and missed.").toString(), 0, conn);
        }

        if (defender.getHp() < 1) {
          break;
        }
        if (this.hp < 1)
          break;
        defender.notifyAttacked(this, conn);
      }  }
    decrementAp(conn, apIncrement);
  }

  protected void attackWithFirearm(InvasionConnection conn, Defender defender)
    throws SQLException
  {
    log.entering(KEY, "attackWithFirearm");

    if (!checkReload(conn))
      return;
    int apIncrement = 1;
    int attackLevel = this.firearmsAttackLevel;
    int damageBounus = 0;
    int damageMultiplier = 1;
    int shots = 1;

    if ((this.humanSkills & Skills.getValue("Firearms 1").longValue()) > 0L) damageBounus++;
    if ((this.humanSkills & Skills.getValue("Firearms 2").longValue()) > 0L) damageBounus += 2;
    if ((this.humanSkills & Skills.getValue("Firearms 3").longValue()) > 0L) damageBounus += 2;
    if ((this.humanSkills & Skills.getValue("Firearms 4").longValue()) > 0L) damageBounus += 2;
    if ((this.humanSkills & Skills.getValue("Firearms 5").longValue()) > 0L) damageBounus += 3;
    if ((this.skillsUsed.contains("Double Shot")) && ((this.humanSkills & Skills.getValue("Firearms 4").longValue()) > 0L))
    {
      attackLevel = this.firearmsAttackLevel - 2;
      shots++;
    }
    else if ((this.skillsUsed.contains("Kill Shot")) && ((this.humanSkills & Skills.getValue("Firearms 5").longValue()) > 0L))
    {
      if (Math.random() < 0.5D)
        damageMultiplier = 5;
      apIncrement = 2;
    }
    for (int i = 0; i < shots; i++)
    {
      if (Math.random() < this.equippedWeapon.getMods().getMisfireRate())
      {
        new Message(conn, this.id, 4, "You hear a faint click, but nothing happens.");
      }
      else
      {
        if (this.equippedWeapon.getItemtype().getDamageType() == 'e')
        {
          if (Math.random() < this.equippedWeapon.getMods().getShortCircuitRate())
          {
            int damage = this.equippedWeapon.getAmmoleft() * this.equippedWeapon.getItemtype().getDamage();
            if (damage >= this.hp)
            {
              new Message(conn, this.id, 4, new StringBuilder().append("As you pull the trigger, it doesn't fire, but suddenly gets very, very hot.  Too late, you figure out that it's short circuiting...energy streams out around your upper body and burns you for ").append(damage).append(" points of damage.  Darkness falls, and the pain subsides.").toString());

              Stats.addChange(this.id, 4, damage);

              Message.locationBroadcast(conn, this.location, 0, new StringBuilder().append(this.name).append(" tried to fire ").append(Constants.getHisHer(this.gender, false)).append(" weapon but it short circuited.  You watch in horror as half ").append(Constants.getHisHer(this.gender, false)).append(" torso is absolutely torched - there wasn't even time for ").append(Constants.getHimHer(this.gender, false)).append(" to scream.").toString(), this.id);

              this.lastHurtBy = 0;
              kill(this, conn, null);
            }
            else
            {
              new Message(conn, this.id, 4, new StringBuilder().append("As you pull the trigger, it doesn't fire, but suddenly gets very, very hot.  Too late, you figure out that it's short circuiting...energy streams out around your upper body and burns you for ").append(damage).append(" points of damage.").toString());

              Stats.addChange(this.id, 4, damage);

              Message.locationBroadcast(conn, this.location, 0, new StringBuilder().append(this.name).append(" tried to fire ").append(Constants.getHisHer(this.gender, false)).append(" weapon but it short circuited.  The released energy dances over ").append(Constants.getHisHer(this.gender, false)).append(" body.  You can only watch while ").append(Constants.getHeShe(this.gender, false)).append(" screams in pain.").toString(), this.id);
            }

            this.equippedWeapon.setAmmoleft(0);
            this.equippedWeapon.update(conn);
            update(conn);
          }

        }
        else if (Math.random() < this.equippedWeapon.getMods().getBackFireRate())
        {
          int damage = 2 * this.equippedWeapon.getItemtype().getDamage();
          if (damage >= this.hp)
          {
            new Message(conn, this.id, 4, new StringBuilder().append("As you pull the trigger, the bullet jams and the weapon backfires.  The resulting explosion causes ").append(damage).append(" points of damage.  On top of your existing wounds, this is too much for your body.").toString());

            Stats.addChange(this.id, 4, damage);

            Message.locationBroadcast(conn, this.location, 0, new StringBuilder().append(this.name).append(" tried to fire ").append(Constants.getHisHer(this.gender, false)).append(" weapon but it blew back into  ").append(Constants.getHisHer(this.gender, false)).append(" face.  With a curdled scream, ").append(Constants.getHeShe(this.gender, false)).append(" crumples to the ground, dead.").toString(), this.id);

            this.lastHurtBy = 0;
            kill(this, conn, null);
          }
          else
          {
            new Message(conn, this.id, 4, new StringBuilder().append("As you pull the trigger, but instead of delivering death to your target, the weapon backfires causing ").append(damage).append(" points of damage.").toString());

            Stats.addChange(this.id, 4, damage);

            Message.locationBroadcast(conn, this.location, 0, new StringBuilder().append(this.name).append(" tried to fire ").append(Constants.getHisHer(this.gender, false)).append(" weapon but it blew back into  ").append(Constants.getHisHer(this.gender, false)).append(" face.").toString(), this.id);
          }

          this.equippedWeapon.setAmmoleft(this.equippedWeapon.getAmmoleft() - 1);
          checkReload(conn);
          this.equippedWeapon.update(conn);
          update(conn);
          return;
        }

        this.equippedWeapon.setAmmoleft(this.equippedWeapon.getAmmoleft() - 1);
        checkReload(conn);
        this.equippedWeapon.update(conn);

        double attackChance = Skills.calculateAttackChance(this.equippedWeapon.getItemtype().getAccuracy(), attackLevel, defender.getDodgeLevel());

        attackChance *= this.equippedWeapon.getMods().getScaleAccuracy();
        if (Math.random() < attackChance)
        {
          float rawDamage = (this.equippedWeapon.getItemtype().getDamage() + damageBounus) * damageMultiplier;

          int damage = Math.round(rawDamage * this.equippedWeapon.getMods().getScaleDamage());
          CombatResult result = defender.hit(this, damage, this.equippedWeapon.getItemtype().getDamageType(), conn, true);
          StringBuilder ret = new StringBuilder(new StringBuilder().append("You attack ").append(defender.getName()).append(" with your ").append(this.equippedWeapon.getItemtype().getName()).toString());
          ret.append(new StringBuilder().append(" and deal ").append(result.getDamageDone()).append(" points of damage.").toString());
          if (result.getArmorSoak() > 0)
            ret.append(new StringBuilder().append(" Your victim's armor soaked ").append(result.getArmorSoak()).append(" points.").toString());
          if (result.getShieldSoak() > 0) {
            ret.append(new StringBuilder().append(" Your victim's shields soaked ").append(result.getShieldSoak()).append(" points.").toString());
          }
          ret.append(applyXpGain(defender, result));
          new Message(conn, this.id, 0, ret.toString());
          for (String msg : result.getAttackerMessages()) {
            new Message(conn, this.id, 0, msg);
          }
          update(conn);
        }
        else
        {
          new Message(conn, this.id, 0, new StringBuilder().append("You attack ").append(defender.getName()).append(" with your ").append(this.equippedWeapon.getItemtype().getName()).append(" and miss.").toString());
          defender.insertMessage(new StringBuilder().append(this.name).append(" attacked you with a ").append(this.equippedWeapon.getItemtype().getName()).append(" and missed.").toString(), 0, conn);
        }

        if (defender.getHp() < 1) {
          break;
        }
        if (this.hp < 1)
          break;
        defender.notifyAttacked(this, conn);
      }  }
    decrementAp(conn, apIncrement);
  }

  protected String applyXpGain(Defender defender, CombatResult result)
  {
    if ((this.faction != null) && (defender.getFaction() != null) && (this.faction.getId() == defender.getFaction().getId()))
    {
      return " You gain nothing from attacking a factionmate.";
    }
    this.xp += result.getDamageDone();
    Stats.addChange(this.id, 3, result.getDamageDone());
    return new StringBuilder().append(" You earned ").append(result.getDamageDone()).append(" XP.").toString();
  }

  public JSONArray throwAttack(InvasionConnection conn, Defender defender, Item missile)
    throws SQLException
  {
    int apIncrement = 1;
    int attackLevel = this.meleeAttackLevel;
    int damageBounus = 0;
    int shots = 1;
    boolean usingGoliath = false;
    JSONArray alerts = null;

    if ((this.humanSkills & Skills.getValue("Melee 1").longValue()) > 0L) damageBounus++;
    if ((this.humanSkills & Skills.getValue("Melee 2").longValue()) > 0L) damageBounus += 2;
    if ((this.humanSkills & Skills.getValue("Melee 3").longValue()) > 0L) damageBounus += 2;
    if ((this.humanSkills & Skills.getValue("Melee 4").longValue()) > 0L) damageBounus += 2;
    if ((this.humanSkills & Skills.getValue("Melee 5").longValue()) > 0L) damageBounus += 3;

    if ((this.skillsUsed.contains("Goliath")) && ((this.humanSkills & Skills.getValue("Melee 5").longValue()) > 0L))
    {
      apIncrement = 2;
      usingGoliath = true;
    }

    double attackChance = Skills.calculateAttackChance(missile.getItemtype().getAccuracy(), attackLevel, defender.getDodgeLevel());
    if (Math.random() < attackChance)
    {
      int damage = missile.getItemtype().getDamage() + Math.round(damageBounus / 2F);

      CombatResult result = defender.hit(this, damage, 'p', conn, true);
      StringBuilder ret = new StringBuilder(new StringBuilder().append("You hurl your  ").append(missile.getItemtype().getName()).append(" at ").append(defender.getName()).toString());
      ret.append(new StringBuilder().append(" and deal ").append(result.getDamageDone()).append(" points of damage.").toString());
      if (result.getArmorSoak() > 0)
        ret.append(new StringBuilder().append(" Your victim's armor soaked ").append(result.getArmorSoak()).append(" points.").toString());
      if (result.getShieldSoak() > 0) {
        ret.append(new StringBuilder().append(" Your victim's shields soaked ").append(result.getShieldSoak()).append(" points.").toString());
      }
      ret.append(applyXpGain(defender, result));
      new Message(conn, this.id, 0, ret.toString());
      for (String msg : result.getAttackerMessages()) {
        new Message(conn, this.id, 0, msg);
      }
      update(conn);

      if (usingGoliath)
      {
        defender.setStunned(System.currentTimeMillis() + 4000L);
      }

    }
    else
    {
      new Message(conn, this.id, 0, new StringBuilder().append("You hurl your ").append(missile.getItemtype().getName()).append(" at ").append(defender.getName()).append(" and miss.").toString());
      defender.insertMessage(new StringBuilder().append(this.name).append(" threw a ").append(missile.getItemtype().getName()).append(" at you and missed.").toString(), 0, conn);
    }
    defender.notifyAttacked(this, conn);

    decrementAp(conn, apIncrement);
    return null;
  }

  public CombatResult hit(Attacker attacker, int rawAmount, char damagetype, InvasionConnection conn, boolean updateNow)
    throws SQLException
  {
    CombatResult ret = new CombatResult(rawAmount);

    Item armor = getEquippedArmor();
    Item shield = getEquippedShield();
    if ((damagetype == 'p') && (armor != null) && (armor.getAmmoleft() > 0))
    {
      int maxSoak = (int)(0.75D * rawAmount);
      if (maxSoak > armor.getAmmoleft())
      {
        ret.setArmorSoak(armor.getAmmoleft());
        armor.setAmmoleft(0);
      }
      else
      {
        ret.setArmorSoak(maxSoak);
        armor.setAmmoleft(armor.getAmmoleft() - maxSoak);
      }
      armor.update(conn);
    }
    else if ((damagetype == 'e') && (shield != null) && (shield.getAmmoleft() > 0))
    {
      int maxSoak = (int)(0.95D * rawAmount);
      if (maxSoak > shield.getAmmoleft())
      {
        ret.setShieldSoak(shield.getAmmoleft());
        shield.setAmmoleft(0);
      }
      else
      {
        ret.setShieldSoak(maxSoak);
        shield.setAmmoleft(shield.getAmmoleft() - maxSoak);
      }
      shield.update(conn);
    }

    log.finer(new StringBuilder().append(this.name).append(" hit for ").append(ret.getDamageDone()).append(" dp by ").append(attacker.getName()).toString());
    this.hp -= ret.getDamageDone();
    this.lastHurtBy = attacker.getAttackerId();
    Stats.addChange(this.id, 4, ret.getDamageDone());
    String defenderMessage = new StringBuilder().append(attacker.getName()).append(" attacked you and dealt ").append(ret.getDamageDone()).append(" points of damage.").toString();
    if (ret.getArmorSoak() > 0) defenderMessage = new StringBuilder().append(defenderMessage).append("  Your armor soaked ").append(ret.getArmorSoak()).append(" points.").toString();
    if (ret.getShieldSoak() > 0) defenderMessage = new StringBuilder().append(defenderMessage).append("  Your shields soaked ").append(ret.getShieldSoak()).append(" points.").toString();
    insertMessage(defenderMessage, 0, conn);

    if (this.hp < 1)
    {
      kill(attacker, conn, ret);
      attacker.setReload(true);
    }
    else if (updateNow) {
      update(conn);
    }
    return ret;
  }

  public void notifyAttacked(Attacker attacker, InvasionConnection conn) {}

  public void kill(Attacker attacker, InvasionConnection conn, CombatResult result)
  {
    int deathLoc = this.location;
    this.hp = 0;
    this.ip = 0;
    this.location = Constants.DEAD_LOCATION;
    this.ap -= this.level / 2;
    this.lastHurtBy = 0;
    int killerid = -1;
    if ((attacker instanceof Alt))
    {
      killerid = attacker.getAttackerId();
    }
    update(conn);
    String query = "update alt set ticksalive=0-level where id=?";
    conn.psExecuteUpdate(query, "err", new Object[] { Integer.valueOf(this.id) });
    LocationCache.decrementChars(deathLoc);

    Stats.addChange(this.id, 10, 1);
    if ((attacker instanceof Alt))
    {
      Alt killer = (Alt)attacker;
      killer.setXp(killer.getXp() + this.level);

      int ipHit = 0;
      if ((this.race == killer.getRace()) && (this.race > 1))
      {
        ipHit = 10;
      }
      else if (this.race == 1)
      {
        ipHit = 2;
      }
      String message = new StringBuilder().append("You have landed the killing blow on ").append(this.name).append(".  You have been awarded an additional ").append(this.level).append(" XP.").toString();
      if (ipHit > 0)
      {
        message = new StringBuilder().append(message).append("  Your actions weigh on your consciousness, however (+").append(ipHit).append(" IP).").toString();
        killer.setIp(killer.getIp() + ipHit);
      }
      killer.update();
      Stats.addChange(killerid, 9, 1);

      if (result == null) {
        new Message(conn, killerid, 0, message);
      } else {
        result.getAttackerMessages().add(message);
      }

      new Message(conn, this.id, 0, new StringBuilder().append(killer.getName()).append(" has dealt you a death blow.  You feel the familiar tingle of your consciousness being uploaded.  The station maintenance bots have removed your body for recycling.  A new body will be started for you soon.").toString());

      Message.locationBroadcast(conn, deathLoc, 0, new StringBuilder().append(killer.getName()).append(" killed ").append(this.name).append("!  This weighs heavily on you...so much death.  As the maintenance bots remove the body, you briefly wonder where the recycled material will end up.").toString(), killerid);

      ActionLog.addAction(killerid, 3, this.id);
    }
    else if ((attacker instanceof Critter))
    {
      Critter killer = (Critter)attacker;
      if (attacker.getAttackerId() > 0)
      {
        Alt petmaster = (Alt)attacker;
        petmaster.setXp(petmaster.getXp() + this.level);

        int ipHit = 0;
        if ((this.race == petmaster.getRace()) && (this.race > 1))
        {
          ipHit = 10;
        }
        else if (this.race == 1)
        {
          ipHit = 2;
        }
        String message = new StringBuilder().append("Your pet, ").append(petmaster.getName()).append(" has killed ").append(this.name).append(".  You have been awarded an additional ").append(this.level).append(" XP.").toString();
        if (ipHit > 0)
        {
          message = new StringBuilder().append(message).append("  Your actions weigh on your consciousness, however (+").append(ipHit).append(" IP).").toString();
          petmaster.setIp(petmaster.getIp() + ipHit);
        }
        petmaster.update();
        Stats.addChange(petmaster.getId(), 9, 1);

        if (result == null) {
          new Message(conn, petmaster.getId(), 0, message);
        } else {
          result.getAttackerMessages().add(message);
        }
      }

      new Message(conn, this.id, 0, new StringBuilder().append(killer.getName()).append(" has thrashed you thoroughly.  You feel the familiar tingle of your consciousness being uploaded.  The station maintenance bots have removed your body for recycling.  A new body will be started for you soon.").toString());

      Message.locationBroadcast(conn, deathLoc, 0, new StringBuilder().append(killer.getName()).append(" killed ").append(this.name).append("!  It's always amusing to watch a critter tear someone else apart...until they look at you next.").toString());

      ActionLog.addAction(killer.getId(), 3, this.id);
    }
    else if (attacker == null)
    {
      new Message(conn, this.id, 1, "You have died.  You feel the familiar tingle of your consciousness being downloaded.  The station maintenance bots have removed your body for recycling.  A new body will be started for you soon.");
    }

    AltFactory.uncache(this.id);
  }

  public int getDodgeLevel()
  {
    return 0;
  }

  public void decrementHp(int damage, Attacker attacker, InvasionConnection conn, boolean updateNow)
  {
    this.hp -= damage;
    if (this.hp < 1) {
      kill(attacker, conn, null);
    }
    else if (updateNow) {
      update();
    }
  }

  public int getAttackerId()
  {
    return this.id;
  }

  public boolean isPetmaster()
  {
    return false;
  }

  public int getLocation() { return this.location; }
  public void setLocation(int location) { this.location = location; }
  public int getLocationType() { return this.locationType; }
  public void setLocationType(int locationType) { this.locationType = locationType; }
  public String getName() { return this.name; }
  public void setName(String name) { this.name = name; }
  public int getAp() { return this.ap; }
  public void setAp(int ap) { this.ap = ap; }
  public int getApmax() { return this.apmax; }
  public void setApmax(int apmax) { this.apmax = apmax; }
  public int getCp() { return this.cp; }
  public void setCp(int cp) { this.cp = cp; }
  public int getHp() { return this.hp; }
  public void setHp(int hp) { this.hp = hp; }
  public int getIp() { return this.ip; }
  public void setIp(int ip) { this.ip = ip; }
  public int getHpmax() { return this.hpmax; }
  public void setHpmax(int hpmax) { this.hpmax = hpmax; }
  public Item getEquippedWeapon() { return this.equippedWeapon; }
  public void setEquippedWeapon(Item item) { this.equippedWeapon = item; }
  public Item getEquippedArmor() { return this.equippedArmor; }
  public void setEquippedArmor(Item item) { this.equippedArmor = item; }
  public Item getEquippedShield() { return this.equippedShield; }
  public void setEquippedShield(Item item) { this.equippedShield = item; }
  public int getId() { return this.id; }
  public void setId(int id) { this.id = id; }
  public String getUsername() { return this.username; }
  public void setUsername(String username) { this.username = username; }
  public int getXp() { return this.xp; }
  public void setXp(int xp) { this.xp = xp; }
  public Faction getFaction() { return this.faction; }
  public void setFaction(Faction faction) { this.faction = faction; }
  public int getLevel() { return this.level; }
  public void setLevel(int level) { this.level = level; }
  public int getLastHurtBy() { return this.lastHurtBy; }
  public void setLastHurtBy(int lastHurtBy) { this.lastHurtBy = lastHurtBy; }
  public int getRace() { return this.race; }
  public void setRace(int race) { this.race = race; }
  public long getHumanSkills() { return this.humanSkills; }
  public void setHumanSkills(long humanSkills) { this.humanSkills = humanSkills; }
  public long getTohuSkills() { return this.tohuskills; }
  public void setTohuSkills(long tohuskills) { this.tohuskills = tohuskills; }
  public long getTikkunSkills() { return this.tikkunskills; }
  public void setTikkunSkills(long tikkunskills) { this.tikkunskills = tikkunskills; }
  public int getFirearmsAttackLevel() { return this.firearmsAttackLevel; }
  public void setFirearmsAttackLevel(int firearmsAttackLevel) { this.firearmsAttackLevel = firearmsAttackLevel; }
  public boolean getReload() { return this.reload; }
  public void setReload(boolean reload) { this.reload = reload; }
  public List<String> getSkillsUsed() { return this.skillsUsed; }
  public List<String> getClothing() { return this.clothing; }
  public void setClothing(List<String> clothing) { this.clothing = clothing; }
  public char getGender() { return this.gender; }
  public void setGender(char gender) { this.gender = gender; }
  public int getTinkererLevel() { return this.tinkererLevel; }
  public void setTinkererLevel(int tinkererLevel) { this.tinkererLevel = tinkererLevel; }
  public Effects getEffects() { return this.effects; }
  public void setEffects(Effects effects) { this.effects = effects; }
  public int getTicksalive() { return this.ticksalive; }
  public void setTicksalive(int ticksalive) { this.ticksalive = ticksalive; }
  public long getStunned() { return this.stunned; }
  public void setStunned(long stunned) { this.stunned = stunned; }
  public int getFactionrank() { return this.factionrank; }
  public void setFactionrank(int factionrank) { this.factionrank = factionrank; }
  public int getStation() { return this.station; }
  public void setStation(int station) { this.station = station; }
  public int getMeleeAttackLevel() { return this.meleeAttackLevel; }
  public void setMeleeAttackLevel(int meleeAttackLevel) { this.meleeAttackLevel = meleeAttackLevel; }
}
