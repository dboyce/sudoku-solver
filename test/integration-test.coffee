Sudoku = require '../lib/sudoku'
OnlyPossibleCellRule = require("../lib/sudoku").api.OnlyPossibleCellRule


sudoku = new Sudoku

sudoku.update (_) -> [

  _, 6, _,  _, 9, 1,  _, 8, _,
  1, _, 9,  6, 8, _,  4, _, 5,
  _, 5, _,  _, 4, _,  1, _, 6,
  #############################
  6, _, _,  _, _, _,  2, _, _,
  _, 2, 3,  9, _, 4,  7, 1, _,
  _, _, 4,  _, _, _,  _, _, 3,
  #############################
  9, _, 7,  _, 2, _,  _, 3, _,
  3, _, 5,  _, 7, 9,  6, _, 2,
  _, 4, _,  1, 5, _,  _, 7, _,
]

rule = new OnlyPossibleCellRule

console.log sudoku.toString()

#(console.log "#{cell.x}, #{cell.y}: #{cell.possibilities}" for cell in sudoku.boxes[1].cells)

sudoku.solve()
sudoku.solve()

console.log sudoku.toString()

#(console.log "#{cell.x}, #{cell.y}: #{cell.possibilities}" for cell in sudoku.boxes[1].cells)


