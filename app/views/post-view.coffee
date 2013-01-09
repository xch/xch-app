extract = (el) -> el.data('href').match(/\/(\w+)\/res\/(\d+)\.html\#(\d+)/) or []

class @PostView extends Backbone.View
  className: 'post'
  events:
    'mouseenter .post-text a': 'popin'
    'mouseleave .post-text a': 'popout'

  popout: (event) ->
    ($ '.post.free').remove()

  popin: (event) ->
    [__, board, thread, post] = extract ($ event.target)
    Backbone.Mediator.publish 'popup', board, thread, post, event

  render: ->
    @$el.html template 'post', @model.toJSON()
    @