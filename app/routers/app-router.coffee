class @AppRouter extends Support.SwappingRouter
  routes:
    '!/': 'chan'
    '!/:slug/': 'board'

  initialize: (options) -> @el = ($ 'body')

  board: (slug) ->
    (board = new Board(slug: slug)).fetch().done => @swap new BoardView(model: board)

  chan: ->
    (chan = new Chan()).fetch().done => @swap new ChanView(model: chan)