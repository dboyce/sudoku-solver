require "should"
Cell = require("../src/coffee/app").api.Cell

describe "Cell", ->

  cell = null
  row = null
  col = null
  box = null
  x = 1
  y = 2

  beforeEach ->
    cell = new Cell([col = {cells : []}, row = {cells: []}, box = {cells: []}], x, y)

  describe "#constructor", ->

    it "should register cell with its containers", ->

      container.cells.should.include cell for container in [col, row, box]

    it "should initialize possible values", ->

      cell.possibilities.should.include[val] for val in [1..9]

    it "should not be solved", ->

      cell.solved.should.not.be.true



