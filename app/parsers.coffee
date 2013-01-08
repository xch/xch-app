val     = trim()            (el) -> el.val()
text    = trim()            (el) -> el.text()
html    = trim()            (el) -> el.html()
attr    = (attr) -> trim()  (el) -> el.attr attr
string  = trim()            (el) -> el.clone().children().remove().end().text()

query = (data) -> (helper) -> helper ($ data), data
queryAll = (data) -> (selector, helper) -> helper ($ selector, data), data

parser = (data, struct) ->
  _.object _.map struct, ([selector, helper], attribute) ->
    [
      attribute
      (helper and queryAll or query)(data)(selector, helper)
    ]

map = (parser) -> (els) -> (els.map (__, el) -> parser el).toArray()

id = (el) -> (match = (attr('id')(el)).match(/(\d+)/g)) and match and match[0]
speed = (__, data) -> data.match(/\<\!--\<div\sclass\=\"speed\"\>--\>\[Скорость\sборды\:\s(\d+)\sп\.\/час\]\<\!--\<\/div\>--\>/)[1]
omit = (el) -> text(el).match /(\d+)/g

nav = (->
  escape = -> (helper) -> (el) -> helper.call(@, el).replace /\s|\]|\[|\||\//g, String()
  title = trim() escape() string
  board = (data) -> parser data,
    slug: [attr 'href']
    name: [text]
    title: [attr 'title']
  (data) -> parser data,
    title: [title]
    boards: ['a', map board]
)()

post = (data) -> parser data,
  id: [id]
  subject: ['.filetitle', text]
  poster: ['.postername', text]
  createdAt: ['.posttime', text]
  html: ['.postMessage', html]
  img: ['[name=expandfunc]', attr 'href']
  thumb: ['img.img', attr 'src']

thread = @threadToJSON = (data) -> parser data,
  id: [id]
  title: ['#title center', text]
  omit: ['.omittedposts', omit]
  post: ['.oppost', post]
  posts: ['.post', map post]

@boardToJSON = (data) ->
  parser data,
    title: ['#title center', text]
    threads: ['.thread', map thread]
    nav: ['.nowrap', map nav]
    speed: [speed]

@chanToJSON = (->
  board = (data) -> parser data,
    slug: [attr 'href']
    title: [text]
  section = (data) -> parser data,
    title: ['.btitle span', text]
    boards: ['.togglediv li a', map board]
  (data) -> parser data,
    sections: ['.right .bline', map section]
)()
