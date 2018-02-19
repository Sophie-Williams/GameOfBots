
/**
 * Write a description of class GoBClient here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class GoBClient extends Client
{
    // instance variables - replace the example below with your own
    boolean turnExecution = false;
    boolean game = false;
    int colour = -1;
    Queue<cellUpdate> updateTodo;

    /**
     * Constructor for objects of class GoBClient
     */
    public GoBClient()
    {
        super("127.0.0.1", 6666);
    }

    public void processMessage(String pMessage){
        //still have to think about how to do the game start
        if(pMessage.substring(0,1).equals("GS"))
        {
            colour = Character.getNumericValue(pMessage.charAt(2));
            game = true;
        }
        
        //turn execution
        if(pMessage.equals("ET"))
            turnExecution = true;
        
        /*
         * Cell Update.
         * Format is "CU" + x-coordinate + y-coordinate + colour(3 digits per coordinate, colour is a single digit)
         * the data is then stored in a stack/queue (doesn't really matter I think) containing cellUpdate classes
         * (Ich hab zuhause keinen zugriff auf die abiturklassen)
         * the game reads that stack and updates the board accordingly
         */
        int tempx,tempy,tempcolour;
        if(pMessage.substring(0,1).equals("CU"))
        {
            tempx = (Character.getNumericValue(pMessage.charAt(2))*100)+(Character.getNumericValue(pMessage.charAt(3))*10)+(Character.getNumericValue(pMessage.charAt(4)));
            tempy = (Character.getNumericValue(pMessage.charAt(5))*100)+(Character.getNumericValue(pMessage.charAt(6))*10)+(Character.getNumericValue(pMessage.charAt(7)));
            tempcolour = Character.getNumericValue(pMessage.charAt(8));
            updateTodo.enqueue(new cellUpdate(tempx, tempy, tempcolour));
        }
    }
    
    /*
     * send the server a cellupdate for distribution
     */
    public void cellUpdate(int x, int y, int c){
        if(100>x && x>-1 && 100>y && y>-1 && c<6 && c>-1)
            send("CU" + x + y + c);
    }
    
    /*
     * signals the server that this player is done with their turn. if forced is set to true, the next turn
     * is executed regardless of the other players' status.
     */
    public void readyTurn(boolean forced)
    {
        if(forced == true)
            send("NTF");
        else if (forced == false)
            send("NT0");
    }
}
