import org.hibernate.*;
import org.hibernate.cfg.Configuration;
import org.hibernate.Session;
import java.util.*;
import org.invasion.dataobjects.*;

public class Test
{


    public static void main(String args[]) throws Exception
    {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
         Transaction tx=null;
         try {
             tx = session.beginTransaction();

                int loc = Integer.parseInt(args[0]);
                int row = loc;
                int min,max;
                List<Location> all = new ArrayList<Location>();
                String query = "from Location where id > ? and id < ?";
                for(int y = -2; y < 3; y++)
                {
                    row = loc + y * 1000;
                    min = row - 3;  //using +/- 3 since the query is < and >
                    max = row + 3;
                    List<Location> tiles = session.createQuery( query )
                        .setInteger(0, min)
                        .setInteger(1, max)
                        .list();
                    all.addAll(tiles);

                }
                for(Location l : all)
                {
                    System.out.println(l.getId() + "|" + String.valueOf(l.getLocationtype().getName()));
                }
             tx.commit();
         }
         catch (Exception e) {
             if (tx!=null) tx.rollback();
             throw e;
         }
    }
}

class HibernateUtil {

    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            // Create the SessionFactory from hibernate.cfg.xml
            return new Configuration().configure().buildSessionFactory();
        }
        catch (Throwable ex) {
            // Make sure you log the exception, as it might be swallowed
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

}
