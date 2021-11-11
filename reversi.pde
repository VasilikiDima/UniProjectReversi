int size = 50;
PImage img1;
PImage img2;
PImage back;
int image = 0;
boolean flag= false;
int tempPlays;
Button difficulty1 = new Button(50, 100, 100, 50, "Easy", 126, 54, 18);
Button difficulty2 = new Button(200, 100, 100, 50, "Medium", 126, 54, 18);
Button difficulty3 = new Button(350, 100, 100, 50, "Hard", 126, 54, 18);
Button playerWhite = new Button(50, 200, 150, 50, "White Pieces ", 126, 54, 18);
Button start = new Button(200, 300, 100, 50, "Begin", 126, 54, 18);
boolean ihaveMove = false;
boolean aiIsplaying;
boolean pressToPlay = false;
int R = 0, C = 0;
boolean firstmove = true;
int difficulty;
int plays;
GamePlayer BPlayer;
GamePlayer WPlayer;
Board board = new Board();
private int GameState =0; 

void setup() {
  size (500, 500);
  surface.setTitle("Reversi");
  back = loadImage("black.png");
  Board board = new Board();
  board.setLastPlayer(-1);//lastPlayer einai panta o white gt panta paizei prwta p black
}

void draw() {
  if (GameState == 0) {
    mainMenu();
  } else if (GameState == 1 ) {
    gamePlay();
    update();
  } else if (GameState == 2) {
    endMenu();
  }
}

void update() {
  if (aiIsplaying &&board.getLastPlayer() == -1 &&flag) {
    delay(800);
    System.out.println("White moves");
    Move WMove = WPlayer.MiniMax(board);
    board.makeMove(WMove.getRow(), WMove.getCol(), Board.whitePiece);
    board.setLastPlayer(Board.whitePiece);
    aiIsplaying = false;
    board.print();
    printB();
  } else if (ihaveMove) {//antistoixa la8oi me to katw(exei omws swsta ta values)
    board.makeMove(R, C, plays);
    board.setLastPlayer(plays);
    printB();
    ihaveMove = false;
    aiIsplaying = true;
    board.print();
    flag = true;
    firstmove = false;
  }
  if (board.isTerminal()) {
    GameState = 2;
  }
}
void gamePlay() {
  background(back);
  smooth();
  fill(0);
  rect(45, 45, 410, 410);
  img1 = loadImage("relight.jpg");
  img2 = loadImage("rotdark.png");
  for (int h = 50; h < width - 50; h += size) {
    for (int v = 50; v < height - 50; v += size) { 
      if (image == 0) {
        image (img1, h, v);
        image = 1;
      } else {
        image(img2, h, v);
        image = 0;
      }
    }
    if (image == 0) {
      image = 1;
    } else {
      image = 0;
    }
  }
  if (firstmove) {
    textSize(40);
    fill(0, 0, 0);
    text("Press anywhere to start", 250, 20);
  }
  board.print();
}
void mousePressed() {
  if (GameState == 1) {
    boolean entityPressed = false;
    if (mouseX > 50 && mouseX < 450 &&mouseY > 50 && mouseY < 450) {
      entityPressed = true;
    }
    if (entityPressed) {
      C = findPosition(mouseY);
      R = findPosition(mouseX);
      println(R + " " +  C);
      if (firstmove) {
        firstmove = false;
        R = 3;
        C = 5;
      }
      if (!board.isValid(R, C, plays)) {
        println("Not valid move: you lost your turn " + R + " " + C + " " + plays);
        printB();
        pressToPlay = true;
      } else {
        pressToPlay = true;
        ihaveMove = true;
        tempPlays = plays;
        println("I have move");
      }
    }
  }
}

void printB() {
  for (int j=0; j<8; j++) {
    for (int i=0; i<8; i++) {
      System.out.print(board.getPiece(i, j) +  "\t");
    }
    System.out.println("");
  }
}
void mainMenu() {
  background(back);
  if (difficulty1.isClicked()) {
    difficulty1.setColourClick();
    difficulty2.setColourUnClick();
    difficulty3.setColourUnClick();
    difficulty = 2;
  }
  difficulty1.update();
  difficulty1.render();

  if (difficulty2.isClicked()) {
    difficulty2.setColourClick();
    difficulty1.setColourUnClick();
    difficulty3.setColourUnClick();
    difficulty = 4;
  }
  difficulty2.update();
  difficulty2.render();

  if (difficulty3.isClicked()) {
    difficulty3.setColourClick();
    difficulty2.setColourUnClick();
    difficulty1.setColourUnClick();
    difficulty = 6;
  }
  difficulty3.update();
  difficulty3.render();

  plays = -1;
  aiIsplaying = false;

  if (start.isClicked()) {
    //start.setColourClick();
    if (difficulty != 0 && plays !=0) {
      start.setColourClick();
      BPlayer = new GamePlayer(difficulty, Board.blackPiece);
      WPlayer = new GamePlayer(difficulty, Board.whitePiece);
      Board board = new Board();
      board.setLastPlayer(-1);//lastPlayer einai panta o white gt panta paizei prwta p black
      GameState = 1;
    }
  }
  start.update();
  start.render();
}
int findPosition(int R) {
  if (R < 50) {
    return -1;
  } else if (R < 100) {
    return 0;
  } else if (R < 150) {
    return 1;
  } else if (R < 200) {
    return 2;
  } else if (R < 250) {
    return 3;
  } else if (R < 300) {
    return 4;
  } else if (R < 350) {
    return 5;
  } else if (R < 400) {
    return 6;
  } else if (R < 450) {
    return 7;
  }
  return -1;
}
void endMenu() {
  background(back);
  int score = board.evaluate();
  textSize(60);
  fill(0, 0, 0);
  if (score == 0) {
    text("It's a draw!", 250, 230);
  } else if (score > 0) {
    text("You lose...", 250, 230);
  } else {
    text("You Win!", 250, 230);
  }
}
