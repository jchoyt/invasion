package invasion;

import java.util.logging.Level;
import java.io.*;
import java.util.logging.Logger;
import java.sql.*;
import invasion.util.*;
import org.json.*;


public class StatProcess
{
    public static void main(String[] args)throws Exception
    {
        BufferedReader reader = new BufferedReader(new FileReader("stats.test"));
        String line = "";
        String query = "update stats set count=count+? where altid=? and statid=?";
        Connection conn = DriverManager.getConnection("jdbc:postgresql:invasion", "jchoyt", "ou812ic");
        long start = System.currentTimeMillis();
        PreparedStatement ps = conn.prepareStatement(query);
        while((line=reader.readLine())!=null)
        {
            String[] parts = line.split("\t");
            ps.setInt(1, Integer.parseInt(parts[2]));
            ps.setInt(2, Integer.parseInt(parts[0]));
            ps.setInt(3, Integer.parseInt(parts[1]));
            ps.addBatch();
        }
        ps.executeBatch();
        System.out.println( System.currentTimeMillis() - start );
        ps.close();
        conn.close();
    }

}
