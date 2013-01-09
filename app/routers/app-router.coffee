class @AppRouter extends Support.SwappingRouter
  routes:
    '!/': 'chan'
    '!/:boardId/': 'board'
    '!/:boardId/:id/': 'thread'

  initialize: (options) ->
    @el = ($ 'body')

    Backbone.Mediator.subscribe 'popup', (boardId, threadId, postId, event) ->
      thread = Thread.findOrCreate id: "#{boardId}-#{threadId}"
      post = thread.get('posts').get("#{boardId}-#{postId}")
      popup = new PostView(model: post)
      el = popup.render().$el.appendTo ($ 'body')
      el.addClass 'free'
      el.css
        left: event.pageX
        top: event.pageY

  thread: (boardId, uri) ->
    thread = Thread.findOrCreate {boardId, uri}
    thread.fetch().done =>
      @swap new ThreadView(model: thread)
      posts = thread.get 'posts'
      posts.each (post) ->
        posts.trigger 'add', post

  board: (boardId) ->
    board = Board.findOrCreate id: boardId
    board.fetch().done =>
      @swap new BoardView(model: board)
      threads = board.get 'threads'
      threads.each (thread) ->
        threads.trigger 'add', thread
        posts = thread.get 'posts'
        posts.each (post) ->
          posts.trigger 'add', post
  chan: -> _.tap new Chan(), (chan) => chan.fetch().done => @swap new ChanView(model: chan)