should = require('should')
Grid = require('../lib/sudoku').api.Grid

check_containers = (cell, names) ->
  container.name.should.equal(names[i]) for container, i in cell.containers


describe "Grid", ->

  grid = null

  beforeEach ->

    grid = new Grid()


  it "should map grid coordinates to box", ->

      # test a cell in each box
      grid.toBox(3,3).should.equal 1
      grid.toBox(6,1).should.equal 2
      grid.toBox(7,2).should.equal 3
      grid.toBox(1,4).should.equal 4
      grid.toBox(5,5).should.equal 5
      grid.toBox(8,6).should.equal 6
      grid.toBox(2,7).should.equal 7
      grid.toBox(4,8).should.equal 8
      grid.toBox(9,9).should.equal 9

  it "should map cells to their containers", ->

      check_containers grid.cells[0], ["col 1", "row 1", "box 1"]

      check_containers grid.cells[8], ["col 9", "row 1", "box 3"]

      check_containers grid.cells[80], ["col 9", "row 9", "box 9"]

  it "should retrieve cells by the coords", ->

    cell = grid.getCell 1, 9

    cell.x.should.equal 1
    cell.y.should.equal 9

    cell = grid.getCell 8, 9

    cell.x.should.equal 8
    cell.y.should.equal 9


#  "test eliminate possibilities" : (beforeExit, assert) ->
#
#    grid = new Sudoku.Grid
#    rule = new Sudoku.UniquenessRule
#    cell = grid.getCell 1, 1
#
#    cell.solve 1
#
#    rule.apply(container) for container in cell.containers
##
#    # every cell in every affected container now has 1 eliminated...
#    for container in [grid.rows[1], grid.colls[1], grid.boxes[1]]
#      for cell in container.cells
#        assert.ok(not cell.possibleValue(1))
#        assert.equal(cell.possibilities.length, 8) unless cell.solved
#
#
#  "test only possible solution" : (beforeExit, assert) ->
#
#    grid = new Sudoku.Grid
#    rule = new Sudoku.UniquenessRule
#    rule2 = new Sudoku.OnlyPossibleCellRule
#    cell = grid.getCell 2, 8
#
#    grid.solveCell 1, 1, 3
#    grid.solveCell 3, 4, 3
#    grid.solveCell 9, 7, 3
#    grid.solveCell 6, 9, 3
#
#    for container in cell.containers
#      console.log(container.name)
#      rule.apply(container)
#      rule2.apply(container)
#
#    console.log("#{grid.getCell(1, 8).eliminated[3]}")
#
#    console.log("#{cell} #{cell.possibilities}") for cell in grid.boxes[7].cells
#
#    assert.ok cell.solved
#    assert.equal cell.value, 3










