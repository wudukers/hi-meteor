
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
      # username = $("input#insertUsername").val()
      text = $("input#insertPost").val()

      Meteor.call "insertPost", text, (err, data)->
        
        $("#insertPost").val("")
        
        if not err
          console.log "data = "
          console.log data

        else
          console.log "err = "
          console.log err

if Meteor.isServer
  Meteor.methods
    "insertPost": (text) -> 

      user = Meteor.user()

      if user
        username = user.profile.name
        userId = user._id

        data = 
          userId: userId
          author: username
          text: text
          createAt: new Date
      else
        data = 
          text: text
          createAt: new Date

      Posts.insert data



  if Posts.find().count() is 0
    Posts.insert post for post in testPosts
      
