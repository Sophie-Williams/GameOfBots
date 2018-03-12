import processing.net.*;//Die alte Netzwerkimplementation
import java.util.Arrays;//Arrayfunktionen

int size = 30;//die Größe der Felder
int sizeX = 15;//wie viele Felder gibt es in X-Richtung?
int sizeY = 15;//wie viele Felder gibt es in Y-Richtung?
int[][] IDs = new int[sizeX][sizeY];//Das Spielfeld an sich:
            //Speichert die IDs der Felder ab
boolean[] PlayersReady = new boolean[1];//Wie viele Spieler sind fertig?
boolean gameStarted = false;//Hat das Spiel begonnen?

ArrayList<Integer> players = new ArrayList<Integer>();
ArrayList<Integer> visitors = new ArrayList<Integer>();

Server s;
Client c;
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
  s = new Server(this, 12345); //Server auf Port 12345 starten
}

void draw() 
{
  background(255);
  for (int i=0; i<sizeX; i++) {
    for (int j=0; j<sizeX; j++) {//Malen
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
    //wenn das Spiel begonnen hat
    int[][] newIDs = Helper.step(IDs, this);//Gehe einen Schritt
    ArrayList<int[]> Diff = Helper.getDifference(IDs, newIDs);//gib den Unterschied
    IDs = newIDs;
    for (int[] d : Diff){//allen Clients
      s.write("changeTo "+IDs[d[0]][d[1]]+" "+d[0]+" "+d[1]+"\n");
      delay(100); //sonst klappt das nicht
    }
    gameStarted = false;
    for (int i=0; i<PlayersReady.length; i++)
      PlayersReady[i] = false;
  }
  c = s.available();
  if (c != null) {//wenn irgendwas gesendet wurde
    input = c.readString();//Lese
    input = input.substring(0, input.indexOf("\n")); //bis \n
    println(input);
    if ("hello".equals(split(input, ' ')[0]))
      newPlayer(int(split(input, ' ')[1]));
    else if ("change".equals(split(input, ' ')[0])) 
      change(input);
    else if ("ready".equals(split(input, ' ')[0])) {
      data = int(split(input, ' '));
      PlayersReady[players.indexOf(data[1])] = true;
      //^muss noch besser
      gameStarted = true;
    }
  }
}

void change(String input) {
  data = int(split(input, ' ')); // Split values into an array
  int PlayerNow = players.indexOf(data[1])+1;
  println(PlayerNow+" "+data[2]+" "+data[3]+" ");
  if (IDs[data[2]][data[3]] == PlayerNow) {
    IDs[data[2]][data[3]] = -1;
    s.write(-1+" "+data[2]+" "+data[3]+"\n");
  } else if (IDs[data[2]][data[3]] == -1) {
    IDs[data[2]][data[3]] = PlayerNow;
    s.write("changeTo "+PlayerNow+" "+data[2]+" "+data[3]+"\n");
  }
}
void newPlayer(int num) {
  if (players.size() < 6 && !gameStarted) {
    players.add(num);
    visitors.add(num);
    s.write("hello "+num+" OK\n");
  } else {
    s.write("hello "+num+" gameStarted\n");
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