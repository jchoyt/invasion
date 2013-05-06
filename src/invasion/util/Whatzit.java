package invasion.util;

import invasion.dataobjects.Alt;
import invasion.ui.GuiConfig;
import java.util.logging.Logger;

public class Whatzit
{
  public static final String KEY = Whatzit.class.getName();
  public static final Logger log = Logger.getLogger(KEY);

  protected int currentAltId = 0;
  protected GuiConfig gui = null;

  public Whatzit(int loggedInAltId)
  {
    this.currentAltId = loggedInAltId;
  }

  public Alt getAlt()
  {
    return AltFactory.load(this.currentAltId);
  }

  public int getCurrentAltId() { return this.currentAltId; }
  public void setCurrentAltId(int currentAltId) { this.currentAltId = currentAltId; }
  public GuiConfig getGui() { return this.gui; }
  public void setGui(GuiConfig gui) { this.gui = gui; }
}

