import java.text.DecimalFormat;


public class RandomMap
{

    public static void main(String[] args)
    {
        for(int x = -20; x < 60; x++)
        {
            for(int y = -20; y < 60; y++)
            {
                int locType = (int)((Math.random() * 53) + 1);
                while( locType == 50 )
                {
                    locType = (int)((Math.random() * 53) + 1);
                }
                // System.out.println(Math.sqrt( Math.pow((20-x),2) + Math.pow((20-y),2) ));
                if( Math.sqrt( Math.pow((25-x),2) + Math.pow((25-y),2) ) > 18 )
                {
                    locType = 0;
                }
                System.out.println("insert into location (station, level, x, y, typeid) values ( 1337, 0, " + x + ", " + y + "," + locType + ");");

            }
        }
    }
}
