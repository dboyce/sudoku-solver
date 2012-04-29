$(document).ready ->

  #########################################
  # models/collections
  #########################################

  class CellModel extends Backbone.Model

    initialize: ->
      cell = @get('cell')
      @set(
        solved: cell.solved,
        value: cell.value
      )


  class BoxModel extends Backbone.Model

    initialize: ->
      unsorted = (new CellModel(cell:cell) for cell in @get('box').cells)
      @cells = []
      for col in [0..2]
        for row  in [0,3,6]
          @cells.push(unsorted[row + col])
      @cells


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

    render: =>
      $(@el).append(@template(@model.get('cell')))
      return this


  class BoxView extends Backbone.View

    tagName: "table"

    classes: ["left", "middle", "right"]

    attributes: ->

      'class' : @classes[ (@model.get('number') - 1) % 3 ]

    template: _.template($("#box-template").html())

    render: =>
      cellViews = ({markup: $(new CellView(model:cellModel).render().el).html()} for cellModel in @model.cells)
      $(@el).html(@template({cellViews : cellViews}))
      console.log($(@el).html())
      return this

  class AppView extends Backbone.View

    initialize: ->
      @grid = new SudokuGrid()
      @grid.sudoku.update (_) -> [

        _, 6, _,  _, 9, 1,  _, 8, _,
        1, _, 9,  6, 8, _,  4, _, 5,
        _, 5, _,  _, 4, _,  1, _, 6,
        #############################
        6, _, _,  _, _, _,  2, _, _,
        _, 2, 3,  9, _, 4,  7, 1, _,
        _, _, 4,  _, _, _,  _, _, 3,
        #############################
        9, _, 7,  _, 2, _,  _, 3, _,
        3, _, 5,  _, 7, 9,  6, _, 2,
        _, 4, _,  1, 5, _,  _, 7, _,
      ]

      @grid.bind('add', this.addCell)
      @grid.populate()

    addCell: (box) =>
      box = new BoxView( {model:box} )
      $('#sudoku-form').append(box.render().el)


  new AppView()

