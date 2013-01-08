class @Board extends Backbone.RelationalModel
  idAttribute: 'slug'

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

  url: -> "/#{@getSlug()}/"

  parse: (data) -> boardToJSON data

  getSlug: -> @get 'slug'

Board.setup()