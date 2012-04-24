##########################################
# Utils
##########################################

class ArrayUtil
  remove: (array, element) ->
    index = array.indexOf(element)
    array.splice(index, 1) if index isnt -1
  flatten: (arrays) ->
    [].concat.apply([], arrays)
  copy: (array) ->
    @flatten(array)


##########################################
# Represents a grid cell
##########################################
class Cell
  constructor: (@containers, @x, @y) ->
    @possibilities = [1..9]
    @solved = false
    container.cells.push(@)  for container in @containers

  eliminate: (val) ->

    unless @solved
#      console.log("#{@} eliminating #{val}")
      ArrayUtil::remove(@possibilities, val)
      @solve val if @possibilities.length is 1
    @solved

  solve: (val) ->
    unless @solved
      @value = val
      @solved = true
      @possibilities = []
      container.cellSolved(@, val) for container in @containers
    @solved

  possibleValue: (val) ->
    not @solved and @possibilities.indexOf(val) != -1

  toString: ->
    val = "cell #{@x},#{@y}"


##########################################
# Represents a row, column or grid
##########################################
class Container
  constructor: (@name, @grid) ->
    @cells = []
    @solutions = {}
    @unsolvedValues = [1..9]

  contains: (val) ->
    for cell in @cells
      if cell.solved and cell.value == val
        return true
    return false

  cellSolved: (cell, val) ->
#    console.log("cell solved: #{cell} -> #{val}")
    @solutions[val] = cell
    ArrayUtil::remove(@unsolvedValues, val)
    ArrayUtil::remove(cell.possibilities, val) for cell in @cells when not cell.solved
    @grid.cellSolved(cell, val)
    return null

  toString: ->  @name

##########################################
# Represents the grid
##########################################
class Grid
  constructor: ->

    @rows  = []
    @colls = []
    @boxes = []
    @cells = []
    @rules = [new OnlyPossibleCellRule()]
    @unsolvedCells = 81
    @solved = false

    for i in [1..9]
      @rows[i] = new Container("row #{i}", @)
      @colls[i] = new Container("col #{i}", @)
      @boxes[i] = new Container("box #{i}", @)

    for y in [1..9]
      for x in [1..9]
        @cells.push(new Cell([@colls[x], @rows[y], @boxes[@toBox(x,y) ]], x, y))

  cellSolved: (cell,val) ->
    @unsolvedCells--
    @solved = @unsolvedCells < 1

  toBox:(x,y) ->
    1 + 3 * Math.floor((y - 1) / 3) + Math.floor((x - 1) / 3)

  getCell: (x,y) ->
    @cells[x - 1 + 9 * (y - 1)]

  update: (values) ->
    values = values(null)
    throw "size of update array must be 81" if not values.size == 81
    @cells[i].solve(val) for val, i in values when not (val is 0 or not val?)

  solve: ->
    done = false
    while not done
      unsolvedCells = @unsolvedCells
      for container in ArrayUtil::flatten([ @rows, @colls, @boxes]) when container?
        for rule in @rules
          rule.eval(container)
      done = unsolvedCells == @unsolvedCells

  toString: ->

    spacer = ('-' for i in [1..31]).join('') + '\n'
    str = "\n #{spacer} |"
    for cell, i in @cells

      str = str + ' ' + (cell.value ? '_') + ' '
      str = str + '|'  if (i + 1) % 3 == 0 and i > 0

      if i > 0
        if (i + 1) % 27 is 0
          str = str + "\n #{spacer} |"
        else if (i + 1) % 9 == 0
          str = str + '\n |'

    str = str[..str.length - 2]

    str

class UniquenessRule

  eval : (container) ->
#    console.log("#{container} solutions: #{container.solutions}")
    for own val, solvedCell of container.solutions
#      console.log("checking for uniqueness of #{val} in #{container.cells}")
      for cell in container.cells
        cell.eliminate(val) unless cell.solved
    null

class OnlyPossibleCellRule

  eval: (container) ->

    for val in ArrayUtil::copy(container.unsolvedValues)

      candidate = null

      for cell in container.cells
        if cell.possibleValue val
          if candidate? # more than one candidate
#            console.log "more than one candidate for #{val} - (#{cell.x}, #{cell.y}) and (#{candidate.x},#{candidate.y})"
            candidate = null
            break
          else
            candidate = cell

#      console.log "solving #{candidate.toString()} #{val}" if candidate?
      candidate.solve val if candidate?

Grid.api =
  'Cell' : Cell
  'Container' : Container
  'Grid' : Grid
  'UniquenessRule' : UniquenessRule
  'OnlyPossibleCellRule' : OnlyPossibleCellRule

if exports?
  module.exports = Grid
else
  window.Sudoku = Grid














