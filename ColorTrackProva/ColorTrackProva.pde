import processing.video.*;
import netP5.*;
import oscP5.*;
OscP5 oscP5;

NetAddress myRemoteLocation;
///COLOR TRACK PART
Capture cam;

//changable variables
color VoltrackColor; 
color FreqtrackColor;
//Threshold for the Volume
float thresholdVol = 110;
//Threshold for the Frequency
float thresholdFreq = 165;
//Threshold for pixel distance
float distThreshold = 60;
//frequency range
float C3=130.81;
float C6=1046.5;
//Volume range
float MaxVol=1.0;
float MinVol=0.0;
//-----------------------
//Parameters used for mapping
float MaxVolPix;
float MinVolPix;

int C3pix;
int C6pix;
//Arrays of Region
ArrayList<Region> VolRegion = new ArrayList<Region>();
ArrayList<Region> FreqRegion = new ArrayList<Region>();


//GAME OF LIFE PART
GOL gol;

int add_pix = 5;

int nota;

void setup() {
  //COLOR TRACK PART
  size(1024, 600);
  cam=new Capture(this,width/2,height,30);
  cam.start();
  //Color definition
  VoltrackColor = color(30,198,60);
 // VoltrackColor = color(153,153,0);
 // FreqtrackColor=color(153,153,0);
 FreqtrackColor=color(0,0,255);
 //OSC
  oscP5= new OscP5(this,57120);
  myRemoteLocation= new NetAddress("127.0.0.1", 57120);
  
  C3pix=(int)(cam.width*cam.height/512);
  C6pix=(int)(cam.width*cam.height/51.2);

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
 //if (!cam.available()) {return;}
  cam.read();
}
//For changing thresholds with keys
void keyPressed() {
  if (key == 'w') {
    thresholdFreq+=1;
  } else if (key == 's') {
    thresholdFreq-=1;
  }
  if (key == 'e') {
    thresholdVol+=1;
  } else if (key == 'd') {
    thresholdVol-=1;
  }
  println(thresholdFreq+ "and" + thresholdVol);
}

void draw() {
  //COLOR TRACK PART
//  cam.read();
  background(200);
  cam.loadPixels();
  image(cam, 0, 0, width/2, height);
  VolRegion.clear();
  FreqRegion.clear();

      float rV = red(VoltrackColor);
      float gV = green(VoltrackColor);
      float bV = blue(VoltrackColor);
      float rF = red(FreqtrackColor);
      float gF = green(FreqtrackColor);
      float bF = blue(FreqtrackColor);
  // Algorithm for color tracking
  for (int x = 0; x < cam.width; x++ ) {
    for (int y = 0; y < cam.height; y++ ) {
      int loc = x + y *cam.width;
      // current color
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
       //evaluating distance
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
      
      //visualize only blob with a certain number of pixels
      
       if ((r.pixs.size() > 500)) {
       
         //evaluate the y coord of the central pixel of the region
           r.avgy = r.avgy / r.pixs.size();
           r.show(VoltrackColor, cam);
           
           if((r.avgy>MaxVolPix)&&(r.avgy<=MinVolPix)){
             //mapping
           Vol=map(r.avgy, MinVolPix, MaxVolPix, MinVol, MaxVol);
           }
           else {
           Vol=0;
           }
        }
    }
     float Freq=0;
    for (Region r : FreqRegion){
      //track only blob with a certain pixel size
      if ((r.pixs.size() > 550)&&((r.pixs.size()<6500))) {
      r.show(FreqtrackColor, cam);
      //mapping
      Freq=map(r.pixs.size(), (float)C3pix, (float)C6pix, C3, C6);
      }
      else{
      Freq=0;
      }
    }
    //sending Vol and Freq values to Supercollider
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
//function to put pixels in a specific region. Every region is scanned and if a pixel
//has a distance from at least one of the pixel of that specific region less than a
//certain threshold, the pixel is added to that region, otherwise oter regions are
//checked. if the pixel dosn't belong to any region, a new region is created.

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
