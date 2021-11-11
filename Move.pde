public class Move {
    private int row, col, value;


    public Move(){//empty constructor
        row = -1;
        col = -1;
        value = 0;
    }
    public Move(int row, int col){
        this.row = row;
        this.col = col;
        value = -1;
    }
    public Move(int value){
        row = -1;
        col = -1;
        this.value = value;
    }
    public Move(int row, int col, int value){//full constructor
        this.row = row;
        this.col = col;
        this.value = value;
    }

    public int getRow() {
        return row;
    }
    public void setRow(int row) {
        this.row = row;
    }

    public int getCol() {
        return col;
    }
    public void setCol(int col) {
        this.col = col;
    }

    public int getValue() {
        return value;
    }
    public void setValue(int value) {
        this.value = value;
    }
}
