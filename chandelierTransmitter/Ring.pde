class Ring {

  float radius;
  int numBulbs;
  int ringData[];
  float sinSize;

  Ring(float rad, int bulbs)
  {
    radius = rad * 6;
    numBulbs = bulbs;
    ringData = new int[numBulbs];
  }

  void update(int[] rd)
  {
    if (ringData.length != numBulbs) {
      println("Ring with radius " + radius + " got the wrong amount of pixel data.");
      println("\tWanted " + numBulbs + " got " + ringData.length); 
      return;
    }

    ringData = rd;
  }

  void draw()
  {

    for (int bulb = 0; bulb < numBulbs; bulb++)
    {
      fill(255, 255, 200, 0);
      stroke(150);
      strokeWeight(1);
      float angle = (TWO_PI / numBulbs) * bulb;
      ellipse((width / 2) + (cos(angle) * radius) / 2, (height / 2) + (sin(angle) * radius) / 2, 10, 10);
    }
  }

  int[] getData()
  {
    int[] ringData = new int[numBulbs];

    PImage image = get();

    image.loadPixels();
    loadPixels();

    for (int bulb = 0; bulb < numBulbs; bulb++)
    {
      float angle = (TWO_PI / numBulbs) * bulb;
      int x = int((width / 2) + (cos(angle) * radius) / 2);
      int y = int((height / 2) + (sin(angle) * radius) / 2);

      int val = int(brightness(image.pixels[y * width + x]));
      ringData[bulb] = val;
    }

    updatePixels();
    return ringData;
  }
}

