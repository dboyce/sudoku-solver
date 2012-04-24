$(document).ready ->

  class CellModel extends Backbone.Model

    defaults: ->
      content: "_"

    initialize: ->

  class SudokuGrid extends Backbone.Collection

    model: CellModel

    initialize: ->
      @sudoku = new Sudoku()

    populate: ->
      @add(cell:cell) for cell in @sudoku.cells


  class CellView extends Backbone.View

    tagName: "input"

    template: _.template($("#cell-template").html())

    render: ->
      this.$(@el).html(@template(@model.toJSON()))
      return this

  class AppView extends Backbone.View

    initialize: ->
      @grid = new SudokuGrid()
      @grid.bind('add', this.addCell)
      @grid.populate()

    addCell: (cell) =>
      view = new CellView( {model:cell} )
      @.$('#sudoku-form').append(view.render().el)


  new AppView()

