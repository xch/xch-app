class @PostView extends Backbone.View
  className: 'post'
  render: ->
    @$el.html template 'post', @model.toJSON()
    @