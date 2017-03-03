import de.bezier.guido.*;

//Declare and initialize NUM_ROWS and NUM_COLS = 20
public int NUM_ROWS = 20;
public int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
   for (int row = 0; row < NUM_ROWS; row++)
   {
       for (int col = 0; col < NUM_COLS; col++)
       {
           buttons[row][col] = new MSButton(row, col);
       }
   }  
    setBombs();
}
public void setBombs()
{
   for(int i = 0; i < 3; i++) 
   {
       int row = (int)(Math.random()*20);
       int col = (int)(Math.random()*20);
       if(!bombs.contains(buttons[row][col]))
       {
           bombs.add(buttons[row][col]);
       }
    }

}
public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
        
}
public boolean isWon()
{
    //your code here
   for(int i = 0;i < NUM_ROWS;i++){
       for(int j = 0;j < NUM_COLS;j++){
           if(!buttons[i][j].isClicked()==true&&!bombs.contains(buttons[i][j])){
               return false;
           }
       }
   }
   return true;
}
public void displayLosingMessage()
{
       for(int i = 0;i < NUM_ROWS;i++){
       for(int j = 0;j < NUM_COLS;j++){
           if(!buttons[i][j].isClicked()&&bombs.contains(buttons[i][j]))
           {
               buttons[i][j].marked=false;
               buttons[i][j].clicked=true;
                   buttons[10][6].setLabel("Y");
                   buttons[10][7].setLabel("O");
                   buttons[10][8].setLabel("U");
                   buttons[10][9].setLabel(" ");
                   buttons[10][10].setLabel("L");
                   buttons[10][11].setLabel("O");
                   buttons[10][12].setLabel("S");
                   buttons[10][13].setLabel("E");      
           }
       }
   }
}
public void displayWinningMessage()
{
    buttons[10][1].setLabel("C");
    buttons[10][2].setLabel("O");
    buttons[10][3].setLabel("N");
    buttons[10][4].setLabel("G");
    buttons[10][5].setLabel("R");
    buttons[10][6].setLabel("A");
    buttons[10][7].setLabel("T");
    buttons[10][8].setLabel("S");
    buttons[10][9].setLabel("!");
    buttons[10][10].setLabel(" ");
    buttons[10][11].setLabel("Y");
    buttons[10][12].setLabel("O");
    buttons[10][13].setLabel("U");
    buttons[10][14].setLabel(" ");
    buttons[10][15].setLabel("W");
    buttons[10][16].setLabel("I");
    buttons[10][17].setLabel("N");
    buttons[10][18].setLabel("!");
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
public void mousePressed () 
{
     if(mouseButton == LEFT && !marked)
     clicked = true;
     if(mouseButton == RIGHT)
     marked = !marked;
 //(marked == false)
            //clicked = false;
//FIX UPABOVE LINE PLS
        else if(bombs.contains(this))
            displayLosingMessage();
        else if (countBombs(r, c)>0)
            label = " " +countBombs(r,c);
        else
        {
            if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
            buttons[r][c-1].mousePressed();
           if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
            buttons[r][c+1].mousePressed();
           if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
            buttons[r-1][c].mousePressed();
           if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
            buttons[r+1][c].mousePressed();
           if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
            buttons[r+1][c-1].mousePressed();
           if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
            buttons[r+1][c+1].mousePressed();
           if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
            buttons[r-1][c-1].mousePressed();
           if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
            buttons[r-1][c+1].mousePressed();
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if((c <= 19 && c >= 0) && (r >= 0 && r <= 19))
     return true;
    
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
        {
            numBombs++;
        }
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
        {
            numBombs++;
        }
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
        {
            numBombs++;
        }
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
        {
            numBombs++;
        }
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs++;
        }
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
        {
            numBombs++;
        }
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
        {
            numBombs++;
        }
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
        {
            numBombs++;
        }
        return numBombs;
    }
}