// This imports the controlP5 library (needed for buttons etc.)
import controlP5.*;
import ddf.minim.*;
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.ugens.*;
import java.util.Arrays;
import java.util.regex.Pattern;

ControlP5 controlP5;
Minim minim;
AudioOutput out;

// These variables are needed to load the data
Table peopleCounterDataEif;
int cols = 4;
int rows = 832;
// These variables are needed for the firework
int numberFireworkObjects = 29; // sets the length of the arrays (must be max number of persons in Excel)
float speed = 3; // sets the speed at which the objects move in the y-direction
float rotationSpeed = 0.09; // sets the rotation speed of the firework objects
int index = 29; // sets the index of the row from which the number of objects shall be displayed
// This is needed since otherwise images take the width and height of themselves
int currentIndex = 0; // keeps track of the current data point
int width = 800;
int height = 800;
float time = frameCount % 12;
// This variables are needed for the starting position of the firework
float startFireworkX = width / 2.3;
float startFireworkY = height - 150;
int lastFireworkTime = 0; // firework timer
int fireworkInterval = 5000;
int autoSlideTimer = 0; // auto slider timer
int lastAutoSlideTime = 0;
int autoSlideInterval = 10000;

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

// These variables are needed for background music
String bgAudioFileName = "624363__theoctopus559__background-music-loop-drums.wav";
AudioPlayer backgroundAudioPlayer;
float volume = 0.5;
float volumeStep = 0.05;
boolean isMusicPlaying = true;

// These variables are needed for explosion sfx
String exAudioFileName = "587198__derplayer__explosion_big_03.mp3";
AudioPlayer explosionSfxPlayer;
boolean hasExploded;
boolean isNewFirework = true;
float peakHeightY = 500;

// This function loops over the peopleCounterDataEif data to write the data into a 2D-array
void fillDataArray() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      peopleCounterData[i][j] = peopleCounterDataEif.getInt(i, j);
    }
  }
}

// This function fills the randomImages, rotationDirection, and randomRotationDirection arrays
void fillArrays() {
  for (int i = 0; i < numberFireworkObjects; i++) {
    int rand = (int) random(images.length);
    randomImages[i] = images[rand];
  }
  for (int j = 0; j < numberFireworkObjects; j++) {
    rotationDirection[j] = random(-3, 3);
  }
  for (int k = 0; k < numberFireworkObjects; k++) {
    int rand = (int) random(rotationDirection.length);
    randomRotationDirection[k] = rotationDirection[rand];
  }
}

// This function creates the rotation and movement of the randomly selected firework elements
void fireworkMovement() {
  for (int i = 0; i < numberFireworkObjects; i = i + 1) {
    pushMatrix();
    float currentY = startFireworkY - (speed * frameCount);
    translate(startFireworkX + (frameCount * randomRotationDirection[i]), startFireworkY - (speed * frameCount));
    rotate((rotationSpeed * frameCount));
    image(randomImages[i], 0, 0);
    popMatrix();

   if (currentY >= startFireworkY) {
      isNewFirework = true;
    }
    if (isNewFirework && currentY <= peakHeightY) {
      if (!hasExploded) {
        explosionSfxPlayer.rewind(); // Rewind the explosion sound to the beginning
        explosionSfxPlayer.play(); // Play the explosion sound
        hasExploded = true;
      }
      isNewFirework = false;
    }

    currentY = startFireworkY - (speed * frameCount);
  }
}

void resetExplosion() {
  hasExploded = false;
}

void toggleMusic(boolean value) {
  if (value) {
    // Start playing the background music
    if (!backgroundAudioPlayer.isPlaying()) {
      backgroundAudioPlayer.play();
    }
    isMusicPlaying = true;
  } else {
    // Stop the background music
    if (backgroundAudioPlayer.isPlaying()) {
      backgroundAudioPlayer.close();
      isMusicPlaying = false;
    }
  }
}

void TimeSlider(float value) {
  // Update currentIndex based on the slider's value
  currentIndex = int(value);
  // to display the date and time of the data start point
  Textlabel timeLabel = (Textlabel) controlP5.get("TimeLabel");
  timeLabel.setText("Date & Time: " + getDateAndTime(currentIndex));
}

String getDateAndTime(int index) {
  // Get the date and time based on the selected index in the EIF data
  int day = peopleCounterData[index][0];
  int hour = peopleCounterData[index][1];
  int minute = peopleCounterData[index][2];
  return "Data: " + day + "th September " + hour + "h " + minute + "min";
}

void mousePressed() {
  startFireworkX = mouseX;
  startFireworkY = mouseY;
  frameCount = 0;
  // updates the origin of fireworks after the mouse is clicked
}

void setup() {
  minim = new Minim(this);
  out = minim.getLineOut();
  
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
  controlP5.addToggle("toggleMusic")
    .setCaptionLabel("Music On/Off")
    .setValue(isMusicPlaying ? 1 : 0)
    .setPosition(10, 10)
    .setSize(70, 20);
  numberFireworkObjects = peopleCounterData[index][3];
  print(numberFireworkObjects);
  controlP5 = new ControlP5(this); // creating slider to choose start time
  controlP5.addSlider("TimeSlider")
    .setPosition(400, 750)
    .setSize(300, 20)
    .setRange(0, rows - 1) // Set the range to the number of data rows
    .setValue(currentIndex); // starting value is currentIndex
  // Display for time and date on slider
  controlP5.addTextlabel("TimeLabel")
    .setText("Date & Time: " + getDateAndTime(currentIndex))
    .setPosition(50, 750)
    .setColor(color(0))
    .setFont(createFont("Arial", 12));
  autoSlideTimer = millis();
  lastAutoSlideTime = autoSlideTimer;

  // Load background music and explosion sound
  minim = new Minim(this);
  backgroundAudioPlayer = minim.loadFile(bgAudioFileName);
  explosionSfxPlayer = minim.loadFile(exAudioFileName);

  toggleMusic(isMusicPlaying); // Start or stop music based on initial state
}

void draw() {
  background(179, 217, 255);
  autoSlideTimer = millis();
  int elapsedTime = autoSlideTimer - lastAutoSlideTime; // to calculate time since last change
  if (elapsedTime >= autoSlideInterval) { // checking if it is time to change
    lastAutoSlideTime = autoSlideTimer;
    currentIndex++;
    if (currentIndex >= rows) {
      currentIndex = 0;
    }

    // Updates the slider's value and label
    controlP5.getController("TimeSlider").setValue(currentIndex);
    Textlabel timeLabel = (Textlabel) controlP5.get("TimeLabel");
    timeLabel.setText("Date & Time: " + getDateAndTime(currentIndex));
  }
  int currentTime = millis();
  if (currentTime - lastFireworkTime >= fireworkInterval) {
    lastFireworkTime = currentTime;
    fireworkMovement();
    frameCount = 0;
    currentIndex++;
    if (currentIndex > 831) {
      currentIndex = 0;
    }
    hasExploded = false; // Reset hasExploded for the next firework
  }
  int dataIndex = int(currentIndex);
  numberFireworkObjects = peopleCounterData[dataIndex][3];

  // Display the firework
  fireworkMovement();

  int day = peopleCounterData[currentIndex][0];
  int hour = peopleCounterData[currentIndex][1];
  int minute = peopleCounterData[currentIndex][2];
  // units for slider
}

void keyPressed() {
  if (keyCode == UP) {
    volume = constrain(volume + volumeStep, 0, 1);
    out.setVolume(volume);
  } else if (keyCode == DOWN) {
    volume = constrain(volume - volumeStep, 0, 1);
    out.setVolume(volume);
  }
}
