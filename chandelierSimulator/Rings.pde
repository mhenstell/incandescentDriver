class Rings
{
  ArrayList<Ring> rings;
  float x = 0;


  Rings() {
    rings = new ArrayList<Ring>();
  }

  void addRing(float rad, int bulbs)
  {
    Ring ring = new Ring(rad, bulbs);
    rings.add(ring);
  }

  void update(int[] newImage)
  {
    int startNum = 1;
    for (int i = 0; i < rings.size(); i++)
    {  
      int numBulbs = rings.get(i).numBulbs;
      int ringData[] = new int[numBulbs];

      for (int x = 0; x < numBulbs; x++)
      {
        ringData[x] = newImage[startNum + x];
      }
      
      rings.get(i).update(ringData);

      startNum += numBulbs;
    }
  }

  void draw()
  {
    for (int i = 0; i < rings.size(); i++)
    {
      rings.get(i).draw(sin(x + (30 * i)));
    }

    x += SPEED;
  }
}

