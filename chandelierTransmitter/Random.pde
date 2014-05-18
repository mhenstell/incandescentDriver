

class Random extends Routine
{
  int speed = 3;
  int fills[][] = new int[NUM_RINGS][128];

  int mode = RANDOM;

  Random(int mode, int speed)
  {
    this.mode = mode;
    this.speed = speed;
  }

  void draw()
  {
    for (int i = 0; i < NUM_RINGS; i++)
    {
      Ring ring = ringss.rrings.get(i);
      float radius = ring.radius;

      for (int bulb = 0; bulb < ring.numBulbs; bulb++)
      {
        fill(fills[i][bulb]);
        float angle = (TWO_PI / ring.numBulbs) * bulb;
        int x = int((width / 2) + (cos(angle) * radius) / 2);
        int y = int((height / 2) + (sin(angle) * radius) / 2);

        ellipse(x, y, 8, 8);
      }
    }

    if (frameCount % speed == 0) {
      if (this.mode == RANDOM) {
        for (int ring = 0; ring < NUM_RINGS; ring++)
        {
          for (int bulb = 0; bulb < ringss.rrings.get(ring).numBulbs; bulb++)
          {
            fills[ring][bulb] = int(random(255));
          }
        }
      }
      else if (this.mode == CIRCULAR) {
        for (int ring = 0; ring < NUM_RINGS; ring++)
        {
          int fill = int(random(255));
          for (int bulb = 0; bulb < ringss.rrings.get(ring).numBulbs; bulb++)
          {
            fills[ring][bulb] = fill;
          }
        }
      }
    }
  }
}

