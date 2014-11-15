

@Posts = new Meteor.Collection "posts"

Router.configure
  layoutTemplate: 'layout'


Meteor.startup ->
  Router.map -> 
    
    @route "index",
      path: "/"
      template: "index"
      


if Meteor.isClient
  Template.posts.helpers
    posts: -> 
      Posts.find({}, {sort:{createAt:-1}})

  Template.posts.events
    "change input#insertPost": (e,t) ->
      e.stopPropagation()
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

      if !user
        throw new Meteor.Error(401, "You need to login to insert post")

      username = user.profile.name
      userId = user._id

      data = 
        userId: userId
        author: username
        text: text
        createAt: new Date
    
      Posts.insert data

      
