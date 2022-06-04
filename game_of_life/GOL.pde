class GOL {

  int w = 8;
  int columns, rows;

  // Game of life board
  int[][] board;


  GOL() {
    // Initialize rows, columns and set-up arrays
    columns = width/2/w;
    rows = height/w;
    board = new int[columns][rows];
    //next = new int[columns][rows];
    // Call function to fill array with random values 0 or 1
    init();
  }

  void init() {
    for (int i =1;i < columns-1;i++) {
      for (int j =1;j < rows-1;j++) {
        board[i][j] = int(random(2));
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
        if(vol==1){
          //                                  {0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //NORMALE
          if(nota==1)      ruleset = new int[]{1,1,1,0,0,0,0,0,      1,0,1,0,0,0,0,0}; //da modificare
          else if(nota==2) ruleset = new int[]{0,0,1,0,0,0,0,0,      0,1,1,0,0,0,0,0}; //da modificare
          else if(nota==3) ruleset = new int[]{0,1,0,0,0,0,0,0,      0,0,0,0,0,0,0,0}; //da modificare
          else if(nota==4) ruleset = new int[]{0,1,1,1,0,0,0,0,      0,0,1,1,0,0,0,0}; //da modificare
          else if(nota==5) ruleset = new int[]{0,1,1,0,1,0,0,0,      0,0,1,0,1,0,0,0}; //da modificare
          else if(nota==6) ruleset = new int[]{0,1,1,0,0,1,0,0,      0,0,1,0,0,1,0,0}; //da modificare
          else if(nota==7) ruleset = new int[]{0,1,1,0,0,0,1,0,      0,0,1,0,0,0,1,0}; //da modificare
          else             ruleset = new int[]{0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //da modificare
        }else if(vol==2){
          //                                  {0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //NORMALE
          if(nota==1)      ruleset = new int[]{2,1,1,0,0,0,0,0,      2,0,1,0,0,0,0,0}; //da modificare
          else if(nota==2) ruleset = new int[]{0,0,1,0,0,0,0,0,      0,2,1,0,0,0,0,0}; //da modificare
          else if(nota==3) ruleset = new int[]{0,1,0,0,0,0,0,0,      0,0,0,0,0,0,0,0}; //da modificare
          else if(nota==4) ruleset = new int[]{0,1,1,2,0,0,0,0,      0,0,1,2,0,0,0,0}; //da modificare
          else if(nota==5) ruleset = new int[]{0,1,1,0,2,0,0,0,      0,0,1,0,2,0,0,0}; //da modificare
          else if(nota==6) ruleset = new int[]{0,1,1,0,0,2,0,0,      0,0,1,0,0,2,0,0}; //da modificare
          else if(nota==7) ruleset = new int[]{0,1,1,0,0,0,2,0,      0,0,1,0,0,0,2,0}; //da modificare
          else             ruleset = new int[]{0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //da modificare
        }else if(vol==3){
          //                                  {0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //NORMALE
          if(nota==1)      ruleset = new int[]{3,1,1,0,0,0,0,0,      3,0,1,0,0,0,0,0}; //da modificare
          else if(nota==2) ruleset = new int[]{0,0,1,0,0,0,0,0,      0,3,1,0,0,0,0,0}; //da modificare
          else if(nota==3) ruleset = new int[]{0,1,0,0,0,0,0,0,      0,0,0,0,0,0,0,0}; //da modificare
          else if(nota==4) ruleset = new int[]{0,1,1,3,0,0,0,0,      0,0,1,3,0,0,0,0}; //da modificare
          else if(nota==5) ruleset = new int[]{0,1,1,0,3,0,0,0,      0,0,1,0,3,0,0,0}; //da modificare
          else if(nota==6) ruleset = new int[]{0,1,1,0,0,3,0,0,      0,0,1,0,0,3,0,0}; //da modificare
          else if(nota==7) ruleset = new int[]{0,1,1,0,0,0,3,0,      0,0,1,0,0,0,3,0}; //da modificare
          else             ruleset = new int[]{0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //da modificare
        }else if(vol==4){
          //                                  {0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //NORMALE
          if(nota==1)      ruleset = new int[]{4,1,1,0,0,0,0,0,      4,0,1,0,0,0,0,0}; //da modificare
          else if(nota==2) ruleset = new int[]{0,0,1,0,0,0,0,0,      0,4,1,0,0,0,0,0}; //da modificare
          else if(nota==3) ruleset = new int[]{0,1,0,0,0,0,0,0,      0,0,0,0,0,0,0,0}; //da modificare
          else if(nota==4) ruleset = new int[]{0,1,1,4,0,0,0,0,      0,0,1,4,0,0,0,0}; //da modificare
          else if(nota==5) ruleset = new int[]{0,1,1,0,4,0,0,0,      0,0,1,0,4,0,0,0}; //da modificare
          else if(nota==6) ruleset = new int[]{0,1,1,0,0,4,0,0,      0,0,1,0,0,4,0,0}; //da modificare
          else if(nota==7) ruleset = new int[]{0,1,1,0,0,0,4,0,      0,0,1,0,0,0,4,0}; //da modificare
          else             ruleset = new int[]{0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //da modificare
        }else if(vol==5){
          //                                  {0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //NORMALE
          if(nota==1)      ruleset = new int[]{5,1,1,0,0,0,0,0,      5,0,1,0,0,0,0,0}; //da modificare
          else if(nota==2) ruleset = new int[]{0,0,1,0,0,0,0,0,      0,5,1,0,0,0,0,0}; //da modificare
          else if(nota==3) ruleset = new int[]{0,1,0,0,0,0,0,0,      0,0,0,0,0,0,0,0}; //da modificare
          else if(nota==4) ruleset = new int[]{0,1,1,5,0,0,0,0,      0,0,1,5,0,0,0,0}; //da modificare
          else if(nota==5) ruleset = new int[]{0,1,1,0,5,0,0,0,      0,0,1,0,5,0,0,0}; //da modificare
          else if(nota==6) ruleset = new int[]{0,1,1,0,0,5,0,0,      0,0,1,0,0,5,0,0}; //da modificare
          else if(nota==7) ruleset = new int[]{0,1,1,0,0,0,5,0,      0,0,1,0,0,0,5,0}; //da modificare
          else             ruleset = new int[]{0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0}; //da modificare
        }else{
                           ruleset = new int[]{0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0};
        }

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

    // Next is now our board
    board = next;
  }

  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {
    for ( int i = 0; i < columns;i++) {
      for ( int j = 0; j < rows;j++) {
        if      ((board[i][j] == 1)) fill(0,0,255);
        else if ((board[i][j] == 2)) fill(255,0,0);
        else if ((board[i][j] == 3)) fill(0,255,0);
        else if ((board[i][j] == 4)) fill(255,255,0);
        else if ((board[i][j] == 5)) fill(0,255,255);
        else fill(255); 
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
      board[(int)columns/2][(int)rows/2] = 1;
      board[(int)columns/2+1][(int)rows/2] = 1;
      board[(int)columns/2][(int)rows/2+1] = 1;
      board[(int)columns/2+1][(int)rows/2+1] = 1;
    }
  }
}
