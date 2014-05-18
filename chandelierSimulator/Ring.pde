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
    noStroke();

    for (int x = 0; x < numBulbs; x++)
    {
      
      fill(255, 255, 200, ringData[x]);
      
      float angle = (TWO_PI / numBulbs) * x;
      
      
      ellipse((width / 2) + (cos(angle) * radius) / 2, (height / 2) + (sin(angle) * radius) / 2, 10, 10);

    }
  }
}

