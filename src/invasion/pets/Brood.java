/*
 *  Copyright 2013 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.pets;

//{{{ Imports
import invasion.bot.VasionBot;
import invasion.dataobjects.Alt;
import invasion.dataobjects.Defender;
import invasion.dataobjects.Faction;
import invasion.servlets.MoveServlet;
import invasion.util.AltFactory;
import invasion.util.Constants;
import invasion.util.DatabaseUtility;
import invasion.util.InvasionConnection;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger; //}}}

public class Brood implements PropertyChangeListener
{
    //{{{ Logging
    public static final String KEY = Brood.class.getName();
    public static final Logger log = Logger.getLogger( KEY );
    //}}}

    //{{{ Members
    public static final String PETDB = "postgres";

    public static final PropertyChangeSupport pcs = new PropertyChangeSupport( KEY );

    public static final int GOAL_SURVIVE = 0;

    public static final int GOAL_PROTECT = 1;

    public static final int GOAL_KILL_PSI = 2;
    public static final int GOAL_KILL_MUT = 3;
    public static final int GOAL_KILL_HUMAN = 4;
    public static final int PLAYER_CONTROLLED = 128;
    public static final int FERAL_TOHU = 129;
    public static final int FERAL_TIKKUN = 130;
    public static final int INVADING = 131;
    protected List<Critter> members = new ArrayList<Critter>();
    protected int ownerId = -1;
    protected int[] goals = new int[5];
    protected int location = 0;
    protected int type = 0;
    protected int id = 0;
    protected List<Defender> targetList = new ArrayList<Defender>();
    protected boolean active = true; //}}}

    //{{{ Constructors
    public Brood( int ownerId )
    {
        this.ownerId = ownerId;
        MoveServlet.pcs.addPropertyChangeListener( this );
    }

    public Brood()
    {
        MoveServlet.pcs.addPropertyChangeListener( this );
    } //}}}

    //{{{ Methods

    public void setGoal( int type, int value )
    {
        if ( ( type < 0 ) || ( type > 4 ) )
        {
            throw new RuntimeException( "Goals must be between 0 and 4, inclusive." );
        }
        this.goals[type] = value;
    }

    public boolean insert()
    {
        String query = "insert into brood (location, type, goal_survive, goal_protect, goal_killpsi,goal_killmut,goal_killhuman, owner) values (?,?,?,?,?,?,?,?)";
        InvasionConnection conn = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection( "postgres" );
            conn.setAutoCommit( false );
            conn.psExecuteUpdate( query, "Error adding new brood to the database", new Object[]
            { location, type, goals[0], goals[1], goals[2], goals[3], goals[4], ownerId} );

            query = "select max(id) as id from brood";
            rs = conn.executeQuery( query );
            rs.next();
            this.id = rs.getInt( "id" );
            conn.commit();
            return true;
        }
        catch ( SQLException e )
        {
            try
            {
                conn.rollback(); }
            catch ( Exception e2 )
            { e2.printStackTrace( System.out ); }
            log.throwing( KEY, "a useful message", e );
            return false;
        }
        finally
        {
            try
            {
                conn.commit(); }
            catch ( Exception e2 )
            { e2.printStackTrace( System.out ); }
            DatabaseUtility.close( rs );
            conn.close();
            MoveServlet.pcs.addPropertyChangeListener( this );
        }
    }

    public boolean update( InvasionConnection conn )
    {
        String query = "update brood set location=?, type=?, goal_survive=?, goal_protect=?, goal_killpsi=?, goal_killmut=?, goal_killhuman=? where id=?";
        int count = conn.psExecuteUpdate( query, "Error updating brood in the database", new Object[]
        { Integer.valueOf( this.location ), Integer.valueOf( this.type ), Integer.valueOf( this.goals[0] ), Integer.valueOf( this.goals[1] ), Integer.valueOf( this.goals[2] ), Integer.valueOf( this.goals[3] ), Integer.valueOf( this.goals[4] ), Integer.valueOf( this.id ) } );
        if ( count != 1 )
        {
            log.severe( "Brood " + this.id + " not updated.  Count was " + count );
            return false;
        }

        return true;
    }

    /**
     * Attack or move
     * @param
     * @return
     *
     */
    public void act( InvasionConnection conn, InvasionConnection pConn )
    {
        log.entering( KEY, "Brood " + this.id + " acting" );

        ResultSet rs = null;
        String query = null;
        buildTargetList( conn );
        //move feral broods if there's nothing to attack
        if ( ( this.ownerId < 1 ) && ( this.targetList.size() == 0 ) )
        {
            query = "select l.typeid, l.id from location l join location l2 on (l.station=l2.station and l.x between l2.x-1 and l2.x+1 and l.y between l2.y-1 and l2.y+1 and l.id!=l2.id) where l2.id=? order by random()";
            int oldloc = this.location;
            try
            {
                rs = pConn.psExecuteQuery( query, "Brood movmement not updated", new Object[]
                { Integer.valueOf( this.location ) } );
                while ( rs.next() )
                {
                    if ( !Constants.DISALLOWED_LOCATIONS.contains( Integer.valueOf( rs.getInt( "typeid" ) ) ) )
                    {
                        this.location = rs.getInt( "id" );
                    }
                }
                DatabaseUtility.close( rs );
                if ( update( pConn ) )
                {
                    pcs.firePropertyChange( KEY, Integer.valueOf( oldloc ), this );
                }
                else
                {
                    log.severe( "Failed to update the brood after movement.  Resyncing." );
                    List<String> list = LocationCache.verify();
                    VasionBot.announce( "Failed to update the brood after movement.  I had to resync the cache and found " + list.size() + " thing(s) wrong." );
                    for ( String s : list )
                    {
                        log.info( s );
                    }
                    return;
                }
            }
            catch ( SQLException e )
            {
                log.throwing( KEY, "a useful message", e );
                throw new RuntimeException( e );
            }
            finally
            {
                DatabaseUtility.close( rs ); } DatabaseUtility.close( rs );
        }
        // feral broods attack if new location has occupants
        if ( ( this.ownerId < 1 ) && ( LocationCache.getBroodsAtLoc( this.location ) > 1 || LocationCache.getCharactersAtLoc( this.location ) > 1 ) )
        {
            try
            {
                query = "select b.id from brood b where owner=-1 and location=? and id != ?";
                rs = pConn.psExecuteQuery( query, "Error grabbing list of feral broods to merge with", new Object[] { Integer.valueOf( this.location ), Integer.valueOf( this.id ) } );
                while ( rs.next() )
                {
                    int broodId = rs.getInt( 1 );
                    Brood b = BroodManager.getFeralBrood( broodId );
                    if ( b == null )
                    {
                        b = BroodManager.getFeralBrood( broodId );
                        BroodManager.addBrood( b );
                    }
                    // if the combined brood is not too big, merge them.  Allow some randomness so broods aren't all the same size - this allows feral broods to be 5-8 in size.
                    if ( b.members.size() + this.members.size() + Math.random() * 3.0D < 8.0D )
                    {
                        if ( b.getPowerRating() > getPowerRating() )
                        {
                            mergeInto( pConn, b );
                        }
                        else
                        {
                            b.mergeInto( pConn, this );
                        }
                    }
                    else
                    {
                        log.finer( "Not merging broods " + this.id + " and " + b.id + " because the size would be " + ( b.members.size() + this.members.size() ) );
                    }
                }
                DatabaseUtility.close( rs );
            }
            catch ( SQLException e )
            {
                log.throwing( KEY, "a useful message", e );
                throw new RuntimeException( e );
            }
            finally
            {
                DatabaseUtility.close( rs );
            }
        }

        buildTargetList( conn );

        log.exiting( KEY, "act" );
    }

    public void attack( InvasionConnection conn )
    {
        buildTargetList( conn );
        log.finer( "Brood " + this.id + " preparing to attack - there are " + this.targetList.size() + " targets." );
        int randomTarget = -1;
        for ( Critter c : this.members )
        {
            randomTarget = ( int ) ( Math.random() * this.targetList.size() );
            Defender target = ( Defender ) this.targetList.get( randomTarget );
            c.attack( target, conn );
        }
    }

    public void buildTargetList( InvasionConnection conn )
    {
        this.targetList.clear();

        String query = "select id from alt where location = ? and ticksalive > 0";

        ResultSet rs = null;
        try
        {
            if ( ( LocationCache.getCharactersAtLoc( this.location ) > 1 ) || ( ( LocationCache.getCharactersAtLoc( this.location ) > 0 ) && ( this.ownerId < 1 ) ) )
            {
                log.finer( "Checking for targets for brood " + this.id + " at location " + this.location );
                rs = conn.psExecuteQuery( query, "Error", new Object[]
                { Integer.valueOf( this.location ) } );
                while ( rs.next() )
                {
                    this.targetList.add( AltFactory.load( conn, rs.getInt( "id" ) ) );
                    log.finer( "Adding a target to the list for brood " + this.id );
                }
                DatabaseUtility.close( rs );
            }

        }
        catch ( SQLException e )
        {
            log.throwing( KEY, "a useful message", e );
            throw new RuntimeException( e );
        }
        finally
        {
            DatabaseUtility.close( rs );
            if ( this.targetList.size() == 0 )
            {
                this.active = false;
            }
            else
            {
                this.active = true;
            }
        }
    }

    public void mergeInto( InvasionConnection conn, Brood b )
    {
        b.getMembers().addAll( this.members );
        String query = "update critters set brood = ?  where brood = ?";
        conn.psExecuteUpdate( query, "Failure merging broods", new Object[]
        { Integer.valueOf( b.getId() ), Integer.valueOf( this.id ) } );
        delete( conn );
        this.members = new ArrayList<Critter>();
    }

    protected boolean delete( InvasionConnection conn )
    {
        BroodManager.removeBrood( this );
        String query = "delete from brood where id=?";
        return 1 == conn.psExecuteUpdate( query, "Deleting merged brood", new Object[]
        { Integer.valueOf( this.id ) } );
    }

    public void addMember( Critter newCritter )
    {
        this.members.add( newCritter );
    }

    public void removeMember( Critter oldCritter, InvasionConnection conn )
    {
        this.members.remove( oldCritter );
        if ( this.members.size() == 0 )
        {
            MoveServlet.pcs.removePropertyChangeListener( this );

            String query = "delete from brood where id=" + this.id;
            try
            {
                conn.executeUpdate( query );
            }
            catch ( SQLException e )
            {
                log.throwing( KEY, "Failed to remove brood " + this.id + " from the database.", e );
                throw new RuntimeException( e );
            }

            BroodManager.removeBrood( this );
        }
    }

    public int getPowerRating()
    {
        return this.members.size();
    }

    public boolean equals( Object o )
    {
        if ( ( o instanceof Brood ) )
        {
            return this.id == ( ( Brood ) o ).getId();
        }
        return false;
    }

    public int hashcode( Object o )
    {
        return this.id;
    }

    public int getFactionId()
    {
        if ( this.ownerId == -1 )
        {
            return -1;
        }

        Alt owner = AltFactory.load( this.ownerId );
        if ( owner.getFaction() == null )
        {
            return -1;
        }

        return owner.getFaction().getId();
    }

    public Alt getPetmaster( InvasionConnection conn )
    {
        if ( this.ownerId == -1 )
        {
            return null;
        }
        return AltFactory.load( conn, this.ownerId );
    }
    //}}}

    //{{{ For PropertyChangeListener interface

    public void propertyChange( PropertyChangeEvent evt )
    {
        //check if something has moved into this brood's locationo, if so, activate it
        if ( evt.getPropertyName().equals( "MoveServlet" ) )
        {
            Integer i = ( Integer ) evt.getNewValue();
            if ( this.location == i.intValue() )
            {
                this.active = true;
            }
        }
    } //}}}

    //{{{ Setters and getters
    public List<Critter> getMembers() { return this.members; }
    public void setMembers( List<Critter> members ) { this.members = members; }
    public int getOwnerId() { return this.ownerId; }
    public void setOwnerId( int ownerId ){ this.ownerId = ownerId; }
    public int[] getGoals()    { return this.goals; }
    public void setGoals( int[] goals )    { this.goals = goals; }
    public int getLocation()    { return this.location; }
    public void setLocation( int location )    { this.location = location; }
    public int getType()    { return this.type; }
    public void setType( int type )    { this.type = type; }
    public int getId()    { return this.id; }
    public void setId( int id )    { this.id = id; }
    public List<Defender> getTargetList()    { return this.targetList; }
    public void setTargetList( List<Defender> targetList )    { this.targetList = targetList; }
    public boolean getActive()    { return this.active; }
    public void setActive( boolean active )    { this.active = active; }
    public int getSize()    { return this.members.size(); } //}}}

}
