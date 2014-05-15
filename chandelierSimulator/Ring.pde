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

  void draw(float size)
  {
//    float radius = map(size, -1, 1, minRad, maxRad);
//    float alpha = map(size, -1, 1, 100, 255);
//    float bulbDiameter = map(size, -1, 1, 20 / 1.1, 20 * 1.1);
    sinSize = size;
//    lights();
//    sphereDetail(SPHERE_FACETS);
    noStroke();

    //    stroke(0, 0, 0, 0);
    //    fill(255, 255, 255, alpha / 8);
    //    ellipse(width / 2, height / 2, radius * 1.1, radius * 1.1);
    //    fill(0); 
    //    ellipse(width / 2, height / 2, radius / 1.1, radius / 1.1);
    
//    float z = (HEIGHT_RANGE / 2) - (size * HEIGHT_RANGE);
    
    for (int x = 0; x < numBulbs; x++)
    {
      
      fill(255, 255, 200, ringData[x]);
      
      float angle = (TWO_PI / numBulbs) * x;
      //      ellipse(((width / 2) + (cos(angle) * radius) / 2), (height / 2) + (sin(angle) * radius) / 2, bulbDiameter, bulbDiameter);
      
      pushMatrix();
//      translate(((width / 2) + (cos(angle) * radius) / 2), (height / 2) + (sin(angle) * radius) / 2, z);
      translate(((width / 2) + (cos(angle) * radius) / 2), (height / 2) + (sin(angle) * radius) / 2);

//      sphere(BULB_DIAMETER / 2);
      ellipse(0, 0, 10, 10);
      popMatrix();

    }
  }
}

