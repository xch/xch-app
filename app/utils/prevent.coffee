@prevent = -> (decorated) -> (event) ->
  event.preventDefault()
  decorated.call @, event