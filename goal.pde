//Class that initalizes the square 
class goal{
  int score;
  PShape square;
  goal(){
    
  }
  
  void initialize(){
    score = 0;
    square = createShape(RECT, width/2, 5, 10, 10);
    square.setFill(color(0,0,255));
    //square.setStroke(false);
  }
  
  void display(){
    shape(square);
  }
  
  PVector position(){
    return new PVector(width/2, 5);
  }

}
