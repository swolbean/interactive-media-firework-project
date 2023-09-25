// This imports the controlP5 library (needed for buttons etc.)
import controlP5.*;
import beads.*;

ControlP5 controlP5;
AudioContext ac;
Gain volumeControl;

// These variables are needed for background volume control
float volume = 0.5; 
float volumeStep = 0.05; 

// These variables are needed to toggle background volume control
boolean isMusicPlaying = false;

// These variables are needed to load the data
Table peopleCounterDataEif;
int cols = 4;
int rows = 832;
// These variables are needed for the firework
int numberFireworkObjects = 29; //sets the length of the arrays (must be max number of persons in Excel)
float speed = 3; // sets the speed in which the objects move into the y-direction
float rotationSpeed = 0.09; // sets the rotation speed of the firework objects
int index = 29; // sets the index of the row of which the number of objects shall be displayed
// This is needed since otherwise images take width and height of themselves
int currentIndex = 0; //keeps track of current data point
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

void backgroundMusic(){
   String audioFileName = "C:/Users/baust/OneDrive/Desktop/school/2023/interactive media/interactive-media-firework-project/firework_project/sounds/624363__theoctopus559__background-music-loop-drums.wav";
   Sample sample = SampleManager.sample(audioFileName);
   SamplePlayer backgroundAudioPlayer = new SamplePlayer(ac, sample);
   backgroundAudioPlayer.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);  
   volumeControl = new Gain(ac, 1, volume);
   volumeControl.addInput(backgroundAudioPlayer);
   ac.out.addInput(volumeControl);
   ac.start();
}

void mousePressed() {
  startFireworkX = mouseX;
  startFireworkY = mouseY;
  //updates the origin of fireworks after mouse is clicked
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
  controlP5 = new ControlP5(this); //creating slider to choose start time
  controlP5.addSlider("TimeSlider")
    .setPosition(50, 50)
    .setSize(300, 20)
    .setRange(0, rows - 1) // Set the range to the number of data rows
    .setValue(currentIndex); // starting value is currentIndex
  //Display for time and date on slider
  controlP5.addTextlabel("TimeLabel")
    .setText("Date & Time: " + getDateAndTime(currentIndex))
    .setPosition(400, 50)
    .setColor(color(0))
    .setFont(createFont("Arial", 12));
  
  ac = new AudioContext();
  backgroundMusic();
  
  isMusicPlaying = ac.isRunning();
  
}

void draw(){
  background(179, 217, 255);
  fireworkMovement();
  
  //units for slider
  int day = peopleCounterData[currentIndex][0];
  int hour = peopleCounterData[currentIndex][1];
  int minute = peopleCounterData[currentIndex][2];
  
}

void TimeSlider(float value) {
  // Update currentIndex based on the slider's value
  currentIndex = int(value);
  //to display the date and time of the data start point
  Textlabel timeLabel = (Textlabel)controlP5.get("TimeLabel");
  timeLabel.setText("Date & Time: " + getDateAndTime(currentIndex));
}
String getDateAndTime(int index) {
  // Get the date and time based on the selected index the EIF data
  int day = peopleCounterData[index][0];
  int hour = peopleCounterData[index][1];
  int minute = peopleCounterData[index][2];
 return "Data: " + day + "th September " + hour + "h " + minute + "min";
  }
  
void keyPressed() {
  if (keyCode == UP) {
    volume = constrain(volume + volumeStep, 0, 1);
    volumeControl.setGain(volume);
  } else if (keyCode == DOWN) {
    volume = constrain(volume - volumeStep, 0, 1);
    volumeControl.setGain(volume);
  }
}
