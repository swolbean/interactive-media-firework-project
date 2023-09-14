// This initializes the variables needed to load the data into an 2-dimensional-array
Table peopleCounterDataEif;
int cols = 4;
int rows = 832;
int[][] peopleCounterData = new int[rows][cols];
PImage[] images = new PImage[7];
float[] rotationDirection = new float[7];

// This is needed since otherwise images take width and height of themselves
int width = 800;
int height = 800;

// This variables are needed for the firework
float startFireworkX = width/2.3;
float startFireworkY = height - 150;


// These variables are needed to display the humans
PImage female_pink;
PImage female_blue;
PImage female_blue_green;
PImage female_yellow;
PImage male_blue_light;
PImage male_green;
PImage male_pink;


// This function loops over the peopleCounterDataEif data to write the data into an array
void fillArray() {
for (int i = 0; i < rows; i++) {
  for (int j = 0; j < cols; j++) {
    peopleCounterData[i][j] = peopleCounterDataEif.getInt(i, j);
  }
}
}

void setup() {
peopleCounterDataEif = loadTable("CB11_02_Broadway_East_In_data.csv");
fillArray();
size(800, 800);
background(179, 217, 255);
female_pink = loadImage("female_pink.png");
female_blue = loadImage("female_blue.png");
female_blue_green = loadImage("female_blue_green.png");
female_yellow = loadImage("female_yellow.png");
male_blue_light = loadImage("male_blue_light.png");
male_green = loadImage("male_green.png");
male_pink = loadImage("male_pink.png");
images[0] = female_pink; // Assign
images[1] = female_blue;
images[2] = female_blue_green;
images[3] = female_yellow;
images[4] = male_blue_light;
images[5] = male_green;
images[6] = male_pink;
}

void draw(){
  background(179, 217, 255);
  fireworkMovement();
}

// This function creates the rotation and movement of the firework elements
void fireworkMovement(){
  float speed = frameCount*3;
  float side1 = frameCount*1;
  float side2 = frameCount*2.5;
  float side3 = frameCount*1.25;
  float rotationSpeed = frameCount*0.09;
  rotationDirection[0] = -side1;
  rotationDirection[1] = -side2;
  rotationDirection[2] = -side3;
  rotationDirection[3] = 0;
  rotationDirection[4] = +side3;
  rotationDirection[5] = +side1;
  rotationDirection[6] = +side2;

  for (int i = 0; i < 7; i = i+1) {
  pushMatrix();
  translate(startFireworkX+rotationDirection[i], startFireworkY-speed);
  rotate(rotationSpeed);
  image(images[i], 0, 0);
  popMatrix();
}}
  
    
