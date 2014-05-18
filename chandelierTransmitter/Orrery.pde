class Orrery extends Routine
{
  int speed = 2;
  int currentBulbs[] = new int[NUM_RINGS];

  void draw()
  {
    for (int i = 0; i < NUM_RINGS; i++)
    {
      Ring ring = ringss.rrings.get(i);
      float radius = ring.radius;

      for (int bulb = 0; bulb < ring.numBulbs; bulb++)
      {
        if (bulb == currentBulbs[i]) fill(255);
        else if ((bulb == currentBulbs[i] - 1) || (currentBulbs[i] == 0 && bulb == ring.numBulbs - 1)) fill(100);
        else if ((bulb == currentBulbs[i] - 2) || (currentBulbs[i] == 0 && bulb == ring.numBulbs - 2) || (currentBulbs[i] == 1 && bulb == ring.numBulbs - 1)) fill(50);
        
        else fill(0);
        float angle = (TWO_PI / ring.numBulbs) * bulb;
        int x = int((width / 2) + (cos(angle) * radius) / 2);
        int y = int((height / 2) + (sin(angle) * radius) / 2);

        ellipse(x, y, 8, 8);
      }
      
      if (frameCount % speed == 0) {
        currentBulbs[i] += 1;
        if (currentBulbs[i] == ring.numBulbs) currentBulbs[i] = 0;
      }
    }
  }
}

