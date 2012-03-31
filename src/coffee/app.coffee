class Cell
  constructor: (@containers, @x, @y) ->
    @possibilities = [1..9]
    @solved = false
    container.cells.push(@) for container in @containers

  eliminate: (val) ->
    unless @solved
      @possibilities.splice(@possibilities.indexOf(val), 1)
      @solved = @possibilities.length == 1
      @value = @possibilities[0]
    @solved

  toString: ->
    val = "cell: #{@containers}"



class Container
  constructor: (@name) ->
    @cells = []

  contains: (val) ->
    for cell in @cells
      if cell.solved and cell.value == val
        return true
    return false

  toString: ->  @name

class Grid
  constructor: ->

    @rows  = []
    @colls = []
    @boxes = []
    @cells = []

    for i in [1..9]
      @rows[i] = new Container("row #{i}")
      @colls[i] = new Container("col #{i}")
      @boxes[i] = new Container("box #{i}")

    for y in [1..9]
      for x in [1..9]
        @cells.push(new Cell([@colls[x], @rows[y], @boxes[@toBox(x,y) ]], x, y))

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


if exports?
  root = module.exports
else
  root = {}
  window.Sudoku = root

module.exports =
  'Cell' : Cell
  'Container' : Container
  'Grid' : Grid
  'Rule' : Rule
  'UniquenessRule' : UniquenessRule















