Sudoku = require './app'

check_containers = (assert, cell, names)->
  assert.equal container.name, names[i], cell for container, i in cell.containers


module.exports =


  "test map grid coordinates to box" : (beforeExit, assert)->

    grid = new Sudoku.Grid()

    # test a cell in each box
    assert.equal grid.toBox(3,3), 1
    assert.equal grid.toBox(6,1), 2
    assert.equal grid.toBox(7,2), 3
    assert.equal grid.toBox(1,4), 4
    assert.equal grid.toBox(5,5), 5
    assert.equal grid.toBox(8,6), 6
    assert.equal grid.toBox(2,7), 7
    assert.equal grid.toBox(4,8), 8
    assert.equal grid.toBox(9,9), 9

  "test cell containers" : (beforeExit, assert) ->

    grid = new Sudoku.Grid()


    check_containers assert, grid.cells[0], ["col 1", "row 1", "box 1"]

    check_containers assert, grid.cells[8], ["col 9", "row 1", "box 3"]

    check_containers assert, grid.cells[80], ["col 9", "row 9", "box 9"]

