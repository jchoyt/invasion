/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */

package invasion.util;

import java.util.*;
import java.util.logging.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import invasion.dataobjects.*;
import org.json.*;

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
                    if( dist.size() > 0 )
                    {
                        Collections.sort(dist);
                        SearchDistribution.normalize(dist);
                        lookups.put(new Integer(curLocid), dist);
                    }
                    dist = new ArrayList<SearchDistribution>();
                    curLocid = locid;
                }
                dist.add( new SearchDistribution( rs.getInt("return"), rs.getDouble("odds") ) );
            }
            if( dist.size() > 0 )
            {
                Collections.sort(dist);
                SearchDistribution.normalize(dist);
                lookups.put(new Integer(curLocid), dist);
            }
            log.info("Loaded " + lookups.size() + " different item types.");
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
        //TODO remove this once searchodds are worked out
        type = 2;
        //Check to see if it passes the locatoin % first
        double rate = LocationType.getLocationType(type).getSearchrate();
        if( Math.random() > rate )
        {
            return -1;
        }
        //found something.  Now figure out what it is.
        List<SearchDistribution> dist = lookups.get(type);
        SearchDistribution probe = new SearchDistribution(Math.random());

        //find the corresponding item
        for( SearchDistribution s : dist )
        {
            if( s.equals( probe ) )
            {
                return s.getItemid();
            }
        }
        throw new RuntimeException("If the code reaches this point, then the SearchDistribution lists were not set up correctly, or the methodology for calculating the search was botched.");
    }


    /**
     *  Utility class to carry around search configuration.  Sorts so the most common item comes first.
     */
    static class SearchDistribution implements Comparable<SearchDistribution>
    {
        public final static String KEY = SearchDistribution.class.getName();
        public final static Logger log = Logger.getLogger( KEY );
        // static{log.setLevel(Level.FINER);}
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
            double nextLowerBound = 0.0;
            double sum = 0.0;
            for(SearchDistribution d : list)
            {
                sum += d.rate;
            }
            log.info( "Sum is " + sum );
            double scalingFactor = 1/sum;
            for(SearchDistribution d : list)
            {
                d.rate = d.rate * scalingFactor;
                nextLowerBound = d.calculateBounds( nextLowerBound );
                log.finer("Next lower bound is:" + nextLowerBound);
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


