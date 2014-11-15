
@testPosts = [
      {text:"Hi! Meteor!",author:"c3h3"},
      {text:"Meteor is great!"},
      {text:"Meteor is the best!"}
    ]

@Posts = new Meteor.Collection "posts"

if Meteor.isClient
  Template.posts.helpers
    posts: -> 
      Posts.find({}, {sort:{createAt:-1}})

  Template.posts.events
    "change input#insertPost": (e,t) ->
      e.stopPropagation()
      username = $("input#insertUsername").val()
      text = $("input#insertPost").val()
      data = 
        author: username
        text: text
        createAt: new Date

      $("#insertPost").val("")

      Posts.insert data


if Meteor.isServer
  if Posts.find().count() is 0
    Posts.insert post for post in testPosts
      
