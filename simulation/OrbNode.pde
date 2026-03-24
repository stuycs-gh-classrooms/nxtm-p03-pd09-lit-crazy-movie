class OrbNode extends Orb {
    
  OrbNode next;
  OrbNode previous;
  
void display(int springLength){
    super.display(); 
    strokeWeight(2);
    
    // If there is a next node, draws a line between this and next OrbNode
    if (next != null) {
 
      float d = this.center.dist(next.center);
      if (d > springLength) {
        stroke(0, 255, 0); // Extended Green
      } else if (d < springLength) {
        stroke(255, 0, 0); // Compressed Red
      } else {
        stroke(0); //Black
      }
      
      line(this.center.x + 3, this.center.y + 3, next.center.x + 3, next.center.y + 3);
    }
    
    // If there is a previous node, draws a line between this and previous OrbNode
    if (previous != null) {
      float d = this.center.dist(previous.center);
      if (d > springLength) {
        stroke(0, 255, 0); // Extended Green
      } else if (d < springLength) {
        stroke(255, 0, 0); // Compressed Red
      } else {
        stroke(0); //Black
      }
      
      line(this.center.x - 3, this.center.y - 3, previous.center.x - 3, previous.center.y - 3);
    }
    
    noStroke(); 
  }
  
  void applySprings(int springLength, float springK){
    if (next != null) { //connect only if has next
      PVector spring = getSpringForce(next, springLength, springK);
      this.applyForce(spring); 
    }
    if (previous != null) { //connect only if has previous
      PVector spring = getSpringForce(previous, springLength, springK);
      this.applyForce(spring);
    }
  }
  
  PVector getSpringForce(OrbNode other, int springLength, float springK){
    return super.getSpring(other, springLength, springK);
  }
  
}//OrbNode
