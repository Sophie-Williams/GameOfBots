int size = 30;
int sizeX = 15;
int sizeY = 15;
int[][] IDs = new int[sizeX][sizeY];
long last = 0;
boolean run = false;
int ausgewaehlt = 0;
int speed = 30;

void setup() {
  size(828, 725);
  background(255);
  textSize(15);
  IDs = Helper.fillIDs(IDs);
  IDs[4][2] = 2;
  frameRate(30);
}

void draw() {
  if (frameCount - last > speed && run) {
    IDs = Helper.step(IDs, this);
    last = frameCount;
  }
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

  //println(frameRate);
}

void mouseClicked() {
  int j = (int)(mouseY/(size*1.5));
  int i = (int)(mouseX/(((size*0.87)*2))-(j%2)*0.5);
  if (j > 14 || i > 14)
    run = !run;
  else if (i>=0&&j>=0)
    IDs[i][j] = ausgewaehlt;
  println(i+" "+j);
  //mach Mauszeug hier!
}

void keyPressed() {
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
    ausgewaehlt = -1;
  }
  if (key == '+') {
    if (speed > 0)
      speed--;
    println(speed);
  }
  if (key == '-') {
    speed++;
    println(speed);
  }
  if (key == 'r') {
    run = !run;
  }
  if (key == ' ') {
    doOnce();
  }
  if (key == 'd') {//delete
    for (int i=0; i<sizeX; i++) {
      for (int j=0; j<sizeX; j++) {
        IDs[i][j] = -1;
      }
    }
  }
}

void doOnce() {
  IDs = Helper.step(IDs, this);
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