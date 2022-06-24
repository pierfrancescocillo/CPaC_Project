class Region {
  //used for the Volume for the determination of the ycord
  float avgy;
  //Array of pixels belonging to that region
  ArrayList<PVector> pixs;

  Region(int x, int y) {
   pixs = new ArrayList<PVector>();
   pixs.add(new PVector(x, y));
  }

//To visualize the tracked pixels
  void show(color tracked, Capture cam) {
    
 for (PVector p : pixs) {
      stroke(tracked);
      //take into account the camera space to draw the pixels
      point((p.x*width/2)/cam.width, (p.y* height)/cam.height);
    }
    
  }
//To add pixels to a region
  void add(int x, int y) {
    pixs.add(new PVector(x, y));
    avgy+=y;
  }

//To determine if a pixel belongs or nt to a region

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
