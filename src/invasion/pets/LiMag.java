package invasion.pets;

import invasion.dataobjects.Alt;
import invasion.dataobjects.Station;
import invasion.util.DiceRoller;
import java.util.logging.Logger;

public class LiMag
  extends Critter
{
  public static final String KEY = LiMag.class.getName();
  public static final Logger log = Logger.getLogger(KEY);

  public LiMag() {}

  public LiMag(Brood brood)
  {
    if (brood == null)
    {
      throw new RuntimeException("Can't create a new LiMag in a non-existant brood");
    }
    setBrood(brood);
    init();
  }

  public LiMag(int station)
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
    log.finer("Finished creating LiMag " + this.id + " at location " + b.getLocation());
  }

  public void init()
  {
    this.ap = 75;
    this.apmax = 75;
    this.hp = 50;
    this.hpmax = 50;
    this.attackDamage = new DiceRoller("4d7");
    this.cost = -1;
    this.armor = 120;
    this.armorMax = 120;
    this.shield = 120;
    this.shieldMax = 120;
    this.name = ("LiMag " + (int)(Math.random() * 2500.0D));
    this.typeid = 1;
    this.damageType = 'e';
    if (Math.random() < 0.01D) this.name = "I blame Player_1";
    this.deathKnells = new String[] { "You have landed the killing blow.", "With a final blow, the lights on the LiMag slowly dim.", "Sparks fly from your target's caraprice and it finally lies motionless.", "You yell, \"Holy crap! Did you see that shot?!??  Did you?\"  Oh. Yeah. There's nobody else here. You are forever alone." };
  }

  public void setBroodGoals(Brood brood)
  {
    brood.setGoal(0, 2);
    brood.setGoal(1, 1);
    brood.setGoal(2, 5);
    brood.setGoal(4, 5);
    brood.setGoal(3, 5);
  }

  public boolean checkSummoner(Alt alt)
  {
    return false;
  }

  public int getId()
  {
    return -1;
  }
}
