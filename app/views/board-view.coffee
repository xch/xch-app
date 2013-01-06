class @BoardView extends Backbone.View
  render: ->
    @$el.html template 'board', @model.toJSON()
    @

  leave: -> @remove()