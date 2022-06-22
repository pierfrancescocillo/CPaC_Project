import processing.video.*;
import netP5.*;
import oscP5.*;
OscP5 oscP5;

NetAddress myRemoteLocation;
///COLOR TRACK PART
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


//GAME OF LIFE PART
GOL gol;

int add_pix = 5;

int nota;

void setup() {
  //COLOR TRACK PART
  size(1024, 600);
  //fullScreen();
 /* String[] cams = Capture.list();
  if(cams.length==0){
    println("No cameras= (");
    exit();}
    println("Avaiable cameras:");
    for(int i=0; i<cams.length;i++){
      println(i, cams[i]);}
  cam= new Capture(this, cams[0]);*/
  cam=new Capture(this,width,height,30);
  cam.start();
  VoltrackColor = color(50,198,50);
  //VoltrackColor = color(80,200,120);
 // FreqtrackColor=color(153,153,0);
 FreqtrackColor=color(0,0,255);
  oscP5= new OscP5(this,57120);
  myRemoteLocation= new NetAddress("127.0.0.1", 57120);
  C3pix=(int)(cam.width*cam.height/512);
  C6pix=(int)(cam.width*cam.height/51.2);
  println(C3pix + "blbl" + C6pix);
  MaxVolPix=(float)(cam.height*0.1);
  MinVolPix=(float)(cam.height*0.9);
  //GAME OF LIFE
  
   //GOL---------------
  frameRate(20);
  smooth();
  gol = new GOL();
  //------------------
  
}

void captureEvent(Capture cam) {
 if (!cam.available()) {return;}
  cam.read();
}

void draw() {
  //COLOR TRACK PART
 // cam.read();
  background(200);
  cam.loadPixels();
  image(cam, 0, 0, width/2, height);
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
      int loc = x + y *cam.width;
      // What is current color
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);

      if (dist(r1, g1, b1, rV, gV, bV) < thresholdVol) {
        Belong(x, y, VolRegion);
      }
      
   if (dist(r1, g1, b1, rF, gF, bF) < thresholdFreq) {
       Belong(x, y, FreqRegion); 
   }
      }
  }

    float Vol=0;
    for (Region r : VolRegion){
       if ((r.pixs.size() > 500)) {
           r.avgy = r.avgy / r.pixs.size();
           r.show(VoltrackColor, cam);
           if((r.avgy>MaxVolPix)&&(r.avgy<=MinVolPix)){
              Vol=(r.avgy-MinVolPix)/(MaxVolPix-MinVolPix)*(MaxVol-MinVol)+MinVol;
           }
           else {
           Vol=0;
           }
        }
    }
     float Freq=0;
    for (Region r : FreqRegion){
      if ((r.pixs.size() > 550)&&((r.pixs.size()<6500))) {
      r.show(FreqtrackColor, cam);
      Freq=(((float)r.pixs.size()-(float)C3pix)/((float)C6pix-(float)C3pix))*(C6-C3)+C3;
      }
      else{
      Freq=0;
      }
    }

    OscMessage myMessage2 = new OscMessage("/ciao");
    myMessage2.add(Freq);
    myMessage2.add(Vol);
    oscP5.send(myMessage2,myRemoteLocation);

    //GAME OF LIFE PART
  
  float var1 = Freq; 
    while(var1>=65){
      var1=var1/2;
    }
    var1=var1*2;
    
    if(var1<=69)      nota=1;
    else if(var1<=77) nota=2;
    else if(var1<=84) nota=3;
    else if(var1<=92) nota=4;
    else if(var1<=103) nota=5;
    else if(var1<=116) nota=6;
    else if(var1<=126) nota=7;
    else              nota=1;
    float vol=Vol;
    int volume;
    if(vol<=0.2)      volume=1;
    else if(vol<=0.4) volume=2;
    else if(vol<=0.6) volume=3;
    else if(vol<=0.8) volume=4;
    else              volume=5;
        gol.generate(nota,volume);
    gol.isEmpty();
    gol.display();
     
    
  }
void mousePressed() {
  gol.init();
}

void Belong(int x, int y, ArrayList<Region> Reg){
        boolean found=false;
        for(Region r: Reg){
          if (r.isNear(x, y)) {
            r.add(x, y);
            found = true;
            break;
          }
        }
        if ((!found)) {
          Region r= new Region(x, y);
          Reg.add(r);
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
