$(document).ready ->

  #########################################
  # models/collections
  #########################################

  class CellModel extends Backbone.Model

    defaults: ->
      content: "_"

    initialize: ->

  class BoxModel extends Backbone.Model

    initialize: ->
      @cells = (new CellModel(cell:cell) for cell in @get('box').cells)



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
      @grid.bind('add', this.addCell)
      @grid.populate()

    addCell: (box) =>
      box = new BoxView( {model:box} )
      $('#sudoku-form').append(box.render().el)


  new AppView()

