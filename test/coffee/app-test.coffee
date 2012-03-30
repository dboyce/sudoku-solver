module "sudoku tests"

test "test map grid coordinates to box", ->

  grid = new Sudoku.Grid()

  equal grid.toBox(3,3), 1
  equal grid.toBox(6,1), 2
  equal grid.toBox(7,2), 3
  equal grid.toBox(1,4), 4
  equal grid.toBox(5,5), 5
  equal grid.toBox(8,6), 6
  equal grid.toBox(2,7), 7
  equal grid.toBox(4,8), 8
  equal grid.toBox(9,9), 9


test "test cell containers", ->

  grid = new Sudoku.Grid()

#  equal grid.rows[1].cells[0], 2
#  equal grid.rows[1].cells[0], grid.rows[1].cells[0]
#  return null
