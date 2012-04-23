require "should"
Container = require("../lib/sudoku").api.Container

describe "Container", ->

  container = null

  beforeEach ->

    container = new Container('foo',{cellSolved:->})

  describe "#contains", ->

    it "should return true if a cell in the container is solved with that value", ->

      container.cells.push { solved: true, value: 9}
      container.contains(9).should.be.true


  describe "#cellSolved", ->

    it "should update the solutions map", ->

      cell = {}
      container.cellSolved(cell, 9)

      container.solutions[9].should.equal cell

    it "should update the unsolvedValues list", ->

      cell = {}

      container.unsolvedValues.should.include(9)

      container.cellSolved(cell, 9)

      container.unsolvedValues.should.not.include(9)

    it "should notify other cells in the container when a value is solved", ->

      solvedCell = { solved : true }
      someOtherCell = { possibilities: [1..9] }
      otherOtherCell2 = { possibilities: [1..9] }

      container.cells = [solvedCell, someOtherCell, otherOtherCell2]

      container.cellSolved(solvedCell, 9)

      someOtherCell.possibilities.should.not.include 9
      otherOtherCell2.possibilities.should.not.include 9





