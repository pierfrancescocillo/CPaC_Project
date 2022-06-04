import processing.video.*;
import netP5.*;
import oscP5.*;
OscP5 oscP5;

NetAddress myRemoteLocation;

Capture cam;
//Pix p;

color VoltrackColor; 
color FreqtrackColor;
float thresholdVol = 110;
float thresholdFreq = 175;
float distThreshold = 50;
float C3=130.81;
float C6=1046.5;
float MaxVol=1.0;
float MinVol=0.0;
float MaxVolPix;
float MinVolPix;
boolean one;
int C3pix;
int C6pix;
ArrayList<Region> VolRegion = new ArrayList<Region>();
ArrayList<Region> FreqRegion = new ArrayList<Region>();
void setup() {
  size(640, 480);
  String[] cams = Capture.list();
  if(cams.length==0){
    println("No cameras= (");
    exit();}
    println("Avaiable cameras:");
    for(int i=0; i<cams.length;i++){
      println(i, cams[i]);}
  cam= new Capture(this, cams[0]);
  cam.start();
  VoltrackColor = color(50,205,50);
  //VoltrackColor = color(0,0,255);
 // FreqtrackColor=color(153,153,0);
 FreqtrackColor=color(0,0,255);
  oscP5= new OscP5(this,57120);
  myRemoteLocation= new NetAddress("127.0.0.1", 57120);
  C3pix=(int)(cam.width*cam.height/512);
  //println(C3pix+"blbl" + cam.width + "hjh" + cam.height);
  C6pix=(int)(cam.width*cam.height/51.2);
  MaxVolPix=(float)(cam.height*0.1);
  MinVolPix=(float)(cam.height*0.9);
}

void captureEvent(Capture cam) {
 if (!cam.available()) {return;}
  cam.read();
}

void draw() {
  
  cam.loadPixels();
  image(cam, 0, 0);
VolRegion.clear();
FreqRegion.clear();
one=false;
      float rV = red(VoltrackColor);
      float gV = green(VoltrackColor);
      float bV = blue(VoltrackColor);
      float rF = red(FreqtrackColor);
      float gF = green(FreqtrackColor);
      float bF = blue(FreqtrackColor);
  // Begin loop to walk through every pixel
  for (int x = 0; x < cam.width; x++ ) {
    for (int y = 0; y < cam.height; y++ ) {
      int loc = x + y * cam.width;
      // What is current color
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);

      if (distSq(r1, g1, b1, rV, gV, bV) < thresholdVol*thresholdVol) {
        Belong(x, y, VolRegion);
      }
      
   if (distSq(r1, g1, b1, rF, gF, bF) < thresholdFreq*thresholdFreq) {
       Belong(x, y, FreqRegion); 
   }
      }
  }

    float Vol=0;
    for (Region r : VolRegion){
    if ((r.pixs.size() > 500)) {
          r.avgx = r.avgx / r.pixs.size();
    r.avgy = r.avgy / r.pixs.size();
    //println(r.avgx +"blblb"+ r.avgy);
    r.show(VoltrackColor);
    if((r.avgy>MaxVolPix)&&(r.avgy<=MinVolPix)){
    Vol=(r.avgy-MinVolPix)/(MaxVolPix-MinVolPix)*(MaxVol-MinVol)+MinVol;
    }
    else {
      Vol=0;
    }
    //println(Vol);
    /*
    
    fill(VoltrackColor);
    strokeWeight(4.0);
    stroke(0);
    ellipse(r.avgx, r.avgy, 24, 24);
    */
/*
  OscMessage myMessage1 = new OscMessage("/Vol");
  myMessage1.add(Vol);
  oscP5.send(myMessage1,myRemoteLocation);
  */
    }
    }
     float Freq=0;
    for (Region r : FreqRegion){
    int PixCount=r.pixs.size();  
    if ((r.pixs.size() > 550)&&((r.pixs.size()<6500))) {
      r.avgx = r.avgx / r.pixs.size();
      r.avgy = r.avgy / r.pixs.size();
      r.show(FreqtrackColor);
     
     Freq=(((float)r.pixs.size()-(float)C3pix)/((float)C6pix-(float)C3pix))*(C6-C3)+C3;
    // println("length:"+ r.pixs.size()+ "Freq" + Freq);
    /*
    fill(FreqtrackColor);
    strokeWeight(4.0);
    stroke(0);
    ellipse(r.avgx, r.avgy, 24, 24);
    */
    OscMessage myMessage2 = new OscMessage("/ciao");
    myMessage2.add(Freq);
    myMessage2.add(Vol);
    oscP5.send(myMessage2,myRemoteLocation);
    
}
    }
  }


/*
       void Display(ArrayList <Region> Reg, color tracked){
   for (Region r : Reg){
    if ((r.pixs.size() > 200)) {
          r.avgx = r.avgx / r.pixs.size();
    r.avgy = r.avgy / r.pixs.size();
    r.show(tracked);
    
    fill(tracked);
    strokeWeight(4.0);
    stroke(0);
    ellipse(r.avgx, r.avgy, 24, 24);
     
    }
   }
    }*/
    

  /*
    for (Blob b : region2) {
    if (b.size() > 10) {
      b.show(trackColor2);
    }
  }*/
//}

  /*
  OscMessage myMessage1 = new OscMessage("/count");
 
  myMessage1.add(count);

  oscP5.send(myMessage1,myRemoteLocation);
  println(count);
  
    OscMessage myMessage2 = new OscMessage("/locX");
 
  myMessage2.add(avgX);

  oscP5.send(myMessage2,myRemoteLocation);
  println(avgX);
  
  OscMessage myMessage3 = new OscMessage("/locY");
 
  myMessage3.add(avgY);

  oscP5.send(myMessage3,myRemoteLocation);
  println(avgY);
 */ 
  /*
   boolean Neighbour(float x, float y, float xprec, float yprec, float r1, float g1, float b1, float r, float g, float b) {
     if((x==xprec+1)||(y==yprec+1)||(x==xprec-1)||(y==yprec-1)||((x==xprec)&&(y==yprec))){
       if(distSq(r1, g1, b1, r, g, b) < threshold*threshold){
       return true;
     } 
     }
     else {
      return false;
    }
}

*/
void Belong(int x, int y, ArrayList<Region> Reg){
        boolean found=false;
        for(Region r: Reg){
          if (r.isNear(x, y)) {
            r.add(x, y);
            //one=true;
            //println(b.count);
            found = true;
            break;
          }
        }
        if ((!found)) {
          Region r= new Region(x, y);
          Reg.add(r);
          //b.count=0;
          //println(count);
        }
      }
float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}
