package invasion.util;

import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
import org.json.*;

import java.util.*;

public class Search
{
    public final static String KEY = Search.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    //static{log.setLevel(Level.FINER);}

    static Map<Integer, List<SearchDistribution>> lookups = new HashMap<Integer, List<SearchDistribution>>();

    public static void load()
    {

        String query = "select * from searchodds order by locationtype;";
        InvasionConnection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            conn = new InvasionConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            int curLocid = -1;
            int locid=0;
            List<SearchDistribution> dist = new ArrayList<SearchDistribution>();
            while(rs.next())
            {
                locid = rs.getInt("locationtype");
                if( curLocid != locid )
                {
                    Collections.sort(dist);
                    SearchDistribution.normalize(dist);
                    lookups.put(new Integer(curLocid), dist);
                    dist = new ArrayList<SearchDistribution>();
                    curLocid = locid;
                }
                dist.add( new SearchDistribution( rs.getInt("return"), rs.getDouble("odds") ) );
            }
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
        }
        catch(SQLException e)
        {
            log.throwing( KEY, "a useful message", e);
            throw new RuntimeException(e);
        }
        finally
        {
            DatabaseUtility.close(rs);
            DatabaseUtility.close(ps);
            conn.close();
        }
    }

    public static synchronized int performSearch( int type )
    {
        //Check to see if it passes the locatoin % first

        List<SearchDistribution> dist = lookups.get(type);
        SearchDistribution probe = new SearchDistribution(Math.random());
        /*
         * This looks completely stupid, but there is sanity here.  I've set the "equals()" method in SearchDistribution so that if the value of probe is between
         * lowerbound and upperbound it comes back true.  Not sure how to create a decent value of hashCode for this, though, so that's not done.
         */
        int chosen = dist.indexOf( probe );
        return dist.get(chosen).getItemid();
    }


    /**
     *  Utility class to carry around search configuration.  Sorts so the most common item comes first.
     */
    static class SearchDistribution implements Comparable<SearchDistribution>
    {
        public final static String KEY = SearchDistribution.class.getName();
        public final static Logger log = Logger.getLogger( KEY );
        static{log.setLevel(Level.FINER);}
        double lowerbound;
        double upperbound;
        double rate;
        double probe;
        int itemid;

        public SearchDistribution( int itemid, double rate )
        {
            this.rate = rate;
            this.itemid = itemid;
            probe = -1;
        }

        public SearchDistribution( double probe )
        {
            this.probe = probe;
        }


        /**
         *  sort so most common search item comes first
         */
        public int compareTo(SearchDistribution o)
        {
            return (int)(10000*(o.rate - rate));
        }

        public double calculateBounds( double newLowerBound )
        {
            this.lowerbound = newLowerBound;
            this.upperbound = lowerbound + rate;
            return upperbound;
        }

        public static void normalize(List<SearchDistribution> list)
        {
            double sum = 0;
            for(SearchDistribution d : list)
            {
                sum += d.rate;
            }
            log.info( "Sum is " + sum );
            double scalingFactor = 1/sum;
            for(SearchDistribution d : list)
            {
                d.rate = d.rate * scalingFactor;
            }
        }

        public boolean equals( Object o )
        {
            if( o==null || !(o instanceof SearchDistribution))
            {
                return false;
            }
            return equals((SearchDistribution) o);
        }

        public boolean equals( SearchDistribution d )
        {
            if( d.probe == -1 )
            {
                return false;
            }
            return ( d.probe >= lowerbound && d.probe < upperbound );
        }

        public int getItemid()
        {
            return itemid;
        }


        /*
        public int hashCode()
        {
            //TODO not sure how to implement this....
        }
        */
    }


}


