class @ThreadView extends Backbone.View
  className: 'thread'

  template: 'thread'

  postsEvents:
    'add': 'addPost'
    'remove': 'removePost'

  initialize: (options) ->
    @children = new Backbone.ChildViewContainer()
    @collection = @model.get 'posts'
    @bindCollectionEvents @postsEvents

  addPost: (post) ->
    postView = new PostView(model: post)
    postView.render().$el.appendTo (@$ '[data-thread-posts]')
    @children.add postView

  removePost: (post) ->
    if (postView = @children.findByModel(post))
      @children.remove postView
      postView.remove()

  render: ->
    @$el.html template @template, @model.toJSON()
    @

  remove: ->
    @children.each (postView) -> postView.remove()
    super

  leave: -> @remove()