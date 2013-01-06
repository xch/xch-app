class @Board extends Backbone.RelationalModel
  relations: [
    {
      type: 'HasMany'
      key: 'threads'
      relatedModel: 'Thread'
      collectionType: 'Threads'
      reverseRelation:
        key: 'board'
    }
  ]