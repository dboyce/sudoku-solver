##########################################
# Utils
##########################################

class ArrayUtil
  remove: (array, element) ->
    index = array.indexOf(element)
    array.splice(index, 1) if index isnt -1


##########################################
# Represents a grid cell
##########################################
class Cell
  constructor: (@containers, @x, @y) ->
    @possibilities = [1..9]
    @eliminated = {}
    @solved = false
    container.cells.push(@)  for container in @containers

  eliminate: (val) ->

    unless @solved
#      console.log("#{@} eliminating #{val}")
      ArrayUtil::remove(@possibilities, val)
      @eliminated[val] = true
      @solve val if @possibilities.length is 1
    @solved

  solve: (val) ->
    unless @solved
      @value = val
      @solved = true
      @possibilities = []
      @eliminated = {}
      container.cellSolved(@, val) for container in @containers
    @solved

  possibleValue: (val) ->
    not @solved and not @eliminated[val]?

  toString: ->
    val = "cell #{@x},#{@y}"


##########################################
# Represents a row, column or grid
##########################################
class Container
  constructor: (@name) ->
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

    for i in [1..9]
      @rows[i] = new Container("row #{i}")
      @colls[i] = new Container("col #{i}")
      @boxes[i] = new Container("box #{i}")

    for y in [1..9]
      for x in [1..9]
        @cells.push(new Cell([@colls[x], @rows[y], @boxes[@toBox(x,y) ]], x, y))

  solveCell: (x, y, val) ->
    @getCell(x, y).solve val

  toBox:(x,y) ->
    1 + 3 * Math.floor((y - 1) / 3) + Math.floor((x - 1) / 3)

  getCell: (x,y) ->
    @cells[x - 1 + 9 * (y - 1)]

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
    for val in container.unsolvedValues

      candidate = null

      for cell in container.cells
        if cell.possibleValue val
          if candidate? # more than one candidate
#            console.log "more than one candidate for #{val} - (#{cell.x}, #{cell.y}) and (#{candidate.x},#{candidate.y}"
            candidate = null
            break
          else
            candidate = cell

      candidate.solve val if candidate?

if exports?
  root = module.exports
else
  root = {}
  window.Sudoku = root

Grid.api =
  'Cell' : Cell
  'Container' : Container
  'Grid' : Grid
  'UniquenessRule' : UniquenessRule
  'OnlyPossibleCellRule' : OnlyPossibleCellRule

module.exports = Grid















