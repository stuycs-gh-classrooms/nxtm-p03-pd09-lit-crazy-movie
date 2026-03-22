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

FixedOrb earth;
OrbNode o0, o1, o2, o3;

void setup() {
  size(600, 600);
  simMode[MOVING] = true;
  simMode[BOUNCE] = true;

  earth = new FixedOrb(width/2, height * 200, 1, 20000);
  makeOrbs();

}//setup

void draw() {
  background(255);
  displayMode();

  OrbNode current;

  
  if (simMode[MOVING]) {
    current = o0;
    while (current != null) {
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
        // Based on your plan: High friction on bottom half, low on top
        float mu = (current.center.y > height/2) ? 0.3 : 0.05; 
        current.applyForce(current.getFriction(mu, 0.1)); 
      }
      
      current = current.next;
    }


    current = o0;
    while (current != null) {
      current.move(simMode[BOUNCE]);
      current = current.next;
    }
  }

  current = o0;
  while (current != null) {
    current.display(SPRING_LENGTH);
    current = current.next;
  }

}//draw


void makeOrbs() {
  o0 = new OrbNode();
  o1 = new OrbNode();
  o2 = new OrbNode();
  o3 = new OrbNode();

  o0.next = o1;
  o1.previous = o0;
  o1.next = o2;
  o2.previous = o1;
  o2.next = o3;
  o3.previous = o2;

}

void resetSim(int mode) {
  for (int i=0; i<simMode.length; i++) simMode[i] = false;
  simMode[mode] = true;
  makeOrbs(); 

  if (mode == GRAVITY) {
  } else if (mode == SPRING) {
  } else if (mode == DRAGF) {
  } else if (mode == FRICTION) {
  } else if (mode == COMBINATION) {
  }
}

void keyPressed() {
  if (key == '1') { simMode[GRAVITY] = !simMode[GRAVITY]; resetSim(GRAVITY);}
  if (key == '2') { simMode[SPRING] = !simMode[SPRING]; resetSim(SPRING);}
  if (key == '3') { simMode[DRAGF] = !simMode[DRAGF]; resetSim(DRAGF);}
  if (key == '4') { simMode[FRICTION] = !simMode[FRICTION]; resetSim(FRICTION);}
  if (key == '5') { simMode[COMBINATION] = !simMode[COMBINATION]; resetSim(COMBINATION);}
  if (key == ' ') { simMode[MOVING] = !simMode[MOVING]; }
  if (key == 'b') { simMode[BOUNCE] = !simMode[BOUNCE]; }
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
    if (simMode[m]) { fill(0, 255, 0); }
    else { fill(255, 0, 0); }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
}//display
