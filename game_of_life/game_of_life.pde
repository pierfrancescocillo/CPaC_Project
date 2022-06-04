//GAME OF LIFE--------------
GOL gol;
//--------------------------


PFont font;
int add_pix = 5;

int nota;

void setup(){
  size(510,510);
  font = loadFont("AlNile-Bold-25.vlw");
  
  //GOL---------------
  frameRate(20);
  smooth();
  gol = new GOL();
  //------------------
}

    
void draw(){
  background(200);
  
  textFont(font,25);
  fill(0);
  float vol = 0;
  float pit = 0;
  float X = mouseX;
  float Y = mouseY;
  float h = height;
  float w = width;
  
  //ONLY WITH MOUSE----------------------------
  
  if(insideWindow()){

    vol = X/w*100;
    pit = (h-Y)/h*100;
    
    if (vol<=5){
      vol=0;
    }else if(vol>=95){
      vol=100;
    }else{
      vol=vol/95*100;
    }
    
    vol=vol/100;
    pit=(pit/100*(2093-65)+65);
    
    
  }else{
    vol = 0;
    pit = 0;
  }
    

    text("Vol: "+vol,width/2,100); 
    text("Pit: "+pit,width/2,120);
    
    float var1 = pit; 
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
    
    int volume;
    if(vol<=0.2)      volume=1;
    else if(vol<=0.4) volume=2;
    else if(vol<=0.6) volume=3;
    else if(vol<=0.8) volume=4;
    else              volume=5;
    
    text("Volume: "+volume,width/2,140); 
    text("Nota: "+nota,width/2,160);
    
    //---------------------------------------------
    
    //MOUSE + KEYBOARD ----------------------------
    /*
    if(insideWindow()){
      vol = X/w*100;
      
      if (vol<=5){
        vol=0;
      }else if(vol>=95){
        vol=100;
      }else{
        vol=vol/95*100;
      }
      
      vol=vol/100;
     
    }else{
      vol = 0;
    }
  
    int volume;
    if(vol<=0.2)      volume=1;
    else if(vol<=0.4) volume=2;
    else if(vol<=0.6) volume=3;
    else if(vol<=0.8) volume=4;
    else              volume=5;
     */
    //--------------------------------------------------
    
    //GOL----------------
    gol.generate(nota,volume);
    gol.isEmpty();
    gol.display();
    //-------------------
    
}

boolean insideWindow() {
  if ( (mouseX > add_pix) && (mouseX <= width -add_pix) && (mouseY > add_pix)  && (mouseY <= height -add_pix) ){
    return true;
  }else{
    return false;
  }   

}

// reset board when mouse is pressed
void mousePressed() {
  gol.init();
}

void keyPressed(){
  if(key=='a')       {nota=1; println("Do");}
  else if (key=='s') {nota=2; println("Re");}
  else if (key=='d') {nota=3; println("Mi");}
  else if (key=='f') {nota=4; println("Fa");}
  else if (key=='g') {nota=5; println("Sol");}
  else if (key=='h') {nota=6; println("La");}
  else if (key=='j') {nota=7; println("Si");}
}


// A basic implementation of John Conway's Game of Life CA
/*
GOL gol;

void setup() {
  frameRate(30);
  size(400, 400);
  smooth();
  gol = new GOL();
}

void draw() {
  background(255);

  gol.generate(6,2);
  gol.display();
}

// reset board when mouse is pressed
void mousePressed() {
  gol.init();
}
*/
