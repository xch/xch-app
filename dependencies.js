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
    'backbone-support/lib/assets/javascripts/backbone-support/support',
    'backbone-support/lib/assets/javascripts/backbone-support/observer',
    'backbone-support/lib/assets/javascripts/backbone-support/composite_view',
    'backbone-support/lib/assets/javascripts/backbone-support/swapping_router',
    'moment/moment',
    'moment/lang/ru'
  ].map(function (component) {
      return 'components/' + component + '.js'
  }),
  templates: [
    'runtime',
    '*'
  ].map(function (template) {
      return 'cache/templates/' + template + '.js'
  }),
  app: [
    'plural',
    'template',
    'prevent',
    'stop',
    'trim',
    'parsers',
    'post',
    'posts',
    'thread',
    'threads',
    'board',
    'chan',
    'chan-view',
    'board-view',
    'app-router',
    'app'
  ].map(function (dependency) {
      return 'cache/app/' + dependency + '.js'
  })
}