package invasion.pets;

import invasion.dataobjects.Alt;
import invasion.dataobjects.Attacker;
import invasion.dataobjects.CombatResult;
import invasion.dataobjects.Message;
import invasion.dataobjects.Station;
import invasion.util.DiceRoller;
import invasion.util.InvasionConnection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CatBot extends Critter
{
  public static final String KEY = CatBot.class.getName();
  public static final Logger log = Logger.getLogger(KEY);
  static { log.setLevel(Level.FINER); }

  public CatBot(Brood brood)
  {
    if (brood == null)
    {
      throw new RuntimeException("Can't create a new CatBot in a non-existant brood");
    }
    setBrood(brood);
    init();
  }

  public CatBot(int station)
  {
    Brood b = new Brood(-1);
    b.addMember(this);
    b.setLocation(Station.getRandomLocation(station));
    setBroodGoals(b);
    b.setType(131);
    if (!b.insert())
    {
      log.warning("Brood not inserted.");
    }
    BroodManager.addBrood(b);

    setBrood(b);
    init();
    insert();
    log.finer("Finished creating CatBot " + this.id + " at location " + b.getLocation());
  }

  public void init()
  {
    this.ap = 75;
    this.apmax = 75;
    this.hp = 20;
    this.hpmax = 20;
    this.attackDamage = new DiceRoller("2d5");
    this.cost = -1;
    this.armor = 15;
    this.armorMax = 15;
    this.shield = 15;
    this.shieldMax = 15;
    this.name = ("CatBot " + (int)(Math.random() * 2500.0D));
    this.typeid = 2;
    this.damageType = 'p';
    if (Math.random() < 0.01D) this.name = "All Hail Mistress Cy!";
    this.deathKnells = new String[] { "You have landed the killing blow.", "Its last, loud screach of pain echo through the area. You feel kinda bad now." };
  }

  public void setBroodGoals(Brood brood)
  {
    brood.setGoal(0, 2);
    brood.setGoal(1, 1);
    brood.setGoal(2, 5);
    brood.setGoal(4, 5);
    brood.setGoal(3, 5);
  }

  public void kill(Attacker attacker, InvasionConnection conn, CombatResult result)
    throws SQLException
  {
    super.kill(attacker, conn, result);
    if (Math.random() < 0.1D)
    {
      Message.locationBroadcast(conn, this.location, 4, "You watch in horror as the larger CatBot bits start to twitch and shuffle towards one another.They reassemble into smaller versions of the parent bot and stand up to join their bretheren.  MEOW!");

      for (int i = 0; i < 6; i++)
      {
        new CatBot(this.brood);
      }
    }
  }

  public boolean checkSummoner(Alt alt)
  {
    return false;
  }

  public int getId()
  {
    return -1;
  }

  public CatBot() {}
}
