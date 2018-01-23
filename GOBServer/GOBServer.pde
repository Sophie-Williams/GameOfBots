import processing.net.*;
import java.util.Arrays;

int size = 30;
int sizeX = 15;
int sizeY = 15;
int[][] IDs = new int[sizeX][sizeY];
boolean[] PlayersReady = new boolean[6];

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
  s = new Server(this, 12345); // Start a simple server on a port
}

void draw() 
{
  if (!Arrays.asList(PlayersReady).contains(false))
    IDs = Helper.step(IDs, this);
  c = s.available();
  if (c != null) {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n")); // Only up to the newline
    data = int(split(input, ' ')); // Split values into an array
    println(data[0]+" "+data[1]+" "+data[2]+" ");
    if(IDs[data[1]][data[2]] == data[0]){
      IDs[data[1]][data[2]] = -1;
      s.write(-1+" "+data[1]+" "+data[2]+"\n");
    }
    //data[0], data[1], data[2], data[3];
  }
}