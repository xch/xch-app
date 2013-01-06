class @ChanView extends Backbone.View
  render: ->
    @$el.html template 'chan', @model.toJSON()
    @
  leave: ->
    @remove()