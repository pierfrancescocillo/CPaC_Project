class Region {
  float avgy;
  ArrayList<PVector> pixs;

  Region(int x, int y) {
   pixs = new ArrayList<PVector>();
   pixs.add(new PVector(x, y));
  }

  void show(color tracked, Capture cam) {
    
 for (PVector p : pixs) {
      stroke(tracked);
      point((p.x*width/2)/cam.width, (p.y* height)/cam.height);
    }
    
  }

  void add(int x, int y) {
    pixs.add(new PVector(x, y));
    avgy+=y;
  }



  boolean isNear(int x, int y) {
    float d = 10000000;
    for (PVector p : pixs) {
        float tempD = dist(x, y, p.x, p.y);
      if (tempD < d) {
        d = tempD;
      }
    }

    if (d < distThreshold) {
      return true;
    } else {
      return false;
    }
  }
}
