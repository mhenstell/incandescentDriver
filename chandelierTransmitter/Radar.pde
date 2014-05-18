class Radar extends Routine
{
  int speed = 2;
  float angle = 0;

  void draw()
  {
    pushMatrix();
    fill(255);
    translate(width / 2, height / 2);
    rotate(angle);
    //    rect(0, 0, height, 30);
    triangle(0, 0, -20, height / 2, 20, height / 2);

    popMatrix();

    angle += 0.1;
  }
}

