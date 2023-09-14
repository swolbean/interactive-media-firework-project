// This initializes the variables needed to load the data into an 2-dimensional-array
Table peopleCounterDataEif;
int cols = 4;
int rows = 832;
int[][] peopleCounterData = new int[rows][cols];

// This is needed since otherwise images take width and height of themselves
int width = 800;
int height = 800;

// This variables are needed for the firework
float startFireworkX = width/2.3;
float startFireworkY = height - 150;
float radianX = 1;
float i = 0;


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
}

void draw(){
  float speed = frameCount*3;
  float side1 = frameCount*1;
  float side2 = frameCount*2.5;
  float side3 = frameCount*1.25;
  float rotationSpeed = frameCount*0.09;
  background(179, 217, 255);
  pushMatrix();
  translate(startFireworkX-side1, startFireworkY-speed);
  rotate(rotationSpeed);
  image(female_pink, 0, 0);
  popMatrix();
  pushMatrix();
  translate(startFireworkX-side2, startFireworkY-speed);
  rotate(rotationSpeed);
  image(female_blue, 0, 0);
  popMatrix();
  pushMatrix();
  translate(startFireworkX-side3, startFireworkY-speed);
  rotate(rotationSpeed);
  image(female_blue_green, 0, 0);
  popMatrix();
  pushMatrix();
  translate(startFireworkX+side3, startFireworkY-speed);
  rotate(rotationSpeed);
  image(male_blue_light, 0, 0);
  popMatrix();
  pushMatrix();
  translate(startFireworkX+side1, startFireworkY-speed);
  rotate(rotationSpeed);
  image(male_green, 0, 0);
  popMatrix();
  pushMatrix();
  translate(startFireworkX+side2, startFireworkY-speed);
  rotate(rotationSpeed);
  image(male_pink, 0, 0);
  popMatrix();
  pushMatrix();
  translate(startFireworkX, startFireworkY-speed);
  rotate(rotationSpeed);
  image(female_yellow, 0, 0);
  popMatrix();
}
    
