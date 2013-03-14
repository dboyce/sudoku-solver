sudoku-solver
=============

a (probably quite naive) sudoku solver written in coffeescript, with backbone and mocha

hosted here: http://dboyce.github.com/sudoku/

i have no idea if there's an commonly accepted way of solving a sudoku, my approach is as follows:

* create 9*9 Cell objects representing the board
* create 27 Container objects representing every row, column and box on the board
* add each Cell object to the Containers it belongs to
* for each container, for each Cell, eliminate the values of all the other Cells in that container as possibilities
* if you find there is only one possibility left, solve the cell
* keep repeating until you iterate the whole board and don't solve any cells
* hopefully you solved the sudoku...

