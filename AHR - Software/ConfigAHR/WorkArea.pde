class Point {
  public int x, y;
  private int radius;

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
    radius = 30;
  }

  public boolean mouseOver(int x, int y) {
    return (dist(x, y, this.x, this.y) < radius);
  }
}

class Rect {
  Point[] points;
  Point pointToMove;

  public Rect(Point p1, Point p2, Point p3, Point p4) {
    points = new Point[4];
    pointToMove = null;

    points[0] = p1;
    points[1] = p2;
    points[2] = p3;
    points[3] = p4;
  }

  public void draw() {

    fill(#1F1E1D, 70);
    noStroke();
    ellipse(points[0].x, points[0].y, points[0].radius, points[0].radius);
    ellipse(points[1].x, points[1].y, points[1].radius, points[1].radius);
    ellipse(points[2].x, points[2].y, points[2].radius, points[2].radius);
    ellipse(points[3].x, points[3].y, points[3].radius, points[3].radius);    

    fill(#FC9800);
    ellipse(points[0].x, points[0].y, 10, 10);
    ellipse(points[1].x, points[1].y, 10, 10);
    ellipse(points[2].x, points[2].y, 10, 10);
    ellipse(points[3].x, points[3].y, 10, 10);    

    strokeWeight(2);
    stroke(#FC9800);
    line(points[0].x, points[0].y, points[1].x, points[1].y);
    line(points[1].x, points[1].y, points[2].x, points[2].y);
    line(points[2].x, points[2].y, points[3].x, points[3].y);
    line(points[3].x, points[3].y, points[0].x, points[0].y);

    textSize(20);
    //fill(255);
    text("p1", points[0].x - 20, points[0].y - 10);
    text("p2", points[1].x - 20, points[1].y - 10);
    text("p3", points[2].x - 20, points[2].y - 10);
    text("p4", points[3].x - 20, points[3].y - 10);
  }

  public void click(int x, int y) {
    for (int i = 0; i < points.length; i++) {
      if (points[i].mouseOver(x, y)) {
        pointToMove = points[i];
      }
    }
  }

  public void drag(int x, int y) {
    if (pointToMove != null) {
      pointToMove.x = x;
      pointToMove.y = y;
    }
  }
  
  public void release(){
    pointToMove = null;
  }
}