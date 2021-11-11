import java.util.ArrayList;

public class Board {
  public static final int whitePiece = 1;
  public static final int blackPiece = -1;
  public static final int emptyTile = 0;

  private Move lastMove;
  private int lastPlayer;
  private int [][] gameBoard;

  //constructors
  public Board() {
    lastMove = new Move();
    lastPlayer = 0;
    gameBoard = new int [8][8];
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        gameBoard[i][j] = emptyTile;
      }
    }
    gameBoard[3][3] = gameBoard[4][4] = blackPiece;
    gameBoard[3][4] = gameBoard[4][3] = whitePiece;
  }
  public Board(Board previousBoard) {
    lastMove = new Move();
    lastPlayer = previousBoard.getLastPlayer();

    gameBoard = new int[8][8];
    for (int i=0; i<8; i++)
    {
      System.arraycopy(previousBoard.gameBoard[i], 0, gameBoard[i], 0, 8);
    }
  }

  //there is a possible move for this tile
  //checks to witch direction is the tiles the player takes
  //goes until it finds the same tile with only opponent's tiles inbetween
  //then returns tile-tile to the starting tile changes the tiles to current player's tiles
  public void makeMove(int row, int col, int value) {
    //flag1: if its out of the board
    //flag2: if the tile is empty
    //flag3: if a move is made
    boolean flag1, flag2, flag3, flag4;
    int testRow, testCol;
    flag4 = false;
    for (int i = 0; i < 8; i++) {
      flag1 = true;
      flag2 = true;
      flag3 = true;

      if (i == 0) {
        testRow = row - 1;
        testCol = col - 1;
        if (testCol < 0 || testRow < 0) {
          flag1 = false;
        }
        if (flag1) {
          if (gameBoard[testRow][testCol] == lastPlayer) {
            testRow--;
            testCol--;
            while (flag1 && flag2 && flag3) {
              if (testRow < 0 || testCol < 0) {
                flag1 = false;
              }
              if (flag1 && gameBoard[testRow][testCol] == 0) {
                flag2 = false;
              }
              if (flag1 && flag2 && gameBoard[testRow][testCol] != lastPlayer) {
                while (testRow != row && testCol != col) {
                  gameBoard[testRow][testCol] = value;
                  testRow++;
                  testCol++;
                }
                flag4 = true;
                flag3 = false;
              }
              testRow--;
              testCol--;
            }
          }
        }
      }
      if (i == 1) {
        testRow = row - 1;
        testCol = col;
        if (testRow < 0) {
          flag1 = false;
        }
        if (flag1) {
          if (gameBoard[testRow][testCol] == lastPlayer) {
            testRow--;
            while (flag1 && flag2 && flag3) {
              if (testRow < 0) {
                flag1 = false;
              }
              if (flag1 && gameBoard[testRow][testCol] == 0) {
                flag2 = false;
              }
              if (flag1 && flag2 && gameBoard[testRow][testCol] == value) {
                while (testRow != row) {
                  gameBoard[testRow][col] = value;
                  testRow++;
                }
                flag4 = true;
                flag3 = false;
              }
              testRow--;
            }
          }
        }
      } 
      if (i == 2) {
        testRow = row - 1;
        testCol = col + 1;
        if (testCol > 7 || testRow < 0 ) {
          flag1 = false;
        }
        if (flag1) {
          if (gameBoard[testRow][testCol] == lastPlayer) {
            testRow--;
            testCol++;

            while (flag1 && flag2 && flag3) {
              if (testRow < 0 || testCol  > 7) {
                flag1 = false;
              }
              if (flag1 && gameBoard[testRow][testCol] == 0) {
                flag2 = false;
              }
              if (flag1 && flag2 && gameBoard[testRow][testCol] == value) {
                while (testRow != row && testCol != col) {
                  gameBoard[testRow][testCol] = value;
                  testRow++;
                  testCol--;
                }
                flag4 = true;
                flag3 = false;
              }

              testRow--;
              testCol++;
            }
          }
        }
      }
      if (i == 3) {
        testRow = row;
        testCol = col + 1;
        if (testCol > 7) {
          flag1 = false;
        }
        if (flag1) {
          if (gameBoard[testRow][testCol] == lastPlayer) {
            testCol++;
            while (flag1 && flag2 && flag3) {
              if (testCol > 7) {
                flag1 = false;
              }
              if (flag1 && gameBoard[testRow][testCol] == 0) {
                flag2 = false;
              }
              if (flag1 && flag2 && gameBoard[testRow][testCol] == value) {
                while (testCol != col) {
                  gameBoard[testRow][testCol] = value;
                  testCol--;
                }
                flag4 = true;
                flag3 = false;
              }
              testCol++;
            }
          }
        }
      }
      if (i == 4) {
        //System.out.println("mphka sto case 5 ths make move");
        testRow = row + 1;
        testCol = col + 1;
        if (testCol > 7 || testRow > 7) {
          flag1 = false;
        }
        if (flag1) {
          if (gameBoard[testRow][testCol] == lastPlayer) {
            testRow++;
            testCol++;
            while (flag1 && flag2 && flag3) {
              if (testRow > 7 || testCol > 7) {
                flag1 = false;
              }
              if (flag1 && gameBoard[testRow][testCol] == 0) {
                flag2 = false;
              }
              if (flag1 && flag2 && gameBoard[testRow][testCol] == value) {
                while (testRow != row && testCol != col) {
                  gameBoard[testRow][testCol] = value;
                  testRow--;
                  testCol--;
                }
                flag4 = true;
                flag3 = false;
              }
              testRow++;
              testCol++;
            }
          }
        }
      }
      if (i == 5) {
        testRow = row + 1;
        testCol = col;
        if (testRow > 7) {
          flag1 = false;
        }
        if (flag1) {
          if (gameBoard[testRow][testCol] == lastPlayer) {
            testRow++;
            while (flag1 && flag2 && flag3) {
              if (testRow > 7) {
                flag1 = false;
              }
              if (flag1 && gameBoard[testRow][testCol] == 0) {
                flag2 = false;
              }
              if (flag1 && flag2 && gameBoard[testRow][testCol] == value) {
                while (testRow != row) {
                  gameBoard[testRow][testCol] = value;
                  testRow--;
                }
                flag4 = true;
                flag3 = false;
              }
              testRow++;
            }
          }
        }
      }
      if (i == 6) {
        testRow = row + 1;
        testCol = col - 1;
        if (testCol < 0 || testRow > 7) {
          flag1 = false;
        }
        if (flag1) {
          if (gameBoard[testRow][testCol] == lastPlayer) {
            testRow++;
            testCol--;
            while (flag1 && flag2 && flag3) {
              if (testCol < 0 || testRow > 7) {
                flag1 = false;
              }
              if (flag1 && gameBoard[testRow][testCol] == 0) {
                flag2 = false;
              }
              if (flag1 && flag2 && gameBoard[testRow][testCol] == value) {
                while (testRow != row && testCol != col) {
                  gameBoard[testRow][testCol] = value;
                  testRow--;
                  testCol++;
                }
                flag4 = true;
                flag3 = false;
              }
              testRow++;
              testCol--;
            }
          }
        }
      }
      if (i == 7) {
        testRow = row;
        testCol = col - 1;
        if (testCol < 0) {
          flag1 = false;
        }
        if (flag1) {
          if (gameBoard[testRow][testCol] == lastPlayer) {
            testCol--;
            while (flag1 && flag2 && flag3) {
              if (testCol < 0) {
                flag1 = false;
              }
              if (flag1 && gameBoard[testRow][testCol] == 0) {
                flag2 = false;
              }
              if (flag1 && flag2 && gameBoard[testRow][testCol] == value) {
                while (testCol != col) {
                  gameBoard[testRow][testCol] = value;
                  testCol++;
                }
                flag4 = true;
                flag3 = false;
              }
              testCol--;
            }
          }
        }
      }
    }
    lastMove = new Move(row, col);
    setLastPlayer(value);
    if (flag4) {
      gameBoard[row][col] = value;
    }
    //print();
  }
  public boolean isValid(int row, int col, int value) {
    if (gameBoard[row][col] != 0)return false;
    int testRow, testCol;
    boolean flag, flag2;

    for (int i = 0; i < 8; i++) {
      flag = true;
      flag2 = true;
      if (i == 0) {

        testRow = row - 1;
        testCol = col - 1;
        if (testRow < 0 || testCol < 0) {
          flag = false;
        }
        if (flag && gameBoard[testRow][testCol] == getLastPlayer()) {
          while (flag2) {
            testRow--;
            testRow--;
            if (testRow < 0) {
              flag2 = false;
            } else if (gameBoard[testRow][testCol] == value) {
              return true;
            }
          }
        }
      }
      if (i == 1) {
        testRow = row - 1;
        testCol = col;
        if (testRow < 0) {
          flag = false;
        }
        if (flag && gameBoard[testRow][testCol] != 0 && gameBoard[testRow][testCol] != value) {
          while (flag2) {
            testRow--;
            if (testRow < 0) {
              flag2 = false;
            } else if (gameBoard[testRow][testCol] == value) {
              return true;
            }
          }
        }
      }
      if (i == 2) {
        testRow = row - 1;
        testCol = col + 1;
        if (testRow < 0 || testCol > 7) {
          flag = false;
        }
        if (flag && gameBoard[testRow][testCol] != 0 && gameBoard[testRow][testCol] != value) {

          while (flag2) {
            testRow--;
            testCol++;
            if (testCol > 7 || testRow < 0) {
              flag2 = false;
            } else if (gameBoard[testRow][testCol] == value) {
              return true;
            }
          }
        }
      }
      if (i == 3) {
        testRow = row;
        testCol = col + 1;
        if (testCol > 7) {

          flag = false;
        }
        if (flag && gameBoard[testRow][testCol] != 0 && gameBoard[testRow][testCol] != value) {
          while (flag2) {
            testCol++;
            if (testCol > 7) {
              flag2 = false;
            } else if (gameBoard[testRow][testCol] == value) {
              return true;
            }
          }
        }
      }
      if (i == 4) {
        testRow = row + 1;
        testCol = col + 1;
        if (testRow > 7 || testCol > 7) {

          flag = false;
        }
        if (flag && gameBoard[testRow][testCol] != 0 && gameBoard[testRow][testCol] != value) {

          while (flag2) {
            testRow++;
            testCol++;
            if (testCol > 7 || testRow > 7) {
              flag2 = false;
            } else if (gameBoard[testRow][testCol] == value) {
              return true;
            }
          }
        }
      }
      if (i == 5) {
        testRow = row + 1;
        testCol = col;
        if (testRow > 7) {

          flag = false;
        }
        if (flag && gameBoard[testRow][testCol] != 0 && gameBoard[testRow][testCol] != value) {

          while (flag2) {
            testRow++;
            if (testRow > 7) {
              flag2 = false;
            } else if (gameBoard[testRow][testCol] == value) {
              return true;
            }
          }
        }
      }
      if (i == 6) {
        testRow = row + 1;
        testCol = col - 1;
        if (testRow > 7 || testCol < 0) {

          flag = false;
        }
        if (flag && gameBoard[testRow][testCol] != 0 && gameBoard[testRow][testCol] != value) {

          while (flag2) {
            testCol--;
            testRow++;
            if (testCol < 0 || testRow > 7) {
              flag2 = false;
            } else if (gameBoard[testRow][testCol] == value) {
              return true;
            }
          }
        }
      }
      if (i == 7) {
        testRow = row;
        testCol = col - 1;
        if (testCol < 0) {
          flag = false;
        }
        if (flag && gameBoard[testRow][testCol] != 0 && gameBoard[testRow][testCol] != value) {
          while (flag2) {
            testCol--;
            if (testCol < 0) {
              flag2 = false;
            } else if (gameBoard[testRow][testCol] == value) {
              return true;
            }
          }
        }
      }
    }

    return false;
  }

  //getters for the next Board
  public Move getLastMove() {
    return lastMove;
  }
  public int getLastPlayer() {
    return lastPlayer;
  }
  public int [][] getGameBoard() {
    return gameBoard;
  }

  //setters to set from the previous Board
  public void setLastMove(Move lastMove) {
    this.lastMove.setRow(lastMove.getRow());
    this.lastMove.setCol(lastMove.getCol());
    this.lastMove.setValue(lastMove.getValue());
  }
  public void setLastPlayer(int lastPlayer) {
    this.lastPlayer = lastPlayer;
  }
  public void setGameBoard(int [][] gameBoard) {
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        this.gameBoard[i][j] = gameBoard[i][j];
      }
    }
  }

  public ArrayList<Board> getChildren(int lastPlayer) {/// TODO: 8/11/2018
    ArrayList<Board> children = new ArrayList<Board>();

    for (int row=0; row<8; row++) {
      for (int col=0; col<8; col++) {
        if (isValid(row, col, lastPlayer)) {
          Board child = new Board(this);
          child.makeMove(row, col, lastPlayer);
          children.add(child);
        }
      }
    }

    return children;/// TODO: 8/11/2018
  }

  public boolean isTerminal() {
    int player;
    if (lastPlayer == 1) {
      player = -1;
    } else {
      player = 1;
    }
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (gameBoard[i][j] == 0 && isValid(i, j, player) ) {
          return false;
        }
      }
    }

    return true;
  }


  public int evaluate() {
    //if the score is > 0 white player wins til depth!
    //if the score is < 0 black player wins til depth!
    //if the score is = 0 it's a draw!
    int score = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (gameBoard[i][j] == 1) {
          score++;
        } else if (gameBoard[i][j] == -1) {
          score--;
        }
      }
    }

    return score;
  }
  public void print() {
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        if (board.getPiece(i, j) == 1) {
          fill(255);
        } else if (board.getPiece(i, j) == -1) {
          fill(0);
        }
        if (board.getPiece(i, j) != 0) {
          circle(75 + 50*i, 75+50*j, 40);
        }
      }
    }
  }

  public int getPiece(int i, int j) {
    return gameBoard[i][j];
  }
}
