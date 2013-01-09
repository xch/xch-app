class @Board extends Backbone.RelationalModel
  relations: [
    {
      autoFetch: on
      type: 'HasMany'
      key: 'threads'
      relatedModel: 'Thread'
      reverseRelation:
        key: 'board'
    }
  ]
  getId: -> @get 'id'
  url: -> "/#{@getId()}/"
  fetch: (options) -> (@sync 'read', @, options).done (data) => @set boardToJSON data, @getId()
