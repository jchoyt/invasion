package invasion.dataobjects;

class ActionRecord
{
  protected int actor = 0;
  protected int action = 0;
  protected int subject = 0;
  protected long timestamp = System.currentTimeMillis();

  public ActionRecord(int actor, int action, int subject)
  {
    this.actor = actor;
    this.action = action;
    this.subject = subject;
  }

  public String toString()
  {
    return "insert into actionlog (actor, action, subject, time) values ( " + this.actor + "," + this.action + "," + this.subject + "," + this.timestamp + ")";
  }

  public int getActor() { return this.actor; }
  public void setActor(int actor) { this.actor = actor; }
  public int getAction() { return this.action; }
  public void setAction(int action) { this.action = action; }
  public int getSubject() { return this.subject; }
  public void setSubject(int subject) { this.subject = subject; }
  public long getTimestamp() { return this.timestamp; }
  public void setTimestamp(long timestamp) { this.timestamp = timestamp; }
}
