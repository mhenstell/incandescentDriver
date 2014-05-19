class Radar extends Routine
{
  int speed = 2;
  float angle = 0;

  void draw()
  {
    pushMatrix();
    translate(width / 2, height / 2);
    rotate(angle);
    //    rect(0, 0, height, 30);
    fill(255);
    triangle(10, 10, -20, height / 2, 20, height / 2);
    fill(100);
    triangle(10, 10, 50, (height / 2), 20, (height / 2));
//    fill(50);
//    triangle(10, 10, 80, (height / 2), 10, (height / 2));

    fill(int(map(sin(angle), -1, 1, 0, random(100, 255))));
    ellipse(0, 0, 10, 10);
    popMatrix();

    angle += 0.1;
  }
}

