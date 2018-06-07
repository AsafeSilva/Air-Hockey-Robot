/* ==============================================================
 
 Project name: Air Hockey Robot
 
 Developed By: Protheus Team
 Developed in: IFPE Caruaru [March/2017]
 Members:      
 Asafe dos Santos  [Programming]
 Daniel Queiroz    [Eletronics]   
 Élton Franklin    [Programming]
 Gabriel Tabosa    [Mechanics]
 Luís Gabriel      [Mechanics]
 João              [Eletronics]
 Jonathan          [Programming]
 Lucas Silva       [Programming]
 Rafael            [Marketing]
 Shiriu            [Mechanics]
 
 ================================================================= */

// LIBRARIES
import processing.video.Capture;
import gab.opencv.*;
import java.awt.Polygon;

// Variable that stores camera frames
Capture camera;

// OpenCV variables
OpenCV opencv;
ArrayList<Contour> contours;

// Variables that store images for processing
// 'Threshold' is a project class. [Extends PImage] {Located in "Threshold" file}
PImage imageMirror;
Threshold threshPuck;
Threshold threshRobot;

// 'Range' variables [project class], stores the thresholds of the HSB (Hue, Saturation, Brightness)
// {Located in "Threshold" file}
Range[] threshPuckHSB;
Range[] threshRobotHSB;

// 'Rect' is a project class. {Located in "WorkArea" file}
// 'Polygon' is a java class of the package 'java.awt.Polygon'
Rect viewAreaRect;
Polygon viewAreaPolygon;


public void settings() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
}

public void setup() {
  background(COLOR_BACKGROUND);

  // 'Range' array instanciate
  threshPuckHSB = new Range[3];
  threshRobotHSB = new Range[3];
  for (int i = 0; i < 3; i++) {
    threshPuckHSB[i] = new Range();
    threshRobotHSB[i] = new Range();
  }

  // 'PImage' and 'Threshold' instanciate
  imageMirror = new PImage(CAMERA_WIDTH, CAMERA_HEIGHT);
  threshPuck  = new Threshold(imageMirror, threshPuckHSB);
  threshRobot = new Threshold(imageMirror, threshRobotHSB);

  // 'OpenCV' instanciate
  opencv = new OpenCV(this, CAMERA_WIDTH, CAMERA_HEIGHT);
  contours = new ArrayList<Contour>();

  // 'Capture' instanciate
  camera = new Capture(this, CAMERA_WIDTH, CAMERA_HEIGHT, EXTERNAL_CAM);
  camera.start();

  // 'Polygon' and 'Rect' instanciate
  viewAreaPolygon = new Polygon();
  viewAreaRect = new Rect(
    new Point(280+MARGIN, 260+MARGIN), 
    new Point(340+MARGIN, 260+MARGIN), 
    new Point(340+MARGIN, 200+MARGIN), 
    new Point(280+MARGIN, 200+MARGIN));

  newPosition = new Point();
  lastPosition = new Point();  
  incidenceLine = new Line();
  reflectionLine = new Line();
  intersection1 = new Point();
  intersection2 = new Point();

  // Load parameters saved in 'txt' file
  loadParams();

  // Sets color mode to HSB
  colorMode(HSB, 360, 100, 100);
}

public void draw() {
  background(COLOR_BACKGROUND);

  // Shows the captured images in the window.
  // Frames are read in event funcition [captureEvent(Capture c)], located in "Camera" file.
  // {Located in "Camera" file}
  drawCamera();

  
  // Filters the camera image according with threshold values.
  // {Located in "ImageProcess" file}
  thresholdProcess();
  
  // Uses filtered images to follow objects and detect their position (x, y)
  // Uses algorithm with 'OpenCV' library
  // {Located in "ImageProcess" file}
  trackObjects();


  trajectoryPrediction();

  
  // Draw the table area in the window  
  viewAreaRect.draw();
}
