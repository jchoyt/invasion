package invasion.dataobjects;

import invasion.util.InvasionConnection;
import org.json.JSONArray;

public abstract interface Attacker
{
  public abstract JSONArray attack(Defender paramDefender, InvasionConnection paramInvasionConnection);

  public abstract int getLocation();

  public abstract void insertMessage(String paramString, int paramInt, InvasionConnection paramInvasionConnection);

  public abstract int getAttackerId();

  public abstract void setReload(boolean paramBoolean);

  public abstract boolean getReload();

  public abstract String getName();

  public abstract Faction getFaction();
}
