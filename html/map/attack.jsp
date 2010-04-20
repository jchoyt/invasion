<%@ page import="invasion.util.*, invasion.ui.*, java.sql.*, invasion.dataobjects.*, java.util.logging.*,org.json.*" %><%!
    public final static String KEY = "/map/attack.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}%><%

    // response.setHeader( "Content-Type", "application/json; charset=\"ISO-8859-1\"" );
    String target = WebUtils.getRequiredParameter(request, "target");
    int targetid = Integer.parseInt(target);
    String targetName = null;
    Whatzit wazzit =(Whatzit) session.getAttribute(Whatzit.KEY);
    if( wazzit == null )
    {  //nobody is logged in
        response.sendRedirect("/index.jsp");
        return;
    }
    int apIncrement = 1;
    wazzit.setLastTarget( targetid );
    JSONArray alerts = null;
    InvasionConnection conn = null;
    try
    {
        conn = new InvasionConnection();
        String query;

        //check to see if the target is still in the area
        query = "select * from alt t where id=? and location=(select location from alt a where id=?)";
        ResultSet rs = conn.psExecuteQuery( query, "Error checking location of target", wazzit.getAlt().getId(), targetid);
        if(rs.next())
        {
            targetName = rs.getString("name");
        }
        else
        {
            //target left
            alerts = new JSONArray();
            alerts.put( Poll.createErrorAlert("Your target is no longer in the area.") );
            return;
        }


        //check to see if a weapon is equipped
        ItemType weaponClass = ItemType.getItemType( wazzit.getEquippedWeaponTypeId() );
        if( weaponClass == null )
        {
            //no weapon equipped.
            alerts = new JSONArray();
            alerts.put( Poll.createErrorAlert("You must equip a weapon before attacking with it.") );
            return;
        }
        String weaponName = weaponClass.getName();
        int rawDamageAmt = weaponClass.getDamage();

        if(wazzit.getAmmoModNeeded())
        {
            //check if char has ammo
            if( wazzit.getAmmo() == 0 )
            {
                alerts = new JSONArray();
                alerts.put( Poll.createErrorAlert("There is no ammunition left in that weapon.") );
                return;
            }
            wazzit.decrementAmmo();
            //check if reload necessary
            if( wazzit.getAmmo() == 0 )
            {
                //TODO:  check for ammo
                log.finer("reloading");
                int capacity = ItemType.getItemType( wazzit.getEquippedWeaponTypeId() ).getCapacity();
                query = "update item i set ammoleft=? where itemid=?";
                wazzit.setAmmo( capacity );
                int count = conn.psExecuteUpdate( query, "Error occured updating ammunition.", capacity, wazzit.getEquippedWeaponId() );
                new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "Your weapon is out of ammunition.  You reload your weapon." );
                apIncrement++;
            } else {
                log.finer("decrementing ammo");
                query = "update item set ammoleft=ammoleft-1 where itemid=?";
                int count = conn.psExecuteUpdate( query, "Error occured updating ammunition.", wazzit.getEquippedWeaponId() );
            }
        }

        // check if you hit
        if( Math.random() < 0.25 )
        {
            //hit
            //TODO soaks
            new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You attack " + wazzit.getLastTarget().getName() + " with your "  + weaponName + " and deal "+rawDamageAmt+" points of damage.  You earned "+rawDamageAmt+" XP.");
            new Message( conn, targetid, Message.NORMAL, wazzit.getAlt().getName() + " attacked you with a "  + weaponName + " and dealt "+rawDamageAmt+" points of damage.");

            //X was absorbed by armor
            //Y was absorbed by shields
            //You gain Z XP.

            query = "update alt set hp = hp-?, lasthurtby=? where id=?;update alt set xp=xp+? where id=?";
            conn.psExecuteUpdate( query, "Error occurred while updating your victim's HP", rawDamageAmt, wazzit.getAlt().getId(), targetid, rawDamageAmt, wazzit.getAlt().getId() );
            query = "select id from alt where hp < 1 and id=?";
            rs = conn.psExecuteQuery( query, "Error occurred while updating your victim's HP", targetid );
            if( rs.next() )
            {
                System.out.println( " He's dead!");
                Alt.kill( conn, targetid );
            }
            Stats.addChange(wazzit.getAlt().getId(), Stats.DAMDONE, rawDamageAmt);
            Stats.addChange(targetid, Stats.DAMTAKEN, rawDamageAmt);
            DatabaseUtility.close(rs);
        }
        else
        {
            //miss
            new Message( conn, wazzit.getAlt().getId(), Message.NORMAL, "You attack " + wazzit.getLastTarget().getName() + " with your "  + weaponName + " and miss.");
            new Message( conn, targetid, Message.NORMAL, wazzit.getAlt().getName() + " attacked you with a "  + weaponName + " and missed.");
        }

        wazzit.getAlt().decrementAp(conn, apIncrement);
    }
    catch (Exception e)
    {
        log.throwing(KEY, "body", e);
        alerts = new JSONArray();
        alerts.put( Poll.createErrorAlert(e.getMessage()) );
    }
    finally
    {
        Poll.fullPoll( conn, out, wazzit, alerts );
        conn.close();
    }
%>

