// Method for drawing mirror image in window
public void drawCamera(){
  image(imageMirror, MARGIN, MARGIN, CAMERA_WIDTH, CAMERA_HEIGHT);
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