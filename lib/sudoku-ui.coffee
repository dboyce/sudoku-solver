$(document).ready ->

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

    attributes: -> 'class' : @classes[ (@model.get('number') - 1) % 3 ]

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
      "click #solve" : "solve"

    solve: ->
      @grid.sudoku.solve()


    initialize: ->
      @grid = new SudokuGrid()
#      @grid.sudoku.update (_) -> [
#
#        _, 6, _,  _, 9, 1,  _, 8, _,
#        1, _, 9,  6, 8, _,  4, _, 5,
#        _, 5, _,  _, 4, _,  1, _, 6,
#        #############################
#        6, _, _,  _, _, _,  2, _, _,
#        _, 2, 3,  9, _, 4,  7, 1, _,
#        _, _, 4,  _, _, _,  _, _, 3,
#        #############################
#        9, _, 7,  _, 2, _,  _, 3, _,
#        3, _, 5,  _, 7, 9,  6, _, 2,
#        _, 4, _,  1, 5, _,  _, 7, _,
#      ]

      @grid.bind('add', this.addCell)
      @grid.populate()

    addCell: (box) =>
      box = new BoxView( {model:box} )
      $('#sudoku-form').append(box.render().el)


  new AppView()

