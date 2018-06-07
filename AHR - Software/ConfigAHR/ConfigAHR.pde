import processing.video.Capture;
import controlP5.*;
import gab.opencv.*;
import java.awt.Rectangle;


Capture camera;

OpenCV opencv;
ArrayList<Contour> contours;

PImage imageMirror;
Threshold threshPuck;
Threshold threshRobot;

ControlP5 views;
Range[] threshPuckHSB;
Range[] threshRobotHSB;
Button btnSave, btnLoad;

PrintWriter outputFile;

Rect viewArea;

public void settings() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
}

public void setup() {
  background(COLOR_BACKGROUND);

  views = new ControlP5(this);
  threshPuckHSB = new Range[3];
  threshRobotHSB = new Range[3];

  initViews();

  imageMirror = new PImage(CAMERA_WIDTH, CAMERA_HEIGHT);
  threshPuck  = new Threshold(imageMirror, threshPuckHSB);
  threshRobot = new Threshold(imageMirror, threshRobotHSB);

  camera = new Capture(this, CAMERA_WIDTH, CAMERA_HEIGHT, EXTERNAL_CAM);
  camera.start();

  opencv = new OpenCV(this, CAMERA_WIDTH, CAMERA_HEIGHT);
  contours = new ArrayList<Contour>();

  viewArea = new Rect(
    new Point(280+MARGIN, 260+MARGIN), 
    new Point(340+MARGIN, 260+MARGIN), 
    new Point(340+MARGIN, 200+MARGIN), 
    new Point(280+MARGIN, 200+MARGIN));
    
    colorMode(HSB, 360, 100, 100);
}

public void draw() {
  background(COLOR_BACKGROUND);

  threshRobot.processThreshold();
  threshPuck.processThreshold();

  drawImages();

  // Load the new frame for OpenCV
  opencv.loadImage(threshPuck);

  // Find contours in threshold image
  contours = opencv.findContours(true, true);

  if (contours.size() > 0) {
    Contour biggestContour = contours.get(0);

    Rectangle r = biggestContour.getBoundingBox();

    noFill(); 
    strokeWeight(2); 
    stroke(#FF0000);
    rect(r.x + 10, r.y + 10, r.width, r.height);
  }

  // Load the new frame for OpenCV
  opencv.loadImage(threshRobot);

  // Find contours in threshold image
  contours = opencv.findContours(true, true);

  if (contours.size() > 0) {
   Contour biggestContour = contours.get(0);

   Rectangle r = biggestContour.getBoundingBox();

   noFill(); 
   strokeWeight(2); 
   stroke(#FF0000);
   rect(r.x + 10, r.y + 10, r.width, r.height);
  }  

  viewArea.draw();
}


// This event function is called when a new camera frame is available
public void captureEvent(Capture camera) {
  // Reading new frame
  camera.read();

  // Loads pixels in image array
  camera.loadPixels();    

  // Calculates image size
  int size = camera.width * camera.height;

  // Loop to mirror image
  for (int i = 0; i < size; i++) {
    int lin = (int) i / camera.width;
    int col = (int) i % camera.width;

    imageMirror.pixels[i] = camera.pixels[((camera.width-1)-col) + lin*camera.width];
  }

  // Update image array, now mirrored
  imageMirror.updatePixels();
}


// This function draws the images in window
public void drawImages() {
  fill(#FFFFFF);
  smooth();
  textSize(15);
  textAlign(CENTER);
  text("Threshold Puck", WINDOW_WIDTH*5/8, WINDOW_HEIGHT/4);
  text("Threshold Robot",  WINDOW_WIDTH*7/8, WINDOW_HEIGHT/4);
  
  image(imageMirror, MARGIN, MARGIN, CAMERA_WIDTH, CAMERA_HEIGHT);
  pushMatrix();
  scale(0.5);
  image(threshPuck, 660*2, 250*2, CAMERA_WIDTH, CAMERA_HEIGHT);
  image(threshRobot, 990*2, 250*2, CAMERA_WIDTH, CAMERA_HEIGHT);
  popMatrix();
}


// This function setups and draws the ControlP5 objects in window
public void initViews() {
  int xPuck = 660, yPuck = 130;
  int xRobot = 990, yRobot = 130;  
  int w = 310, h = 30;

  // ********** Range Puck ******************
  threshPuckHSB[H] = views.addRange("Hp")
    .setCaptionLabel("H")
    .setPosition(xPuck, yPuck)
    .setSize(w, h)
    .setHandleSize(20)
    .setRange(0, 360)
    .setRangeValues(0, 360);

  threshPuckHSB[S] = views.addRange("Sp")
    .setCaptionLabel("S")
    .setPosition(xPuck, yPuck+h+10)
    .setSize(w, h)
    .setHandleSize(20)
    .setRange(0, 100)
    .setRangeValues(0, 100);

  threshPuckHSB[B] = views.addRange("Bp")
    .setCaptionLabel("B")
    .setPosition(xPuck, yPuck+2*h+2*10)
    .setSize(w, h)
    .setHandleSize(20)
    .setRange(0, 100)
    .setRangeValues(0, 100);
  // =========================================    

  // ********** Range Robot ******************
  threshRobotHSB[H] = views.addRange("Hr")
    .setCaptionLabel("H")
    .setPosition(xRobot, yRobot)
    .setSize(w, h)
    .setHandleSize(20)
    .setRange(0, 360)
    .setRangeValues(0, 360);

  threshRobotHSB[S] = views.addRange("Sr")
    .setCaptionLabel("S")
    .setPosition(xRobot, yRobot+h+10)
    .setSize(w, h)
    .setHandleSize(20)
    .setRange(0, 100)
    .setRangeValues(0, 100);

  threshRobotHSB[B] = views.addRange("Br")
    .setCaptionLabel("B")
    .setPosition(xRobot, yRobot+2*h+2*10)
    .setSize(w, h)
    .setHandleSize(20)
    .setRange(0, 100)
    .setRangeValues(0, 100);
  // =========================================

  // ********** Buttons ******************
  btnSave = views.addButton("saveParams")
    .setLabel("SAVE")
    .setPosition(935, 30)
    .setSize(100, 30)
    ;

  btnLoad = views.addButton("loadParams")
    .setLabel("LOAD")
    .setPosition(935, 70)
    .setSize(100, 30);
  // =========================================
}

void mousePressed() {
  viewArea.click(mouseX, mouseY);
}

void mouseDragged() {
  viewArea.drag(mouseX, mouseY);
}

void mouseReleased() {
  viewArea.release();
}
