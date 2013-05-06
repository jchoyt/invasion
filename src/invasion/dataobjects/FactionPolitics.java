package invasion.dataobjects;

import invasion.util.DatabaseUtility;
import invasion.util.InvasionConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

public enum FactionPolitics
{
  SAME("fc-faction"),
  ENEMY("fc-enemy"),
  HOSTILE("fc-hostile"),
  NEUTRAL("fc-neutral"),
  FRIEND("fc-friend"),
  ALLY("fc-ally");

  private FactionPolitics(String cssClass)
  {
    this.cssClass = cssClass;
  }

  public static final String KEY = FactionPolitics.class.getName();
  public static final Logger log = Logger.getLogger(KEY);

  protected String cssClass;

  protected static Map<String, Integer> politics = new HashMap();

  public static FactionPolitics getPolitics(int viewingFactionId, int viewedFactionId)
  {
    int relationship = getSetting(viewingFactionId, viewedFactionId);
    int reverseRelationship = getSetting(viewedFactionId, viewingFactionId);

    if (viewedFactionId == viewingFactionId)
    {
      return SAME;
    }

    switch (relationship) {
    case 2:
      if (reverseRelationship == 2) {
        return ALLY;
      }
      return FRIEND;
    case 0:
      if (reverseRelationship == 0) {
        return ENEMY;
      }
      return HOSTILE;
    }
    return NEUTRAL;
  }

  protected static int getSetting(int viewingFactionId, int viewedFactionId)
  {
    String key = viewingFactionId + "-" + viewedFactionId;
    Integer setting = (Integer)politics.get(key);
    if (setting == null)
    {
      return 1;
    }
    return setting.intValue();
  }

  public static void loadPolitics()
  {
    String query = "select setter || '-' || target as key, setting from politics where setting !=1";
    InvasionConnection conn = null;
    ResultSet rs = null;
    try
    {
      conn = new InvasionConnection();
      rs = conn.executeQuery(query);
      while (rs.next())
      {
        politics.put(rs.getString("key"), Integer.valueOf(rs.getInt("setting")));
      }
    }
    catch (SQLException e)
    {
      log.throwing(KEY, "Massive problem - error loading the FactionPolitics ", e);
      throw new RuntimeException(e);
    }
    finally
    {
      DatabaseUtility.close(rs);
      conn.close();
    }
  }

  public String getCssClass() { return this.cssClass; }
  public void setCssClass(String cssClass) { this.cssClass = cssClass; }
}
