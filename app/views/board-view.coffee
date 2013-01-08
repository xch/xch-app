class @BoardView extends Backbone.View
  threadsEvents:
    'add': 'addThread'
    'remove': 'removeThread'

  initialize: (options) ->
    @children = new Backbone.ChildViewContainer()
    @collection = @model.get 'threads'
    @bindCollectionEvents @threadsEvents

  addThread: (thread) ->
    threadView = new BoardThreadView(model: thread)
    threadView.render().$el.appendTo (@$ '[data-board-threads]')
    @children.add threadView

  removeThread: (thread) ->
    if (threadView = @children.findByModel(thread))
      @children.remove threadView
      threadView.remove()

  render: ->
    @$el.html template 'board', @model.toJSON()
    @

  remove: ->
    @children.each (threadView) -> threadView.remove()
    super

  leave: ->
    @remove()