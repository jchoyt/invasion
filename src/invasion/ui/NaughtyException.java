package invasion.ui;

/**
 *  Used when it looks like someone is doing something they shouldn't be doing
 */
public class NaughtyException extends RuntimeException
{

    public NaughtyException(Exception e)
    {
        super(e);
    }

    public NaughtyException(String message)
    {
        super(message);
    }

}
