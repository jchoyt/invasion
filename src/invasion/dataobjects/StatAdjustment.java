package invasion.dataobjects;

public class StatAdjustment
{
  protected int altid = 0;
  protected int statid = 0;
  protected int adjustment = 0;

  public StatAdjustment(int altid, int statid, int adjustment) {
    this.altid = altid;
    this.statid = statid;
    this.adjustment = adjustment;
  }

  public String toString()
  {
    return "update stats set count=count+" + this.adjustment + " where altid=" + this.altid + " and statid=" + this.statid;
  }

  public int getAltid() { return this.altid; }
  public void setAltid(int altid) { this.altid = altid; }
  public int getStatid() { return this.statid; }
  public void setStatid(int statid) { this.statid = statid; }
  public int getAdjustment() { return this.adjustment; }
  public void setAdjustment(int adjustment) { this.adjustment = adjustment; }
}
