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
  float speed = frameCount*9;
  float left1 = frameCount*4;
  float left2 = frameCount*4.5;
  float left3 = frameCount*6;
  float right1 = frameCount*4;
  float right2 = frameCount*4.5;
  float right3 = frameCount*6;
  background(179, 217, 255);
  image(female_pink, startFireworkX-left1, startFireworkY-speed);
  image(female_blue, startFireworkX-left2, startFireworkY-speed);
  image(female_blue_green, startFireworkX-left3, startFireworkY-speed);
  image(female_yellow, startFireworkX, startFireworkY-speed);
  image(male_blue_light, startFireworkX+right3, startFireworkY-speed);
  image(male_green, startFireworkX+right1, startFireworkY-speed);
  image(male_pink, startFireworkX+right2, startFireworkY-speed);
}
    
