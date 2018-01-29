import java.util.Arrays;

int size = 30;
int sizeX = 15;
int sizeY = 15;
int[][] IDs = new int[sizeX][sizeY];
boolean[] PlayersReady = new boolean[1];
boolean gameStarted = false;

ArrayList<Integer> players = new ArrayList<Integer>();
ArrayList<Integer> visitors = new ArrayList<Integer>();

String input;
int data[];

void setup() 
{
  size(828, 725);
  background(255);
  textSize(15);
  IDs = Helper.fillIDs(IDs);
  IDs[4][2] = 2;
  frameRate(30);
  //make a server
}

void draw() 
{
  background(255);
  for (int i=0; i<sizeX; i++) {
    for (int j=0; j<sizeX; j++) {
      if (IDs[i][j] == 1)
        fill(247, 62, 45);
      else if (IDs[i][j] == 2)
        fill(245, 232, 67);
      else if (IDs[i][j] == 3)
        fill(115, 227, 53);
      else if (IDs[i][j] == 4)
        fill(72, 245, 247);
      else if (IDs[i][j] == 5)
        fill(63, 122, 247);
      else if (IDs[i][j] == 6)
        fill(235, 133, 251);
      else if (IDs[i][j] == -1)
        fill(255);
      else
        fill(220);
      hexagon(i*((size*0.87)*2)+((j%2)*(size*0.87))+(size*0.87), j*(size*1.5)+size, size);
      fill(16, 80, 167);
      text(i+"|"+j, i*((size*0.87)*2)+((j%2)*(size-5))+(size-5)-11, j*(size*1.5)+size+7);
    }
  }


  if (/*Arrays.asList(PlayersReady).contains(false) && */gameStarted) {
    int[][] newIDs = Helper.step(IDs, this);
    ArrayList<int[]> Diff = Helper.getDifference(IDs, newIDs);
    IDs = newIDs;
    for (int[] d : Diff){
      //tell clients which fields they're supposed to change
      delay(100); //sonst klappt das nicht
    }
    gameStarted = false;
    for (int i=0; i<PlayersReady.length; i++)
      PlayersReady[i] = false;
  }
  //if (are there messages waiting to be read?) {
    //read current messages input = ;
    // split the input up into individual commands  input = input.substring(0, input.indexOf("\n")); // Only up to the newline
      // and print the entire thing                 println(input);
    //interpret the input
      //do a login thingy
      //change a cell's color
      // check if players are ready
  //}
}

void change(String input) {
  data = int(split(input, ' ')); // Split values into an array
  int PlayerNow = players.indexOf(data[1])+1;
  println(PlayerNow+" "+data[2]+" "+data[3]+" ");
  if (IDs[data[2]][data[3]] == PlayerNow) {
    IDs[data[2]][data[3]] = -1;
    //set owner of the cell to nobody
  } else if (IDs[data[2]][data[3]] == -1) {
    IDs[data[2]][data[3]] = PlayerNow;
    //set owner of the cell to the player specified in the input string
  }
}
void newPlayer(int num) {
  if (players.size() < 6 && !gameStarted) {
    players.add(num);
    visitors.add(num);
    // send confirmation of the connection request;
  } else {
    //send confirmation of the connection request, and inform the clients the game has started
    visitors.add(num);
  }
}


void hexagon(float x, float y, float radius) {
  float angle = 1.0471975512;
  beginShape();
  for (float a = angle/2; a < TWO_PI+angle/2; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}