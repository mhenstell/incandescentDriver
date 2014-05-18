class Rings
{
  ArrayList<Ring> rrings;
  byte buffer[];
  String address;
  int port;
  UDP udp;
  PApplet parent;

  Rings(PApplet parent, String address, int port) {
    this.rrings = new ArrayList<Ring>();
    this.buffer = new byte[PACKET_LENGTH];
    
    buffer[0] = 1;
    for (int i=1; i<PACKET_LENGTH; i++) {
      buffer[i] = 0;
    }
    
    this.address = address;
    this.port = port;
    this.parent = parent;
    this.udp = new UDP(parent);
  }

  void addRing(float rad, int bulbs)
  {
    Ring ring = new Ring(rad, bulbs);
    rrings.add(ring);
  }

  void update()
  {
    int bufferPos = 1;

    for (int i = 0; i < rrings.size(); i++)
    {
      int[] ringData = rrings.get(i).getData();

      for (int q = 0; q < rrings.get(i).numBulbs; q++)
      {
        buffer[bufferPos] = byte(ringData[q]);
        bufferPos += 1;
      }
    }
  
//   for (int i = 1; i < 11; i++)
//   {
//    println(buffer[i]); 
//   }
    udp.send(buffer, address, port);
  }

  void draw()
  {
    for (int i = 0; i < rrings.size(); i++)
    {
      rrings.get(i).draw();
    }
  }
}

