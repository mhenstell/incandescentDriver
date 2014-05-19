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

Rings ringss;

int x = 0;

String transmit_address = "127.0.0.1";
int transmit_port       = 4000;

int CIRCULAR = 0;
int RANDOM = 1;

Routine[] enabledRoutines = new Routine[]
{
  new Waves(),
  new CircularWaves(),
  new Orrery(),
  new Random(CIRCULAR, 2),
  new Random(RANDOM, 3),
  new Radar(),
};

Routine currentRoutine = null;

void setup()
{
//  frameRate(10);
  size(400, 400);
  colorMode(RGB, 255);

  smooth();

  for (int i = 0; i < NUM_RINGS; i++)
  {
    NUM_BULBS += RING_BULBS[i];
  }

  PACKET_LENGTH = NUM_BULBS + 1;

  ringss = new Rings(this, transmit_address, transmit_port);

  ringss.addRing(MAX_RADIUS - (RING_WIDTH * 0), RING_BULBS[0]);
  ringss.addRing(MAX_RADIUS - (RING_WIDTH * 1.5), RING_BULBS[1]);
  ringss.addRing(MAX_RADIUS - (RING_WIDTH * 3), RING_BULBS[2]);
  ringss.addRing(MAX_RADIUS - (RING_WIDTH * 4.5), RING_BULBS[3]);
  ringss.addRing(0, RING_BULBS[4]);
  //  rings.addRing(MAX_RADIUS - (RING_WIDTH * 6), RING_BULBS[4]);
  
  currentRoutine = enabledRoutines[5];
}

void draw()
{
  background(0);

 

  if (currentRoutine != null)
  {
    currentRoutine.draw();
  }

  ringss.update();

  ringss.draw();
}

