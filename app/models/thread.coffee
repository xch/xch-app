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