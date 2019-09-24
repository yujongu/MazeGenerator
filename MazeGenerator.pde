import java.util.Stack;


int size = 15;
int runSpeed = 1;//higher the slower



int gridWallSize;
ArrayList<Cell> grid = new ArrayList<Cell>();
Stack<Cell> stack = new Stack<Cell>();


Cell currCell;
void setup() {
  size(901, 901);
  gridWallSize = floor(width / size);
  for (int i = 0; i < floor(width / size); i++) {
    for (int j = 0; j < floor(height / size); j++) {
      Cell cell = new Cell(i, j);
      grid.add(cell);
    }
  }
  //1. Make the initial cell the current cell and mark it as visited
  currCell = grid.get(0);
  grid.get(0).visited = true;
  background(0);
  delay(10000);
}

void draw() {
  background(0);
  stroke(255);
  noFill();

  if (runSpeed == 0) {
    while (checkUnvisited() == true) { //2. While there are unvisited cells

      if (getUnvisitedCell(currCell).size() != 0) { //1. If the current cell has any neighbours which have not been visited
        ArrayList<Integer> hold = getUnvisitedCell(currCell);

        Cell chosenCell = grid.get(hold.get((int) random(0, hold.size()))); //1. Choose randomly one of the unvisited neighbours

        if (hold.size() > 1) { //2. Push the current cell to the stack if it has more than one unvisited neighbor
          stack.push(currCell);
        }

        //3. Remove the wall between the current cell and the chosen cell
        //check which cell(top, right, bottom, left) is the chosen cell
        if (currCell.row - 1 == chosenCell.row) {//top was chosen
          currCell.walls[3] = false;
          chosenCell.walls[1] = false;
        } else if (currCell.row + 1 == chosenCell.row) {//bottom was chosen
          currCell.walls[1] = false;
          chosenCell.walls[3] = false;
        } else {
          if (currCell.col + 1 == chosenCell.col) {//right was chosen
            currCell.walls[2] = false;
            chosenCell.walls[0] = false;
          } else if (currCell.col - 1 == chosenCell.col) {//left was chosen
            currCell.walls[0] = false;
            chosenCell.walls[2] = false;
          }
        }

        //4. Make the chosen cell the current cell and mark it as visited
        currCell = chosenCell;
        currCell.visited = true;
      } else if (stack.size() != 0) { //2. Else if stack is not empty

        //1. Pop a cell from the stack while the stack is not empty and the popped cell has no unvisited neighbors
        currCell = stack.pop(); //2. Make it the current cell
      }
      currCell.highlight();
    }
  } else {
    if (checkUnvisited() == true) { //2. While there are unvisited cells

      if (getUnvisitedCell(currCell).size() != 0) { //1. If the current cell has any neighbours which have not been visited
        ArrayList<Integer> hold = getUnvisitedCell(currCell);

        Cell chosenCell = grid.get(hold.get((int) random(0, hold.size()))); //1. Choose randomly one of the unvisited neighbours

        if (hold.size() > 1) { //2. Push the current cell to the stack if it has more than one unvisited neighbor
          stack.push(currCell);
        }

        //3. Remove the wall between the current cell and the chosen cell
        //check which cell(top, right, bottom, left) is the chosen cell
        if (currCell.row - 1 == chosenCell.row) {//top was chosen
          currCell.walls[3] = false;
          chosenCell.walls[1] = false;
        } else if (currCell.row + 1 == chosenCell.row) {//bottom was chosen
          currCell.walls[1] = false;
          chosenCell.walls[3] = false;
        } else {
          if (currCell.col + 1 == chosenCell.col) {//right was chosen
            currCell.walls[2] = false;
            chosenCell.walls[0] = false;
          } else if (currCell.col - 1 == chosenCell.col) {//left was chosen
            currCell.walls[0] = false;
            chosenCell.walls[2] = false;
          }
        }

        //4. Make the chosen cell the current cell and mark it as visited
        currCell = chosenCell;
        currCell.visited = true;
      } else if (stack.size() != 0) { //2. Else if stack is not empty

        //1. Pop a cell from the stack while the stack is not empty and the popped cell has no unvisited neighbors
        currCell = stack.pop(); //2. Make it the current cell
      }
      currCell.highlight();
      delay(runSpeed);
    }
  }




  for (int i = 0; i < grid.size(); i++) {
    grid.get(i).show();
  }

  if (runSpeed != 0) {
    delay(runSpeed);
  }
}

ArrayList<Integer> getUnvisitedCell(Cell currentCell) { //returns the ArrayList storing indices of unvisited neighboring cell of the current cell
  boolean[] cellPresent = new boolean[] {true, true, true, true}; //{top, right, bottom, left}

  //checks if there is a neighboring cell present
  if (currentCell.row == 0) { //no Top
    cellPresent[0] = false;
  }
  if (currentCell.col == gridWallSize - 1) { //no Right
    cellPresent[1] = false;
  }
  if (currentCell.row == gridWallSize - 1) { //no Bottom
    cellPresent[2] = false;
  }
  if (currentCell.col == 0) { //no Left
    cellPresent[3] = false;
  }

  //gets the index of the present unvisited neighboring cell
  ArrayList<Integer> unvisitedCellInd = new ArrayList<Integer>();
  for (int i = 0; i < 4; i++) {
    if (cellPresent[i] == true) {
      if (i == 0) {
        if (grid.get(currentCell.row * gridWallSize + currentCell.col - gridWallSize).visited == false) {
          unvisitedCellInd.add(currentCell.row * gridWallSize + currentCell.col - gridWallSize);
        }
      } else if (i == 1) {
        if (grid.get(currentCell.row * gridWallSize + currentCell.col + 1).visited == false) {
          unvisitedCellInd.add(currentCell.row * gridWallSize + currentCell.col + 1);
        }
      } else if (i == 2) {
        if (grid.get((currentCell.row + 1) * gridWallSize + currentCell.col).visited == false) {
          unvisitedCellInd.add((currentCell.row + 1) * gridWallSize + currentCell.col);
        }
      } else if (i == 3) {
        if (grid.get(currentCell.row * gridWallSize + currentCell.col - 1).visited == false) {
          unvisitedCellInd.add(currentCell.row * gridWallSize + currentCell.col - 1);
        }
      }
    }
  }
  return unvisitedCellInd;
}

boolean checkUnvisited() { //if there is any unvisited cell, return true;
  for (int i = 0; i < grid.size(); i++) {
    if (grid.get(i).visited == false) {
      return true;
    }
  }
  return false;
}
