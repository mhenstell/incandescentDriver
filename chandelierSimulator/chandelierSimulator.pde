import peasy.*;
import javax.media.opengl.GL;
import processing.opengl.*;
import java.util.concurrent.*;
import hypermedia.net.*;

PeasyCam pCamera;
UDP udp;

int HEIGHT_RANGE = 10;
int BULB_DIAMETER = 3;
int SPHERE_FACETS = 20;
int MAX_RADIUS = 61;
int RING_WIDTH = 8;
float SPEED = 0.05;

int NUM_RINGS = 5;
int[] RING_BULBS = {
  95, 70, 50, 30, 15
};

//int RING1_BULBS = 95;
//int RING2_BULBS = 70;
//int RING3_BULBS = 50;
//int RING4_BULBS = 30;
//int RING5_BULBS = 15;


int NUM_BULBS = RING_BULBS[0] + RING_BULBS[1] + RING_BULBS[2] + RING_BULBS[3] + RING_BULBS[4];
int PACKET_LENGTH = NUM_BULBS + 1;

BlockingQueue newImageQueue;
Rings rings;

Boolean demoMode = true;
DemoTransmitter demoTransmitter;


void setup()
{
  //  frameRate(10);
  size(640, 480, OPENGL);
  colorMode(RGB, 255);

  //  smooth();

  pCamera = new PeasyCam(this, 100);
  pCamera.setMinimumDistance(10);
  pCamera.setMaximumDistance(400);
  //  pCamera.setSuppressRollRotationMode();
  //  pCamera.rotateX(-.4);

  pCamera.setWheelScale(0.01);

  pCamera.lookAt(316, 243, -100);
  pCamera.setDistance(200);

  rings = new Rings();

  rings.addRing(MAX_RADIUS - (RING_WIDTH * 0), RING_BULBS[0]);
  rings.addRing(MAX_RADIUS - (RING_WIDTH * 1.5), RING_BULBS[1]);
  rings.addRing(MAX_RADIUS - (RING_WIDTH * 3), RING_BULBS[2]);
  rings.addRing(MAX_RADIUS - (RING_WIDTH * 4.5), RING_BULBS[3]);
  rings.addRing(MAX_RADIUS - (RING_WIDTH * 6), RING_BULBS[4]);

  newImageQueue = new ArrayBlockingQueue(2);


  demoTransmitter = new DemoTransmitter();
  demoTransmitter.start();
}

void receive(byte[] data, String ip, int port) {  
  //println(" new datas!");

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

  for (int i=0; i< NUM_BULBS; i++) {
    newImage[i] = data[i + 1];
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
  background(0);



  if (newImageQueue.size() > 0)
  {
    int[] newImage = (int[])newImageQueue.remove();
    rings.update(newImage);
    rings.draw();
  }

  pCamera.beginHUD();

  fill(255);
  rect(width - 80, 50, 55, 200);

  for (int i = 0; i < NUM_RINGS; i++)
  {
    fill(0);
    rect((width - 100) + (10 * i) + 25, 60, 5, 180);
    fill(255);
    float y = map(rings.rings.get(i).sinSize, -1, 1, 235, 65);
    rect((width - 100) + (10 * i) + 25, y, 5, 3);
  }

  pCamera.endHUD();
}

