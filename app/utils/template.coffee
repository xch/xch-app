datetime = (value) -> moment(value).format 'H:m, do MMMM YYYY'

boardUrl = (slug) -> "/x/#!#{slug}"
url = (arg) -> (/http\:\/\//.test arg) and arg or boardUrl arg

@template = (name, params) ->
  jade.templates[name] _.defaults (params or {}), {_, moment, datetime, plural, adjective, url}
