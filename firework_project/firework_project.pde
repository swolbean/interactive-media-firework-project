// This initializes the variables needed to load the data into an 2-dimensional-array
Table peopleCounterDataEif;
int cols = 4;
int rows = 832;
int[][] peopleCounterData = new int[rows][cols];


/* These are the changeable parameters of the firework
    - numberFireworkObjects sets the number of objects within the firework
    - speed sets the speed in which the objects move into the y-direction
    - rotationSpeed sets the speed of the rotation
*/

int numberFireworkObjects = 5;
float speed = 3;
float rotationSpeed = 0.09;


PImage[] images = new PImage[7];
PImage[] randomImages = new PImage[numberFireworkObjects];
float[] rotationDirection = new float[numberFireworkObjects];
float[] randomRotationDirection = new float[numberFireworkObjects];

// These variables are needed to display the humans
PImage female_pink;
PImage female_blue;
PImage female_blue_green;
PImage female_yellow;
PImage male_blue_light;
PImage male_green;
PImage male_pink;

// These variables are needed for the firework
// These variables determine the rotation
float side1 = 1;
float side2 = 2;
float side3 = 1.25;

// This is needed since otherwise images take width and height of themselves
int width = 800;
int height = 800;

// This variables are needed for the starting position of the firework
float startFireworkX = width/2.3;
float startFireworkY = height - 150;


// This function loops over the peopleCounterDataEif data to write the data into an array
void fillDataArray() {
for (int i = 0; i < rows; i++) {
  for (int j = 0; j < cols; j++) {
    peopleCounterData[i][j] = peopleCounterDataEif.getInt(i, j);
  }
}
}

// This function creates random indexes within the length of the image array to randomly select images and put them into the randomImages array
void fillImageArray() {
for (int i = 0; i < numberFireworkObjects; i++) {
    int rand = (int)random(images.length);
    randomImages[i] = images[rand];
  }
}


// This function creates randomly created rotation directions
void fillRotationArray() {
for (int j = 0; j < numberFireworkObjects; j++) {
    rotationDirection[j] = random(-3,3);
  }
for (int i = 0; i < numberFireworkObjects; i++) {
    int rand = (int)random(rotationDirection.length);
    randomRotationDirection[i] = rotationDirection[rand];
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
fillImageArray();
fillRotationArray();
}

void draw(){
  background(179, 217, 255);
  fireworkMovement();
}

// This function creates the rotation and movement of the randomly selected firework elements
void fireworkMovement(){
  
  for (int i = 0; i < numberFireworkObjects; i = i+1) {
  pushMatrix();
  translate(startFireworkX+(frameCount*randomRotationDirection[i]), startFireworkY-(speed*frameCount));
  rotate((rotationSpeed*frameCount));
  image(randomImages[i], 0, 0);
  popMatrix();
}}
