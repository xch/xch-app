class @Chan extends Backbone.RelationalModel
  url: '/'
  fetch: (options) -> (@sync 'read', @, options).done (data) => @set chanToJSON data
