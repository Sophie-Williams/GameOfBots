int size = 30;
int sizeX = 15;
int sizeY = 15;
int[][] IDs = new int[sizeX][sizeY];
long last = 0;
boolean run = false;
int ausgewaehlt = 0;
int speed = 30;
int num;

void setup() 
{
  size(828, 725);
  background(255);
  textSize(15);
  IDs = Helper.fillIDs(IDs);
  IDs[4][2] = 2;
  frameRate(30);
  num = (int)(random(100))+20;
  //c.write("hello "+ num + "\n");
  //warten bis antwort kommt / es etwas zum lesen gibt
  String input = "irgendwas einigermaßen sinnvolles"; //liest neue nachrichten. idealerweise.
  input = input.substring(0, input.indexOf("\n")); // Only up to the newline
  if ("hello".equals(split(input, ' ')[0])) {
    println("hi");
    if ("OK".equals(split(input, ' ')[2]))
      println("Alles OK");
    else
      println("Nur ein Zuschauer :(");
  } else
    print("Fehler");
}

void draw() {
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


  //data handling / command interpretation
}

void hexagon(float x, float y, float radius) {
  float[][] vets = {{0.8660254, 0.5}, {0, 1.0}, {-0.8660254, 0.5}, 
    {-0.8660254, -0.5}, {0, -1.0}, {0.8660253, -0.5}, {0.8660256, 0.5}};
  beginShape();
  for (int i=0; i<7; i++) {
    float sx = x + vets[i][0] * radius;
    float sy = y + vets[i][1] * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void keyPressed() {
  if (key == ' ') {
    c.write("ready "+num+"\n");
  }
}

void mouseClicked() {
  int j = (int)(mouseY/(size*1.5));
  int i = (int)(mouseX/(((size*0.87)*2))-(j%2)*0.5);
  if (j > 14 || i > 14)
    run = !run;
  else if (i>=0&&j>=0) {
    //IDs[i][j] = ausgewaehlt;
    c.write("change "+num+" "+i+" "+j+ "\n");
  }
  println(i+" "+j);
  //mach Mauszeug hier!
}