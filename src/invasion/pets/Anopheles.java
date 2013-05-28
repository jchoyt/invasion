package invasion.pets;

import invasion.dataobjects.Alt;
import invasion.dataobjects.Attacker;
import invasion.dataobjects.CombatResult;
import invasion.dataobjects.Tohu;
import invasion.util.AltFactory;
import invasion.util.DiceRoller;
import invasion.util.InvasionConnection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Anopheles extends Critter
{
  public static final String KEY = Anopheles.class.getName();
  public static final Logger log = Logger.getLogger(KEY);
  static { log.setLevel(Level.FINER); }

  protected double defenderChance = 0D;

  public Anopheles(Brood brood)
  {
    setBrood(brood);
    init();
  }

  public void init()
  {
    if (this.brood == null)
    {
      throw new RuntimeException("Can't initialize a " + KEY + " without assigning a Brood first.");
    }
    int skillLevel = 1;
    if (this.brood.getOwnerId() < 0)
    {
      skillLevel = 3;
    }
    else
    {
      Tohu petmaster = (Tohu)AltFactory.load(this.brood.getOwnerId());
      skillLevel = petmaster.getSummonerLevel();
    }

    this.ap = (10 + skillLevel * 5);
    this.apmax = (10 + skillLevel * 5);
    this.hp = (skillLevel * 7);
    this.hpmax = (skillLevel * 7);
    this.attackDamage = new DiceRoller("1d10+" + skillLevel);
    this.cost = 15;
    this.maintenanceRate = (8 + skillLevel);
    this.armor = (20 + skillLevel * skillLevel);
    this.armorMax = (20 + skillLevel * skillLevel);
    this.shield = (40 + skillLevel * skillLevel);
    this.shieldMax = (40 + skillLevel * skillLevel);
    this.name = ("Anopheles " + (int)(Math.random() * 2500.0D));
    this.typeid = 5;
    this.damageType = 'e';
    this.defenderChance = (0.05D * skillLevel);
    this.deathKnells = new String[] { "You have landed the killing blow.", "The Anopheles releases a horrendous howl of pain and collapses, dead." };

    this.summonMessages = new String[] { "The familiar swirl of light appears to your left.  It grows slowly.  As soon as it is big enough, a Anopheles steps through and immediatly binds itself to your soul.", "With a faint *pop* and a flash of dull green light, a Anopheles appears behind you, ready to do your bidding." };
  }

  public void setBroodGoals(Brood brood)
  {
    brood.setGoal(0, 2);
    brood.setGoal(1, 3);
    brood.setGoal(2, 0);
    brood.setGoal(4, 2);
    brood.setGoal(3, 4);
  }

  public void kill(Attacker attacker, InvasionConnection conn, CombatResult result)
    throws SQLException
  {
    super.kill(attacker, conn, result);
  }

  public boolean checkSummoner(Alt alt)
  {
    if (((alt instanceof Tohu)) && (((Tohu)alt).getSummonerLevel() > 0))
    {
      return true;
    }
    return false;
  }

  public double getDefenderChance() { return this.defenderChance; }
  public void setDefenderChance(double defenderChance) { this.defenderChance = defenderChance; }

  public Anopheles() {}
}
