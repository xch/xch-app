chrome.extension.sendMessage {}, ->
  {readyState} = document
  timer = setInterval (->
    if readyState is 'complete'
      clearInterval timer
      Backbone.Mediator.publish 'app'
  ), 10
