// This imports the controlP5 library (needed for buttons etc.)
import controlP5.*;
ControlP5 controlP5;


// These variables are needed to load the data
Table peopleCounterDataEif;
int cols = 4;
int rows = 832;
// These variables are needed for the firework
int numberFireworkObjects = 10; // sets the number of objects in the firework
float speed = 3; // sets the speed in which the objects move into the y-direction
float rotationSpeed = 0.09; // sets the rotation speed of the firework objects
int index = 29; //sets the length of the arrays (must be max number of persons in Excel)
// This is needed since otherwise images take width and height of themselves
int width = 800;
int height = 800;
// This variables are needed for the starting position of the firework
float startFireworkX = width/2.3;
float startFireworkY = height - 150;


int[][] peopleCounterData = new int[rows][cols];
PImage[] images = new PImage[7];
PImage[] randomImages = new PImage[numberFireworkObjects];
float[] rotationDirection = new float[numberFireworkObjects];
float[] randomRotationDirection = new float[numberFireworkObjects];


// These variables are needed to initialize the human images
PImage female_pink;
PImage female_blue;
PImage female_blue_green;
PImage female_yellow;
PImage male_blue_light;
PImage male_green;
PImage male_pink;



// This function loops over the peopleCounterDataEif data to write the data into an 2d-array
void fillDataArray() {
for (int i = 0; i < rows; i++) {
  for (int j = 0; j < cols; j++) {
    peopleCounterData[i][j] = peopleCounterDataEif.getInt(i, j);
  }
}
}


// This function fills the randomImages, rotatioDirection and randomRotationDirection arrays
void fillArrays() {
for (int i = 0; i < numberFireworkObjects; i++) {
    int rand = (int)random(images.length);
    randomImages[i] = images[rand];
  }
for (int j = 0; j < numberFireworkObjects; j++) {
    rotationDirection[j] = random(-3,3);
  }
for (int k = 0; k < numberFireworkObjects; k++) {
    int rand = (int)random(rotationDirection.length);
    randomRotationDirection[k] = rotationDirection[rand];
  }
}


// This function creates the rotation and movement of the randomly selected firework elements
void fireworkMovement(){
  for (int i = 0; i < numberFireworkObjects; i = i+1) {
  pushMatrix();
  translate(startFireworkX+(frameCount*randomRotationDirection[i]), startFireworkY-(speed*frameCount));
  rotate((rotationSpeed*frameCount));
  image(randomImages[i], 0, 0);
  popMatrix();
}
}


void setup() {
peopleCounterDataEif = loadTable("CB11_02_Broadway_East_In_data.csv");
fillDataArray();
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
fillArrays();
controlP5 = new ControlP5(this);
controlP5.addButton("Music on / off",1,10,10,70,20);
numberFireworkObjects = peopleCounterData[index][3];
print(numberFireworkObjects);
}


void draw(){
  background(179, 217, 255);
  fireworkMovement();
}
