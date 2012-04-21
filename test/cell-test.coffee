require "should"
Cell = require("../src/coffee/app").api.Cell


describe "Cell", ->

  cell = null
  row = null
  col = null
  box = null
  x = 1
  y = 2

  mockContainer = ->
    ret = {cells : []}
    ret.cellSolved = ->
      @cellSolvedCalled = true
    ret

  beforeEach ->
    cell = new Cell([col = mockContainer(), row = mockContainer(), box = mockContainer()], x, y)

  describe "#constructor", ->

    it "should register cell with its containers", ->

      container.cells.should.include cell for container in [col, row, box]

    it "should initialize possible values", ->

      cell.possibilities.should.include[val] for val in [1..9]

    it "should not be solved", ->

      cell.solved.should.not.be.true

  describe "#eliminate", ->

    it "should remove eliminated value from possibilities", ->

      cell.eliminate 1

      cell.possibilities.should.not.include 1

    it "- value should no longer be a possible value ", ->

      cell.possibleValue(1).should.be.true

      cell.eliminate 1

      cell.possibleValue(1).should.not.be.true

    it "should solve the cell if only one possible value remains", ->

      cell.solved.should.be.false

      cell.eliminate val for val in [1..9] when val != 5

      cell.solved.should.be.true

    it "should notify all its containers when it is solved", ->

      cell.solve 1

      container.cellSolvedCalled.should.be.true for container in cell.containers









