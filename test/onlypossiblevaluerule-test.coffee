OnlyPossibleCellRule = require("../src/coffee/app").api.OnlyPossibleCellRule

describe "OnlyPossibleCellRule", ->

  rule = null


  mockCell = (possibleValues)->
    {
      possibleValue : (v) ->
        possibleValues.indexOf(v) != -1
      solve : (v) ->
        @solved = true
        @v = v
      solved : false
    }

  mockContainer = (unsolvedValues, cells) ->
      unsolvedValues: unsolvedValues
      cells : cells

  beforeEach ->
    rule = new OnlyPossibleCellRule()

  describe "#eval" ,->

    it "should solve the only possible cell which can contain a value", ->

      cells = (mockCell(if v == 1 then [1] else [2..9]) for v in [1..9])
      container = mockContainer([1], cells)
      rule.eval(container)

      cells[0].solved.should.be.true



