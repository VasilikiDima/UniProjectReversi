import java.util.ArrayList;
import java.util.Random;

public class GamePlayer {
    private int maxDepth;
    private int currentPlayer;

    public GamePlayer()
    {
        maxDepth = 2;
        currentPlayer = Board.blackPiece;
    }
    public GamePlayer(int maxDepth, int currentPlayer)
    {
        this.maxDepth = maxDepth;
        this.currentPlayer = currentPlayer;
    }

    //starts MiniMax for the ai
    public Move MiniMax(Board board) {
        if (currentPlayer == Board.blackPiece) {
            return max(new Board(board), 0);
        } else {
            return min(new Board(board), 0);
        }
    }

    public Move max(Board board, int depth) {
        Random r = new Random();

        /* If MAX is called on a state that is terminal or after a maximum depth is reached,
         * then a heuristic is calculated on the state and the move returned.
         */
        if((board.isTerminal()) || (depth == maxDepth)) {
            return new Move(board.getLastMove().getRow(), board.getLastMove().getCol(), board.evaluate());
        }
        //The children-moves of the state are calculated
        ArrayList<Board> children = new ArrayList<Board>(board.getChildren(Board.blackPiece));
        Move maxMove = new Move(Integer.MIN_VALUE);
        //int count = 0;
        for (Board child : children) {
            Move move = min(child, depth + 1);
            if(move.getValue() >= maxMove.getValue()) {
                if ((move.getValue() == maxMove.getValue())) {
                    //If the heuristic has the save value then we randomly choose one of the two moves
                    if (r.nextInt(2) == 0) {
                        maxMove.setRow(child.getLastMove().getRow());
                        maxMove.setCol(child.getLastMove().getCol());
                        maxMove.setValue(move.getValue());

                    }
                } else {
                    maxMove.setRow(child.getLastMove().getRow());
                    maxMove.setCol(child.getLastMove().getCol());
                    maxMove.setValue(move.getValue());
                }
            }
        }
        return maxMove;
    }

    public Move min(Board board, int depth) {
        Random r = new Random();

        if((board.isTerminal()) || (depth == maxDepth)) {
            return new Move(board.getLastMove().getRow(), board.getLastMove().getCol(), board.evaluate());
        }
        ArrayList<Board> children = new ArrayList<Board>(board.getChildren(Board.whitePiece));
        Move minMove = new Move(Integer.MAX_VALUE);
        for (Board child : children) {
            Move move = max(child, depth + 1);
            if(move.getValue() <= minMove.getValue()) {
                if ((move.getValue() == minMove.getValue())) {
                    if (r.nextInt(2) == 0) {
                        minMove.setRow(child.getLastMove().getRow());
                        minMove.setCol(child.getLastMove().getCol());
                        minMove.setValue(move.getValue());
                    }
                } else {
                    minMove.setRow(child.getLastMove().getRow());
                    minMove.setCol(child.getLastMove().getCol());
                    minMove.setValue(move.getValue());
                }
            }
        }
        return minMove;
    }
}
