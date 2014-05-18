class DemoTransmitter extends Thread {

  int[] activeBulb = new int[NUM_RINGS];

  DemoTransmitter() {
  }

  int[] makeDemoFrame()
  {
    int[] imageData = new int[NUM_BULBS + 1];

    imageData[0] = 1;
    int startNum = 1;
    for (int r = 0; r < NUM_RINGS; r++)
    {
 
      for (int i = 0; i < RING_BULBS[r]; i++)
      {
        int alpha = 50;
        if (i == activeBulb[r]) alpha = 255;
        imageData[startNum + i] = alpha;
      }
      activeBulb[r] += 1;
      if (activeBulb[r] >= RING_BULBS[r]) activeBulb[r] = 0;
      startNum += RING_BULBS[r];
    }



    return imageData;
  }

  void run() {
//    while (demoMode) {
//      try {
//
//        if (newImageQueue.size() < 1)
//        {
//          int[] imageData = makeDemoFrame();
//          newImageQueue.put(imageData);
//        }
//
//        Thread.sleep(0);
//      }
//      catch (InterruptedException e) {
//        println("Interrupted Exception caught");
//      }
//    }
  }
}

