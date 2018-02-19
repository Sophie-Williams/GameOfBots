
/**
 * Beschreiben Sie hier die Klasse GoBServer.
 * 
 * @author (Ihr Name) 
 * @version (eine Versionsnummer oder ein Datum)
 */
public class GoBServer extends Server
{
    // Instanzvariablen - ersetzen Sie das folgende Beispiel mit Ihren Variablen
    String[] IdToIP = new String[6];
    int[] IdToPort = new int[6];
    int[] IdToColour = new int[6];
    int readyGamePlayers = 0;
    boolean game = false;
    int readyTurnPlayers = 0;
    
    /**
     * Konstruktor für Objekte der Klasse GoBServer
     */
    public GoBServer()
    {
        super(6666);
        for(int j=0;j<6;j++){
            IdToIP[j] = "-1";
            IdToPort[j] = -1;
        }
    }
    
    /*
     * is eventually going to replace the player with a bot
     */
    public void processClosingConnection(String string, int i){}
    
    /*
     * the clients only send when a player places a live cell; that information then only needs to be distributed
     * to the other clients
     */
    public void processMessage(String stringa, int i, String stringb){
        //Game Start
        if(stringb.substring(0,1).equals("GS"))
        {
            if(stringb.charAt(2) == '0')
            {
                //as a client has signaled it is ready, the count of ready players is increased by one
                readyGamePlayers++;
                
                //If all players are ready, the server considers the game to be started. TBI.
                if(readyGamePlayers == 6)
                {
                    game = true;
                }
            }
            
            /*
             * forces the game start, regardless of how many players are ready. will fill remaining colours
             * with bots in the future.
             */
            else if(stringb.charAt(2) == 'F')
            {
                //This is gonna assign bots to the unclaimed colours in the future
            }
        }
        
        //Next Turn
        if(stringb.substring(0,1).equals("NT"))
        {
            if(stringb.charAt(2) == '0')
            {
                //as a client has signaled it is ready, the count of ready players is increased by one
                readyTurnPlayers++;
                
                //If all players are ready, the server tells the clients to execute the turn
                if(readyTurnPlayers == 6)
                {
                    sendToAll("ET");
                }
            }
            
            //forces a turn, regardless of how many players are ready
            else if(stringb.charAt(2) == 'F')
                sendToAll("ET");
        }
        
        /*
         * Cell Update. The information about which cell was changed to which state is read in the clients;
         * the server just distributes the data.
         */
        if(stringb.substring(0,1).equals("CU"))
        {
            sendToAll(stringb);
        }
    }
    
    /*
     * saves the client IDs and ports to arrays, to be assigned colours when the game starts
     */
    public void processNewConnection(String string, int i){
        for(int k=0;i<6;i++){
            if(IdToIP[k].equals("-1")){
                IdToIP[k] = string;
                IdToPort[k] = i;
            }
        }
    }
}
