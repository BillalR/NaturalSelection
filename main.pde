//Global class objects
int population = 100;
int GENE_LENGTH = 1000;
mover[] blobs = new mover[population];
goal point = new goal();

//Global variables
int iterations = 10000;
PFont f;
int generation = 0;
float mutationRate = 0.02; //In percent
boolean reboot = false;

//Global count
int geneCount = 0;

//Global List Objects
float[] genePool = new float[population];
float[] fitnessScore = new float[population];
ArrayList<mover> mattingPool = new ArrayList<mover>();

//Initalize the parents and child of the mover class
mover mom;
mover dad;

void setup() {
  
  size(1080,720);
  frameRate(200);
  background(255,152,240);
  f = createFont("Arial", 16, true);
  textFont(f, 16);
  
  PVector iPosition;
  point.initialize();
  
  //populate the little thingy
  for(int i = 0; i < population; i++){ 
    iPosition = new PVector( (int) width/2, (int) 700);
    blobs[i] = new mover(iPosition);
    blobs[i].genePool = createGenes(GENE_LENGTH);
  }
 
}

void draw() {

  if (geneCount < GENE_LENGTH - 1 && reboot == false){
    
  background(255,152,240);
  text("Generations: " + str(generation), 930, 20);
  point.display();
  
  for(int i = 0; i < blobs.length; i++){
    PVector force = new PVector(blobs[i].genePool[geneCount].x, blobs[i].genePool[geneCount].y);
    blobs[i].applyForce(force);
    blobs[i].update();
    //blobs[i].edges();
    
    if (blobs[i].collision(point.position()) == true){
      //blobs[i].circle.setFill(color(255,0,0));
      reboot = true;
      break;
    }
    blobs[i].display();
  }
  geneCount += 1;
  } else {
   
   //Calculate fitness score for each blobs position after iterations
   for(int i = 0; i < blobs.length; i++){
     blobs[i].fitness = calcFitness(blobs[i].position);
   }
   
   naturalSelection();
   
   reproduce();
   
  //Complete reset of points
  PVector iPosition;
  
    //populate the little thingy
  for(int i = 0; i < population; i++){ 
    iPosition = new PVector( (int) width/2, (int) 700);
    blobs[i].position = iPosition;
  }
  
  geneCount = 0;
  generation += 1;
  reboot = false;
    
  }

   
}

PVector[] createGenes(int n){
  PVector[] s = new PVector[n];
  
  for(int i = 0; i < GENE_LENGTH; i++){
    s[i] = new PVector(random(-1,1), random(-1, 1));
  }
  return s;
}

float calcFitness(PVector blobPos){
  float fitness = 0;
  PVector goalPosition = point.position();
  float distanceToGoal = sqrt(sq(blobPos.x-goalPosition.x)+sq(blobPos.y-goalPosition.y));
  float normalizedDistance = distanceToGoal / height;
  //float normalizedDistanceY = distanceToGoal / width;
  //float normalizedDistance = normalizedDistanceX + normalizedDistanceY;
  fitness = 1 - normalizedDistance;
  return fitness;
}

void naturalSelection(){
    float n = 0;
    for(int i = 0; i < population; i++){
      n =  round(blobs[i].fitness* 100);
      for(int j = 0; j < (int) n; j++)
      {
        mattingPool.add(blobs[i]);
      }
    }
}

void reproduce(){
    for(int i = 0; i < population; i++){
     int mummyIndex = floor(random(mattingPool.size()));
     int daddyIndex = floor(random(mattingPool.size()));
     
     mom = mattingPool.get(mummyIndex);
     dad = mattingPool.get(daddyIndex);
     
     //Produce the baby
     for(int j = 0; j < GENE_LENGTH; j++){
       if(j % 2 == 0){
         blobs[i].genePool[j].x = mom.genePool[j].x;
         blobs[i].genePool[j].y = mom.genePool[j].y;
       } else {
         blobs[i].genePool[j].x = dad.genePool[j].x;
         blobs[i].genePool[j].y = dad.genePool[j].y;
       }
     }
     
     //Mutate the baby, X-Men style
     for(int k = 0; k < GENE_LENGTH; k++){
      if(random(1) < mutationRate){
        blobs[i].genePool[k].x = random(-1,1);
        blobs[i].genePool[k].y = random(-1,1);
         }
       }
    }
  
}
