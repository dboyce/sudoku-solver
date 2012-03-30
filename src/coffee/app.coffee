class Cell
  constructor: (@containers) ->
    @possibilities = [1..9]
    @solved = false
    container.cells.push(@) for container in @containers

  @eliminate: (val) ->
    unless @solved
      @possibilities.splice(@possibilities.indexOf(val), 1)
      @solved = @possibilities.length == 1
      @value = @possibilities[0]
    @solved

class Container
  constructor: ->
    @cells = []

  contains: (val) ->
    for cell in @cells
      if cell.solved and cell.value == val
        return true
    return false

class Grid
  constructor: ->

    @rows  = []
    @colls = []
    @boxes = []

    for i in [1..9]
      @rows[i] = new Container()
      @colls[i] = new Container()
      @boxes[i] = new Container()

    for y in [1..9]
      for x in [1..9]
        new Cell([@rows[x], @colls[y], @boxes[@toBox(x,y) ]])

  toBox:(x,y) ->
    1 + 3 * Math.floor((y - 1) / 3) + Math.floor((x - 1) / 3)



class Rule
  constructor: ->

class UniquenessRule
  apply: (cell) ->
    for container in cell.containers
      for val in cell.possibilities
        unless container.contains(val)
          break if cell.eliminate(val)

exports = exports || window

exports.Sudoku =
  Cell : Cell
  Container : Container
  Grid : Grid
  Rule : Rule
  UniquenessRule : UniquenessRule















