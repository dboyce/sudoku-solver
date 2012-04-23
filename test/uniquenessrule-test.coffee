UniquenessRule = require("../lib/sudoku").api.UniquenessRule

describe "UniquenessRule", ->

  rule = null


  mockCell = (possibleValues)->
    possibleValue : (v) ->
      possibleValues.indexOf(v) is not -1
    solve : ->
      possibleValues = []
    eliminate : (v) ->
      possibleValues.splice(possibleValues.indexOf(+v), 1)


  mockContainer = (solutions, cells) ->
    solutions: solutions
    cells : cells

  beforeEach ->
    rule = new UniquenessRule()

  describe "#eval" ,->

    it "should eliminate possibilities already solved in the given container", ->

      cells = (mockCell([1..9]) for v in [1..9])
      cells[0].solve 1
      container = mockContainer({1: cells[0]}, cells)

      rule.eval(container)

      cell.possibleValue(1).should.be.false for cell in cells



