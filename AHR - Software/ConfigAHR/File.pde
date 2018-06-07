
// This event function is called when the button 'save' is clicked
public void saveParams() {

  // Creates a new file
  outputFile = createWriter("..\\AirHockeyRobot\\params.txt");

  // Writes in the created file
  outputFile.println("PUCK");
  outputFile.print(threshPuckHSB[H].getLowValue() + "*" + threshPuckHSB[H].getHighValue() + "|");
  outputFile.print(threshPuckHSB[S].getLowValue() + "*" + threshPuckHSB[S].getHighValue() + "|");
  outputFile.println(threshPuckHSB[B].getLowValue() + "*" + threshPuckHSB[B].getHighValue());
  outputFile.println("ROBOT");
  outputFile.print(threshRobotHSB[H].getLowValue() + "*" + threshRobotHSB[H].getHighValue() + "|");
  outputFile.print(threshRobotHSB[S].getLowValue() + "*" + threshRobotHSB[S].getHighValue() + "|");
  outputFile.println(threshRobotHSB[B].getLowValue() + "*" + threshRobotHSB[B].getHighValue());
  outputFile.println("POLYGON");
  outputFile.print((viewArea.points[0].x-MARGIN) + "*" + (viewArea.points[0].y-MARGIN) + "|");
  outputFile.print((viewArea.points[1].x-MARGIN) + "*" + (viewArea.points[1].y-MARGIN) + "|");
  outputFile.print((viewArea.points[2].x-MARGIN) + "*" + (viewArea.points[2].y-MARGIN) + "|");
  outputFile.print((viewArea.points[3].x-MARGIN) + "*" + (viewArea.points[3].y-MARGIN));  


  outputFile.flush(); // Write the remaining data
  outputFile.close(); // Finish the file
}


// This event function is called when the button 'load' is clicked
public void loadParams() {
  String[] lines = loadStrings("..\\AirHockeyRobot\\params.txt");
  String param = new String();

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim().equals("PUCK")) {
      param = "puck";
    } else if (lines[i].trim().equals("ROBOT")) {
      param = "robot";
    } else if(lines[i].trim().equals("POLYGON")){
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

      }else if(param.equals("poly")){
        
        String[] points = split(lines[i], '|');
        
        for(int p = 0; p < points.length; p++){
         String[] values = split(points[p], '*');
          
         viewArea.points[p].x = Integer.parseInt(values[0])+MARGIN;
         viewArea.points[p].y = Integer.parseInt(values[1])+MARGIN;
        }
        
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