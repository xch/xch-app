class @Thread extends Backbone.RelationalModel
  relations: [
    {
      type: 'HasOne'
      key: 'post'
      relatedModel: 'Post'
    }
    {
      type: 'HasMany'
      key: 'posts'
      relatedModel: 'Post'
      reverseRelation:
        key: 'thread'
    }
  ]

  url: -> "/#{@getSlug()}/res/#{@getId()}.html"

  fetch__: (options) ->
    options = if options then _.clone(options) else {}
    (options.parse isnt off) and (options.parse = on)
    success = options.success
    options.success = (model, resp, options) =>
      return no if not @set (threadToJSON model), options
      (success model, resp, options) if success
    @sync 'read', @, options

  parse__: (data) -> threadToJSON data

  getSlug: -> @get 'slug'

  getId: -> @get 'id'

Thread.setup()