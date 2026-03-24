int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;

int GRAVITY = 0;
int SPRING = 1;
int DRAGF = 2;
int FRICTION = 3;
int COMBINATION = 4;
int MOVING = 5;
int BOUNCE = 6;
boolean[] simMode = new boolean[7];
String[] modes = {"Gravity", "Spring", "Drag", "Friction", "Combination", "Moving", "Bounce"};
float[] frictioncoef = {0.4, .05, .02, .3, .8, .7};
int fIndex = 0;
float mu = 0;

FixedOrb earth;
OrbNode[] orbs = new OrbNode[NUM_ORBS];

void setup() {
  size(600, 600);
  simMode[MOVING] = true;
  simMode[BOUNCE] = true;

  makeOrbs();
}//setup

void draw() {
  background(255);
  displayMode();

  OrbNode current;
  if (simMode[FRICTION] || simMode[COMBINATION]) {
    fill(0, 255, 0);
    rect(0, height * 4/5, width, height);
  }
  if (simMode[MOVING]) {
    for (int i = 0; i < NUM_ORBS; i++) {
      current = orbs[i];
      if (current != null) {

        //SPRING FORCE
        if (simMode[SPRING] || simMode[COMBINATION]) {
          current.applySprings(SPRING_LENGTH, SPRING_K);
        }

        //GRAVITY
        if (simMode[GRAVITY] || simMode[COMBINATION]) {
          current.applyForce(current.getGravity(earth, G_CONSTANT));
        }

        //DRAGF
        if (simMode[DRAGF] || simMode[COMBINATION]) {
          current.applyForce(current.getDragForce(D_COEF));
        }

        //FRICTION
        if (simMode[FRICTION] || simMode[COMBINATION]) {
          
          if (current.center.y >= height * 4/5) {
            current.applyForce(current.getFriction(mu, 0.1));
          }
        }
      }
    }

    for (int i = 0; i < NUM_ORBS; i++) {
      current = orbs[i];
      if (current != null) {
        current.move(simMode[BOUNCE]);
      }
    }
  }

  if (orbs[0] != null) {
    for (int o=0; o < NUM_ORBS; o++) {
      if (simMode[SPRING] || simMode[COMBINATION]) {
        orbs[o].display(SPRING_LENGTH);
      } else {
        orbs[o].display();
      }
    }
  }
}//draw


void makeOrbs() {
  for (int o=0; o < NUM_ORBS; o++) {
    orbs[o] = new OrbNode();
  }
  for (int o=0; o < NUM_ORBS; o++) {
    if (o < NUM_ORBS - 1) {
      orbs[o].next = orbs[o+1];
    }
    if (o > 0) {
      orbs[o].previous = orbs[o-1];
    }
  }
}

void resetSim(int mode) {
  for (int i=0; i<simMode.length; i++) simMode[i] = false;
  simMode[mode] = true;
  makeOrbs();

  if (mode == GRAVITY) {
    earth = new FixedOrb(width/2, height * 500, 100, 20000);
  } else if (mode == SPRING) {
  } else if (mode == DRAGF) {
  } else if (mode == FRICTION) {
    fill(0, 255, 0);
    rect(0, height * 4/5, width, height);
  } else if (mode == COMBINATION) {
    earth = new FixedOrb(width/2, height * 500, 100, 20000);
    fill(0, 255, 0);
    rect(0, height * 4/5, width, height);
  }
}

void keyPressed() {
  if (key == '1') {
    simMode[GRAVITY] = !simMode[GRAVITY];
    resetSim(GRAVITY);
  }
  if (key == '2') {
    simMode[SPRING] = !simMode[SPRING];
    resetSim(SPRING);
  }
  if (key == '3') {
    simMode[DRAGF] = !simMode[DRAGF];
    resetSim(DRAGF);
  }
  if (key == '4') {
    simMode[FRICTION] = !simMode[FRICTION];
    resetSim(FRICTION);
  }
  if (key == '5') {
    simMode[COMBINATION] = !simMode[COMBINATION];
    resetSim(COMBINATION);
  }
  if (keyCode == UP) {
    for (int o=0; o<orbs.length; o++) {
      orbs[o].velocity.y -= 1;
    }
  }
  if (keyCode == DOWN) {
    for (int o=0; o<orbs.length; o++) {
      orbs[o].velocity.y += 1;
    }
  }
  if (keyCode == LEFT) {
    for (int o=0; o<orbs.length; o++) {
      orbs[o].velocity.x -= 1;
    }
  }
  if (keyCode == RIGHT) {
    for (int o=0; o<orbs.length; o++) {
      orbs[o].velocity.x += 1;
    }
  }
  if (key == 'w') {
    fIndex++;
    if (fIndex > frictioncoef.length-1) {
      fIndex = 0;
    }
    mu = frictioncoef[fIndex];
    println(frictioncoef[fIndex]);
  }
  if (key == ' ') {
    simMode[MOVING] = !simMode[MOVING];
  }
  if (key == 'b') {
    simMode[BOUNCE] = !simMode[BOUNCE];
  }
  if (key == 'r') {
    makeOrbs();
  }
}//keyPressed

void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int x = 0;

  for (int m=0; m<simMode.length; m++) {
    //set box color
    if (simMode[m]) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
}//display
