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
  getBoardId: -> @get 'boardId'
  getId: -> @get 'id'
  getUri: -> @get 'uri'
  url: -> "/#{@getBoardId()}/res/#{@getUri()}.html"
  fetch: (options) -> (@sync 'read', @, options).done (data) => @set threadToJSON data, @getBoardId()
