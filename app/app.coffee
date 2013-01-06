sync = Backbone.sync

Backbone.sync = (method, model, options) ->
  method is 'read' and (options = _.defaults options or {},
    dataType: 'html'
  )
  sync method, model, options

Backbone.Mediator.subscribe 'app', ->
  ($ 'head').empty()
    .append(($ '<meta />').attr charset: 'utf8')
    .append(($ '<title />').attr({'data-meta-title'}).text '×Двач')
  ($ 'body').empty()

  new AppRouter()

  Backbone.history.start()