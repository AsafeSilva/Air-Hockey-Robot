// ********************** POINT ********************** //
public Point Intercept(Line l1, Line l2) {

  float x = (l2.n - l1.n)/(l1.m - l2.m);
  float y = l1.m*x + l1.n;

  return (new Point(x, y));
}

class Point {
  public float x, y;
  private int radius;

  public Point() {
    setPoint(0, 0);
  }  

  public Point(float x, float y) {
    setPoint(x, y);
    
  }

  public void setPoint(float x, float y) {
    this.x = x;
    this.y = y;
    radius = 30;
  }

  public boolean mouseOver(int x, int y) {
    return (dist(x, y, this.x, this.y) < radius);
  }
}

// ********************** LINE ********************** //
class Line {
  float m, n;

  public Line() {
    m = 0;
    n = 0;
  }

  public Line(Point p1, Point p2) {
    setLine(p1, p2);
  }

  public void setLine(Point p1, Point p2) {
    m = (p1.y - p2.y)/(p1.x - p2.x);
    n = (p1.y - ((p1.y - p2.y)/(p1.x - p2.x))*p1.x);
  }
  
  public void setLine(Point p, float m){
    this.m = m;
    this.n = p.y - m*p.x;
  }
}

// ********************** RECT ********************** //
class Rect {
  Point[] points;
  Line[] lines;
  Point pointToMove;

  public Rect(Point p1, Point p2, Point p3, Point p4) {
    points = new Point[4];
    pointToMove = null;

    lines = new Line[4];

    points[0] = p1;
    points[1] = p2;
    points[2] = p3;
    points[3] = p4;

    for (int i = 0; i < lines.length; i++) {
      lines[i] = new Line(points[i], points[(i+1)%4]);
    }
  }
  
  public void setRect(Point p1, Point p2, Point p3, Point p4) {
    
    points[0] = p1;
    points[1] = p2;
    points[2] = p3;
    points[3] = p4;

    for (int i = 0; i < lines.length; i++) {
      lines[i] = new Line(points[i], points[(i+1)%4]);
    }
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

  public void release() {
    pointToMove = null;
  }
}