
import java.awt.Rectangle;

public void thresholdProcess() {
  threshRobot.processThreshold();
  threshPuck.processThreshold();
}

public void trackObjects() {  
  // Load the new frame for OpenCV
  opencv.loadImage(threshPuck);

  // Find contours in threshold image
  contours = opencv.findContours(true, true);

  if (contours.size() > 0) {
    Contour biggestContour = contours.get(0);

    Rectangle r = biggestContour.getBoundingBox();

    if (viewAreaPolygon.contains(r) && r.width > OBJECT_WIDTH_MIN && r.height > OBJECT_HEIGHT_MIN) {
      puckCoordX = (int) (r.x + r.width/2);
      puckCoordY = (int) (r.y + r.height/2);

      noFill(); 
      strokeWeight(2); 
      stroke(#FF0000);
      rect(r.x + 10, r.y + 10, r.width, r.height);
    } else {
      puckCoordX = 0;
      puckCoordY = 0;
    }
  }

  //// Load the new frame for OpenCV
  //opencv.loadImage(threshRobot);

  //// Find contours in threshold image
  //contours = opencv.findContours(true, true);

  //if (contours.size() > 0) {
  //  Contour biggestContour = contours.get(0);

  //  Rectangle r = biggestContour.getBoundingBox();

  //  if (viewAreaPolygon.contains(r) && r.width > OBJECT_WIDTH_MIN && r.height > OBJECT_HEIGHT_MIN) {
  //    robotCoordX = (int) (r.x + r.width/2);
  //    robotCoordY = (int) (r.y + r.height/2);

  //    noFill(); 
  //    strokeWeight(2); 
  //    stroke(#FF0000);
  //    rect(r.x + 10, r.y + 10, r.width, r.height);
  //  } else {
  //    robotCoordX = 0;
  //    robotCoordY = 0;
  //  }
  //}
}