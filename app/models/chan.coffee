class @Chan extends Backbone.RelationalModel
  url: '/'
  parse: (data) -> chanToJSON data

Chan.setup()