fetcher = (model, options) -> model.fetch(options)

fetch = (Model, keys, fetch = fetcher) ->
  (params...) ->
    defer = new $.Deferred()
    if (model = Model.findOrCreate(params[0]))
      options =
        update: on
        add: on
    else
      model = new Model()
      options = {}
    model.set _.object keys, params
    fetch(model, options).done -> defer.resolve model
    defer.promise()

class @AppRouter extends Support.SwappingRouter
  routes:
    '!/': 'chan'
    '!/:slug/': 'board'
    '!/:slug/:id/': 'thread'

  initialize: (options) -> @el = ($ 'body')

  thread: (slug, id) ->
    fetch(Thread, ['id', 'slug'], (model, options) -> model.fetch__(options))(id, slug).done (thread) =>
      @swap new ThreadView(model: thread)
      (posts = thread.get('posts')).each (post) -> posts.trigger 'add', post

  board: (slug) ->
    fetch(Board, ['slug'])(slug).done (board) =>
      @swap new BoardView(model: board)
      (threads = board.get('threads')).each (thread) ->
        threads.trigger 'add', thread
        (posts = thread.get('posts')).each (post) ->
          posts.trigger 'add', post

  chan: ->
    (chan = new Chan()).fetch().done => @swap new ChanView(model: chan)