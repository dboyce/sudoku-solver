$(document).ready ->

  class StringUtil
    trim: (val)->
      val?.replace /^\s+|\s+$/g, ""
    isNumber: (n) ->
      !isNaN(parseFloat(n)) and isFinite(n)

  #########################################
  # models/collections
  #########################################

  class CellModel extends Backbone.Model

    initialize: ->
      @cell = @get('cell')
      @cell.listener = @update
      @update

    update: =>
      @set(
        solved: @cell.solved
        value: @cell.value
      )

    possibleValue: (val) ->
      @cell.possibleValue(val)


  class BoxModel extends Backbone.Model

    initialize: ->
      @cells = (new CellModel(cell:cell) for cell in @get('box').cells)
#      @cells = []
#      for col in [0..2]
#        for row  in [0,3,6]
#          @cells.push(unsorted[row + col])
#      @cells


  class SudokuGrid extends Backbone.Collection

    model: BoxModel

    initialize: ->
      @sudoku = new Sudoku()

    populate: ->
      @add(box:box,number:i) for box,i in @sudoku.boxes when box?

  #########################################
  # views
  #########################################

  class CellView extends Backbone.View

    tagName: "span"

    template: _.template($("#cell-template").html())

    events:
      "change input.cell": "update"

    update: ->
      input = $(@el).find('input')
      $(@el).removeClass('error')
      val = StringUtil::trim(input.val())
      return if not val?
      if !StringUtil::isNumber(val) or +val < 1 or +val > 9 or not @model.possibleValue(+val)
        $(@el).addClass('error')
        input.val('  ' + input.val())
      else
        @model.cell.solved = false
        @model.cell.solve(+($(@el).find('input').val()))

    initialize: ->
      @model.on('change', @render)

    render: =>
      $(@el).html(@template(@model.get('cell')))
      return this


  class BoxView extends Backbone.View

    tagName: "table"

    classes: ["left", "middle", "right"]

    attributes: ->
      'class' : @classes[ (@model.get('number') - 1) % 3 ]
      'cellspacing' : 0
      'cellpadding' : 0

    initialize: -> @cellViews = (new CellView(model:cellModel) for cellModel in @model.cells)

    render: =>
      $tr = null
      for cellView, i in @cellViews
        $tr = $('<tr></tr>').appendTo($(@el)) if i % 3 == 0
        $('<td></td>').appendTo($tr).append(cellView.render().el)
      @

  class AppView extends Backbone.View

    el: $("#grid")

    events:
      "click #solve" : "solve",
      "click #reset" : "reset"

    solve: ->
      @grid.sudoku.solve()

    reset: ->
      $('#sudoku-form').children().remove()
      @initialize()

    loadDemos: ->
      $demo = $('#demo')
      demos = SudokuSolverDemos::demos
      for name of demos
        $("<option>#{name}</option>").appendTo($demo)
      $demo.change =>
        factory = SudokuSolverDemos::demos[$demo.val()]
        if factory?
          @reset()
          @grid.sudoku.update(factory)

    initialize: ->
      @grid = new SudokuGrid()
      @grid.bind('add', this.addCell)
      @grid.populate()
      @loadDemos() if $('#demo').children().length < 2

    addCell: (box) =>
      box = new BoxView( {model:box} )
      $('#sudoku-form').append(box.render().el)


  new AppView()

