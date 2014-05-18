class Waves extends Routine {

  float x = 0;
  Waves(float speed)
  {
  }
  Waves()
  {
  }

  void draw() {
    //    long frame = frameCount - modeFrameStart;

    for (int i = 0; i < width / 4; i++)
    {
      int brightness = int(map(sin(radians(x + i)), -1, 1, 0, 255));
      noStroke();
      fill(brightness);
      rect(i * 4, 0, 4, height);
     
    }
     x += 4;
  }
}

