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

  "test get cell by coords" : (beforeExit, assert) ->

    grid  = new Sudoku.Grid()

    cell = grid.getCell 1, 9

    assert.equal cell.x, 1
    assert.equal cell.y, 9

    cell = grid.getCell 8, 9

    assert.equal cell.x, 8
    assert.equal cell.y, 9

  "test eliminate possibilities" : (beforeExit, assert) ->

    grid = new Sudoku.Grid
    rule = new Sudoku.UniquenessRule

    grid.colls[1].cells[0].solve 1

    rule.apply(container) for container in grid.colls[1].cells[0].containers

    # every cell in every affected container now has 1 eliminated...
    for container in [grid.rows[1], grid.colls[1], grid.boxes[1]]
      assert.ok(not cell.possibleValue(1))  for cell in container.cells

  "test resolve value" : (beforeExit, assert) ->

#    grid = new Sudoku.Grid
#
#    grid.solveCell 1, 1, 3
#    grid.solveCell 9, 3, 3
#    grid.solveCell 4, 9, 3
#    grid.solveCell 6, 6, 3
#
#    assert.ok grid.getCell(5, 2).solved
#    assert.equal grid.getCell(5, 2).value, 3










