module.exports = {
  components: [
    'jquery/jquery',
    'imagesloaded/jquery.imagesloaded',
    'underscore/underscore',
    'backbone/backbone',
    'Backbone-Mediator/backbone-mediator',
    'backbone.babysitter/lib/backbone.babysitter',
    'backbone.declarative/backbone.declarative',
    'backbone-relational/backbone-relational',
    'moment/moment',
    'moment/lang/ru'
  ].map(function (component) {
      return component + '.js'
  })
};