// Class to designate the selection population


class mover {
  PVector position;
  PVector velocity = new PVector(1, 1);
  PVector acceleration = new PVector(0,0);
  int blobSize = 10;
  float fitness;
  PShape circle;
  PVector[] genePool = new PVector[population];
  
  mover(PVector pos){
    circle = createShape(ELLIPSE, 0, 0, blobSize, blobSize); 
    circle.setFill(color(190, 190, 190));
    shape(circle, pos.x, pos.y);
    position = pos;
  }
  
  void applyForce(PVector force){
    acceleration = force;
  }
  
  void update(){
    position.add(velocity);
    velocity.add(acceleration);
    velocity.limit(3);
  }
  void edges(){
    
    if(position.x >= width - 10){
      position.x = width-10;
    } else if (position.x <= 10){
      position.x = 10;
    }
    if(position.y >= height-10){
      position.y = height-10;
    } else if (position.y <= 10){
      position.y = 10;
    }
  }
  
 boolean collision(PVector pos){
   float distance = sqrt(sq(position.x - pos.x) + sq(position.y - pos.y));
   if(distance < 50){
       return true;
    } else {
      return false;
    }
 }
 
  void display(){
    shape(circle, position.x, position.y);
    
    //circle(position.x, position.y, blobSize);
  }
  

}
