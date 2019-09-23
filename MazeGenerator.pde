int size = 15;
ArrayList<Cell> grid = new ArrayList<Cell>();
void setup() {
  size(800, 800);
  for(int i = 0; i < floor(width / size); i++){
    for(int j = 0; j < floor(height / size); j++){
      Cell cell = new Cell(i, j);
      grid.add(cell);
    }
  }
  
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  
  
  for(int i = 0; i < grid.size(); i++){
    grid.get(i).show();
  }
}
