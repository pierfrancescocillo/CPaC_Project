class GOL {

  int w = 6;
  int columns, rows;
  int colLen = 15;
  //int[][] colorLine = {{255,255,255},{0,0,0}};//[0,1]
  int[][] colorLine;
        
  
  // Game of life board
  int[][] board;
  int[][][] boardHistory;


  GOL() {
    // Initialize rows, columns and set-up arrays
    columns = width/2/w;
    rows = height/w;
    board = new int[columns][rows];
    //next = new int[columns][rows];
    // Call function to fill array with random values 0 or 1
    boardHistory = new int[columns][rows][colLen];
    init();
  }

  void init() {
    for (int i =1;i < columns-1;i++) {
      for (int j =1;j < rows-1;j++) {
        board[i][j] = int(random(2));
      }
    }
    for (int i =1;i < columns-1;i++) {
      for (int j =1;j < rows-1;j++) {
        for (int k=0;k<colLen;k++){
          boardHistory[i][j][k] = 0;
        };
      }
    }
  }

  // The process of creating the new generation
  void generate(int nota, int vol) {

    int[][] next = new int[columns][rows];

    // Loop through every spot in our 2D array and check spots neighbors
    for (int x = 1; x < columns-1; x++) {
      for (int y = 1; y < rows-1; y++) {

        // Add up all the states in a 3x3 surrounding grid
        int neighbors = 0;
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            if(board[x+i][y+j]>=1) neighbors += 1;   
          }
        }

        // A little trick to subtract the current cell's state since
        // we added it in the above loop
        if(board[x][y]>0){
          neighbors -= 1;
        }

        int[] ruleset ;
        //                                  {0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //NORMALE
        if(nota==1)      ruleset = new int[]{1,1,1,0,0,0,0,0,      1,0,1,0,0,0,0,0}; //da modificare
        else if(nota==2) ruleset = new int[]{0,0,1,0,0,0,0,0,      0,1,1,0,0,0,0,0}; //da modificare
        else if(nota==3) ruleset = new int[]{0,1,0,0,0,0,0,0,      0,0,0,0,0,0,0,0}; //da modificare
        else if(nota==4) ruleset = new int[]{0,1,1,1,0,0,0,0,      0,0,1,1,0,0,0,0}; //da modificare
        else if(nota==5) ruleset = new int[]{0,1,1,0,1,0,0,0,      0,0,1,0,1,0,0,0}; //da modificare
        else if(nota==6) ruleset = new int[]{0,1,1,0,0,1,0,0,      0,0,1,0,0,1,0,0}; //da modificare
        else if(nota==7) ruleset = new int[]{0,1,1,0,0,0,1,0,      0,0,1,0,0,0,1,0}; //da modificare
        else             ruleset = new int[]{0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //da modificare
        
        /*
        if(vol==1)      colorLine = new int[][]{{153,0,153},{0,0,255}};//[0,1] Blu
        else if(vol==2) colorLine = new int[][]{{0,76,153},{0,255,0}};//[0,1] Verde
        else if(vol==3) colorLine = new int[][]{{0,102,0},{252,227,67}};//[0,1] Giallo
        else if(vol==4) colorLine = new int[][]{{252,227,67},{255,162,0}};//[0,1] Aranc
        else if(vol==5) colorLine = new int[][]{{255,162,0},{230,27,27}};//[0,1] Rosso
        else            colorLine = new int[][]{{255,255,255},{0,0,0}};//[0,1]
        */
        
        if(vol==1)      colorLine = new int[][]{{255,162,0},{0,0,204}};//[0,1] Blu
        else if(vol==2) colorLine = new int[][]{{230,27,27},{0,153,0}};//[0,1] Verde
        else if(vol==3) colorLine = new int[][]{{153,0,153},{252,227,67}};//[0,1] Giallo
        else if(vol==4) colorLine = new int[][]{{0,0,204},{255,162,0}};//[0,1] Aranc
        else if(vol==5) colorLine = new int[][]{{0,153,0},{230,27,27}};//[0,1] Rosso
        else            colorLine = new int[][]{{255,255,255},{0,0,0}};//[0,1]
        
        // Rules of Life
        if      ((board[x][y] >= 1) && (neighbors ==  1)) next[x][y] = ruleset[0];          
        else if ((board[x][y] >= 1) && (neighbors ==  2)) next[x][y] = ruleset[1];           
        else if ((board[x][y] >= 1) && (neighbors ==  3)) next[x][y] = ruleset[2];           
        else if ((board[x][y] >= 1) && (neighbors ==  4)) next[x][y] = ruleset[3];           
        else if ((board[x][y] >= 1) && (neighbors ==  5)) next[x][y] = ruleset[4];           
        else if ((board[x][y] >= 1) && (neighbors ==  6)) next[x][y] = ruleset[5];           
        else if ((board[x][y] >= 1) && (neighbors ==  7)) next[x][y] = ruleset[6];           
        else if ((board[x][y] >= 1) && (neighbors ==  8)) next[x][y] = ruleset[7];           
        else if ((board[x][y] == 0) && (neighbors ==  1)) next[x][y] = ruleset[8];           
        else if ((board[x][y] == 0) && (neighbors ==  2)) next[x][y] = ruleset[9];           
        else if ((board[x][y] == 0) && (neighbors ==  3)) next[x][y] = ruleset[10];           
        else if ((board[x][y] == 0) && (neighbors ==  4)) next[x][y] = ruleset[11];           
        else if ((board[x][y] == 0) && (neighbors ==  5)) next[x][y] = ruleset[12];           
        else if ((board[x][y] == 0) && (neighbors ==  6)) next[x][y] = ruleset[13];           
        else if ((board[x][y] == 0) && (neighbors ==  7)) next[x][y] = ruleset[14];           
        else if ((board[x][y] == 0) && (neighbors ==  8)) next[x][y] = ruleset[15];           
        //else                                            next[x][y] = board[x][y];  // Stasis
      }
    }
    //Update board History
    for (int i =1;i < columns-1;i++) {
      for (int j =1;j < rows-1;j++) {
        for (int k=colLen-1;k>0;k--){
          boardHistory[i][j][k] = boardHistory[i][j][k-1];
        };
      }
    }
    for (int i =1;i < columns-1;i++) {
      for (int j =1;j < rows-1;j++) {
        boardHistory[i][j][0] = board[i][j];
      }
    }
    
    // Next is now our board
    board = next;

    
  }

  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {
    
    for ( int i = 0; i < columns;i++) {
      for ( int j = 0; j < rows;j++) {
        /*
        if      ((board[i][j] == 1)) fill(0,0,255);
        else if ((board[i][j] == 2)) fill(255,0,0);
        else if ((board[i][j] == 3)) fill(0,255,0);
        else if ((board[i][j] == 4)) fill(255,255,0);
        else if ((board[i][j] == 5)) fill(0,255,255);
        else fill(255); 
        */
        if((board[i][j] == 1)) fill(colorLine[1][0],colorLine[1][1],colorLine[1][2]);
        else {
          int boolFind = 0;
          int k=0;
          while(boolFind==0 && k<colLen){
            if(boardHistory[i][j][k]==1) {
              boolFind = 1;
            };
            k++;
          }
          //if(k==colLen) fill(colorLine[0][0],colorLine[0][1],colorLine[0][2]);
          if(k==colLen) fill(192,192,192);
          else {
            int[] map = colorMap(colorLine,k);
            fill(map[0],map[1],map[2]);
          };
        };
        stroke(0);
        rect(i*w+width/2, j*w, w, w);
      }
    }
  }
  
  void isEmpty(){
    int fulls=0;
    for (int x = 1; x < columns-1; x++) {
      for (int y = 1; y < rows-1; y++) {
        if(board[x][y]!=0) fulls=fulls+1;
      }
    }
    if(fulls==0){
      println("EMPTY");
      /*
      board[(int)columns/2][(int)rows/2] = 1;
      board[(int)columns/2+1][(int)rows/2] = 1;
      board[(int)columns/2][(int)rows/2+1] = 1;
      board[(int)columns/2+1][(int)rows/2+1] = 1;
      */
      
      int center_x = (int)columns/2;
      int center_y = (int)rows/2;
      
      for(int i=-5;i<=4;i++){
        board[center_x][center_y+i] = 1;
      }
      for(int i=-5;i<=4;i++){
        board[center_x+1][center_y+i] = 1;
      }
      //--------------------------SX-------------------
      for(int i=-5;i<=+6;i++){
        if(i!=0&&i!=-1){
          board[center_x-1][center_y+i] = 1;
        }
      }
      
      for(int i=-4;i<=+6;i++){
        if(i!=-2&&i!=-1&&i!=0&&i!=1){
          board[center_x-2][center_y+i] = 1;
        }
      }
      
      for(int i=-4;i<=+5;i++){
        if(i!=0&&i!=-1){
          board[center_x-3][center_y+i] = 1;
        }
      }
      
      for(int i=-3;i<=+4;i++){
        board[center_x-4][center_y+i] = 1;
      }
      
      for(int i=-2;i<=+5;i++){
        board[center_x-5][center_y+i] = 1;
      }
      
      for(int i=+1;i<=+6;i++){
        board[center_x-6][center_y+i] = 1;
      }
      
      //-----------------------------------------------
      
      //--------------------------DX-------------------
      for(int i=-5;i<=+6;i++){
        if(i!=0&&i!=-1){
          board[center_x+1+1][center_y+i] = 1;
        }
      }
      
      for(int i=-4;i<=+6;i++){
        if(i!=-2&&i!=-1&&i!=0&&i!=1){
          board[center_x+2+1][center_y+i] = 1;
        }
      }
      
      for(int i=-4;i<=+5;i++){
        if(i!=0&&i!=-1){
          board[center_x+3+1][center_y+i] = 1;
        }
      }
      
      for(int i=-3;i<=+4;i++){
        board[center_x+4+1][center_y+i] = 1;
      }
      
      for(int i=-2;i<=+5;i++){
        board[center_x+5+1][center_y+i] = 1;
      }
      
      for(int i=+1;i<=+6;i++){
        board[center_x+6+1][center_y+i] = 1;
      }
      
      //-----------------------------------------------
      
    }
  }
  
  int[] colorMap(int[][] colorL,int kappa){
    /*
    int l_1 = (colorL[1][0]-colorL[0][0])*kappa/colLen+colorL[0][0];
    int l_2 = (colorL[1][1]-colorL[0][1])*kappa/colLen+colorL[0][1];
    int l_3 = (colorL[1][2]-colorL[0][2])*kappa/colLen+colorL[0][2];
    */
    int l_1 = (colorL[0][0]-colorL[1][0])*kappa/colLen+colorL[1][0];
    int l_2 = (colorL[0][1]-colorL[1][1])*kappa/colLen+colorL[1][1];
    int l_3 = (colorL[0][2]-colorL[1][2])*kappa/colLen+colorL[1][2];
    
    int[] mappa = {l_1,l_2,l_3};
    return mappa;
  }
}
