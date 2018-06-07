// This event function is called when the button 'load' is clicked
public void loadParams() {
  String[] lines = loadStrings("params.txt");
  String param = new String();

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim().equals("PUCK")) {
      param = "puck";
    } else if (lines[i].trim().equals("ROBOT")) {
      param = "robot";
    } else if (lines[i].trim().equals("POLYGON")) {
      param = "poly";
    } else {
      if (param.equals("puck")) {

        String[] hsbPuck = split(lines[i], '|');

        for (int hsb = 0; hsb < hsbPuck.length; hsb++) {
          String[] values = split(hsbPuck[hsb], '*');

          try {
            threshPuckHSB[hsb].setArrayValue(StringArrayToFloatArray(values));
          }
          catch(Exception e) {
            e.printStackTrace();
          }
        }
      } else if (param.equals("robot")) {

        String[] hsbRobot = split(lines[i], '|');

        for (int hsb = 0; hsb < hsbRobot.length; hsb++) {
          String[] values = split(hsbRobot[hsb], '*');

          try {
            threshRobotHSB[hsb].setArrayValue(StringArrayToFloatArray(values));
          }
          catch(Exception e) {
            e.printStackTrace();
          }
        }
      } else if (param.equals("poly")) {

        String[] points = split(lines[i], '|');

        for (int p = 0; p < points.length; p++) {
          String[] values = split(points[p], '*');

          viewAreaRect.points[p].x = Integer.parseInt(values[0])+MARGIN;
          viewAreaRect.points[p].y = Integer.parseInt(values[1])+MARGIN;
          
          viewAreaPolygon.addPoint((int)viewAreaRect.points[p].x, (int)viewAreaRect.points[p].y);
        }
        
        viewAreaRect.setRect(viewAreaRect.points[0], viewAreaRect.points[1], viewAreaRect.points[2], viewAreaRect.points[3]);
      }
    }
  }
}


private float[] StringArrayToFloatArray(String[] str) throws Exception { 
  if (str != null) { 
    float floatarray[] = new float[str.length]; 

    for (int i = 0; i < str.length; i++) 
      floatarray[i] = Float.parseFloat(str[i]);

    return floatarray;
  } 
  return null;
}