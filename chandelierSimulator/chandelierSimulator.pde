import java.util.concurrent.*;
import hypermedia.net.*;

UDP udp;

int HEIGHT_RANGE = 10;
int BULB_DIAMETER = 3;
int SPHERE_FACETS = 20;
int MAX_RADIUS = 61;
int RING_WIDTH = 8;
float SPEED = 0.05;

int NUM_RINGS = 5;
int[] RING_BULBS = {
  52, 40, 32, 24, 1
};

int NUM_BULBS = 0;
int PACKET_LENGTH = 0;

BlockingQueue newImageQueue;
Rings rings;

Boolean demoMode = true;
DemoTransmitter demoTransmitter;

int maxConvertedByte = 0;

int convertByte(byte b) {
  int c = (b<0) ? 256+b : b;

  if (c > maxConvertedByte) {
    maxConvertedByte = c;
    println("Max Converted Byte is now " + c);
  }  
  
  return c;
}

void setup()
{
  //  frameRate(10);
  //  size(640, 480, OPENGL);
  size(640, 480);
  colorMode(RGB, 255);

  smooth();

  for (int i = 0; i < NUM_RINGS; i++)
  {
    NUM_BULBS += RING_BULBS[i];
  }

  PACKET_LENGTH = NUM_BULBS + 1;

  rings = new Rings();

  rings.addRing(MAX_RADIUS - (RING_WIDTH * 0), RING_BULBS[0]);
  rings.addRing(MAX_RADIUS - (RING_WIDTH * 1.5), RING_BULBS[1]);
  rings.addRing(MAX_RADIUS - (RING_WIDTH * 3), RING_BULBS[2]);
  rings.addRing(MAX_RADIUS - (RING_WIDTH * 4.5), RING_BULBS[3]);
  rings.addRing(0, 1);
  //  rings.addRing(MAX_RADIUS - (RING_WIDTH * 6), RING_BULBS[4]);

  newImageQueue = new ArrayBlockingQueue(2);

  udp = new UDP( this, 58082 );
  udp.listen( true );


  //  demoTransmitter = new DemoTransmitter();
  //  demoTransmitter.start();

  background(0);
}

void receive(byte[] data, String ip, int port) {  
//  println(" new datas!");

  if (demoMode)
  {
  }

  if (data[0] != 1) {
    println("Packet header mismatch. Expected 1, got " + data[0]);
    return;
  }

  if (data.length != PACKET_LENGTH) {
    println("Packet size mismatch. Expected "+PACKET_LENGTH+", got " + data.length);
    return;
  }

  if (newImageQueue.size() > 0) {
    println("Buffer full, dropping frame!");
    return;
  }
  
  int[] newImage = new int[NUM_BULBS];

  for (int i=1; i< NUM_BULBS; i++) {
    newImage[i] = convertByte(data[i + 1]);
  }
  try { 
    newImageQueue.put(newImage);
  } 
  catch( InterruptedException e ) {
    println("Interrupted Exception caught");
  }
}

void draw()
{


  if (newImageQueue.size() > 0)
  {
    background(0);
    int[] newImage = (int[])newImageQueue.remove();
    rings.update(newImage);
    rings.draw();
  }
}

