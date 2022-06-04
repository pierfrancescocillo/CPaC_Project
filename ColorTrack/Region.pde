class Region {
  float avgx;
  float avgy;
  int minx;
  int miny;
  int maxx;
  int maxy;
  ArrayList<PVector> pixs;

  Region(int x, int y) {
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
   pixs = new ArrayList<PVector>();
   pixs.add(new PVector(x, y));
  }

  void show(color tracked) {
    
 for (PVector p : pixs) {
      stroke(tracked);
      point(p.x, p.y);
    }
    
  }
 // }
  void add(int x, int y) {
    minx = min(minx, x);
    miny = min(miny, y);
    maxx = max(maxx, x);
    maxy = max(maxy, y);
    pixs.add(new PVector(x, y));
    avgx+=x;
    avgy+=y;
  }

  int size() {
    return (maxx-minx)*(maxy-miny);
  }




  boolean isNear(int x, int y) {
    float d = 10000000;
    for (PVector p : pixs) {
        float tempD = distSq(x, y, p.x, p.y);
      if (tempD < d) {
        d = tempD;
      }
    }

    if (d < distThreshold*distThreshold) {
      return true;
    } else {
      return false;
    }
  }
}
