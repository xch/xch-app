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

speed = (__, data) -> data.match(/\<\!--\<div\sclass\=\"speed\"\>--\>\[Скорость\sборды\:\s(\d+)\sп\.\/час\]\<\!--\<\/div\>--\>/)[1]
omit = (el) -> text(el).match /(\d+)/g

id = (el) -> _.first (attr('id')(el)).match(/(\d+)/g)
external = (el) -> ($ '<a />').attr(href: el.attr 'href')
internal = (el) -> ($ '<a />').text(el.text()).attr(href: "##{el.text()}", 'data-href': el.attr 'href')
filter = (el) -> el.attr('rel') and external(el) or internal(el)
replace = -> ($ @).replaceWith filter ($ @)
markup = (el) -> html _.tap el, (el) -> ($ 'a', el).each replace

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

postFromHTML = (->
  (data) -> parser data,
    uri: [id]
    subject: ['.filetitle', text]
    poster: ['.postername', text]
    createdAt: ['.posttime', text]
    html: ['.postMessage', markup]
    img: ['[name=expandfunc]', attr 'href']
    thumb: ['img.img', attr 'src']
)()

postToJSON = (boardId) ->
  (data) ->
    _.tap postFromHTML(data), (post) ->
      post.id = "#{boardId}-#{post.uri}"

threadFromHTML = (data, boardId, extraRuleForId) -> parser data,
    uri: extraRuleForId or [id]
    title: ['#title center', text]
    omit: ['.omittedposts', omit]
    post: ['.oppost', postToJSON boardId]
    posts: ['.post', map postToJSON boardId]

boardThreadToJSON = (boardId, extraRuleForId) ->
  (data) ->
    _.tap threadFromHTML(data, boardId, extraRuleForId), (thread) ->
      thread.id = "#{boardId}-#{thread.uri}"
      thread.boardId = boardId

@threadToJSON = (data, boardId) -> boardThreadToJSON(boardId, ['.thread', id]) data

@boardToJSON = (data, boardId) ->
  parser data,
    title: ['#title center', text]
    threads: ['.thread', map boardThreadToJSON boardId]
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
