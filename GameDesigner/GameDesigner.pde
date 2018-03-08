import java.io.ObjectOutputStream;
import java.io.FileOutputStream;
int size = 30;
int num = 3;
int sizeX = 13;
int sizeY = sizeX;
int[][] IDs = new int[sizeX][sizeY];
int ausgewaehlt = -1;
void setup() {
  size(828, 725);
  background(255);
  textSize(15);
  frameRate(30);
}
void draw() {
  background(255);
  for (int i=0; i<sizeX; i++) {
    for (int j=0; j<sizeX; j++) {
      if (IDs[i][j] == 1)
        fill(247, 62, 0);
      else if (IDs[i][j] == 2)
        fill(245, 232, 0);
      else if (IDs[i][j] == 3)
        fill(115, 227, 0);
      else if (IDs[i][j] == 4)
        fill(72, 245, 0);
      else if (IDs[i][j] == 5)
        fill(63, 122, 0);
      else if (IDs[i][j] == 6)
        fill(235, 133, 0);
      else if (IDs[i][j] == 7)
        fill(247, 62, 45);
      else if (IDs[i][j] == 8)
        fill(245, 232, 67);
      else if (IDs[i][j] == 9)
        fill(115, 227, 53);
      else if (IDs[i][j] == 10)
        fill(72, 245, 247);
      else if (IDs[i][j] == 11)
        fill(63, 122, 247);
      else if (IDs[i][j] == 12)
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
}

void keyPressed() {
  if (key == ' ') {
    print("Write!");
    try {
      ObjectOutputStream outputStream = new ObjectOutputStream(new FileOutputStream("/Users/lukas/dats/"+num+".dat"));
      outputStream.writeObject(IDs);
      outputStream.close();
    }
    catch(Exception e) {
      print(e);
    }
  }
  if (key == '0') {
    ausgewaehlt = 0;
  }
  if (key == '1') {
    ausgewaehlt = 1;
  }
  if (key == '2') {
    ausgewaehlt = 2;
  }
  if (key == '3') {
    ausgewaehlt = 3;
  }
  if (key == '4') {
    ausgewaehlt = 4;
  }
  if (key == '5') {
    ausgewaehlt = 5;
  }
  if (key == '6') {
    ausgewaehlt = 6;
  }
  if (key == '7') {
    ausgewaehlt = 7;
  }
  if (key == '8') {
    ausgewaehlt = 8;
  }
  if (key == '9') {
    ausgewaehlt = 9;
  }
  if (key == 'ß') {
    ausgewaehlt = 10;
  }
  if (key == '+') {
    ausgewaehlt = 11;
  }
  if (key == '#') {
    ausgewaehlt = 12;
  }
  if (key == '-') {
    ausgewaehlt = -1;
  }
}

void mouseClicked() {
  int j = (int)(mouseY/(size*1.5));
  int i = (int)(mouseX/(((size*0.87)*2))-(j%2)*0.5);
  if ((i>=0&&j>=0) && (i<=(sizeX-1)&&j<=(sizeY-1))) {//ist der Klick im Spielfeld?
    IDs[i][j] = ausgewaehlt;
  }
  println(i+" "+j);
  //mach Mauszeug hier!
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