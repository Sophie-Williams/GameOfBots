
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
        
        //turn execution
        if(pMessage.equals("ET"))
            turnExecution = true;
        
        /*
         * Cell Update.
         * Format is "CU" + x-coordinate + y-coordinate (2 digits per coordinate)
         * the data is then stored in a stack/queue (doesn't really matter I think) containing cellUpdate classes
         * (Ich hab zuhause keinen zugriff auf die abiturklassen)
         * the game reads that stack and updates the board accordingly
         */
        int tempx,tempy,tempcolour;
        if(pMessage.substring(0,1).equals("CU"))
        {
            tempx = (Character.getNumericValue(pMessage.charAt(2))*10)+(Character.getNumericValue(pMessage.charAt(3)));
            tempy = (Character.getNumericValue(pMessage.charAt(4))*10)+(Character.getNumericValue(pMessage.charAt(5)));
            tempcolour = Character.getNumericValue(pMessage.charAt(6));
            updateTodo.enqueue(new cellUpdate(tempx, tempy, tempcolour));
        }
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
