class CircularWaves extends Routine {

  float x = 0;
  float frequency = 8;
  float speed = 4;
  
  CircularWaves(float speed)
  {
  }
  CircularWaves()
  {
  }

  void draw() {

   for (int i = 0; i < width / 16; i++)
    {
      int brightness = int(map(sin(radians(x + (i * frequency))), -1, 1, 0, 255));
      noFill();
      if (i == 1) fill(brightness);
      stroke(brightness);
      strokeWeight(8);
      ellipse(width / 2, height / 2, i * 16, i * 16);
    }
     x += speed;
  }
}

