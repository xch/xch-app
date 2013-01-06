@stop = -> (decorated) -> (event) ->
  event.stopPropagation()
  decorated.call @, event