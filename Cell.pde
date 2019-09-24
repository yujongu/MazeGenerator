class Cell {
  
  int row;
  int col;
  boolean visited = false;
  boolean[] walls;
  Cell(int i, int j) {
    this.row = i;
    this.col = j;
    this.walls = new boolean[] {true, true, true, true};//{top, right, bottom, left}
  }

  void show() {
    if(walls[0] == true){
      line(row * size, col * size, row * size + size, col * size);//top
    }
    if(walls[1] == true){
      line(row * size + size, col * size, row * size + size, col * size + size);//right
    }
    if(walls[2] == true){
      line(row * size, col * size + size, row * size + size, col * size + size);//bottom
    }
    if(walls[3] == true){
      line(row * size, col * size, row * size, col * size + size);//left
    }
  }
  
  void highlight(){
    fill(255);
    //ellipseMode(CORNER);
    //ellipse(row * size + size / 4, col * size + size / 4, size / 2, size / 2);
    rect(row * size, col * size, size, size);
  }
  
  
}
