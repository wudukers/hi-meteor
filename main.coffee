

@Posts = new Meteor.Collection "posts"

Router.configure
  layoutTemplate: 'layout'


Meteor.startup ->
  Router.map -> 
    
    @route "index",
      path: "/"
      template: "index"
      data:
        postCount: ->
          Posts.find().count()
        
        posts: ->
          Posts.find {}, {sort:{createAt:-1}}

      waitOn: ->
        user = Meteor.user()
        if not user
          Router.go "pleaseLogin"

        Meteor.subscribe "allPosts"

    @route "show",
      path: "show/:words"
      template: "show"
      data:
        words: ->
          Session.get "words"
          
      waitOn: ->
        Session.set "words", @params.words


    @route "user",
      path: "meteorUserPage/:_id"
      template: "user"
      data:
        postCount: ->
          Posts.find().count()

        posts: ->
          pageUserId = Session.get "pageUserId"
          console.log "pageUserId = "
          console.log pageUserId
          Posts.find {userId:pageUserId}, {sort:{createAt:-1}}

      waitOn: ->
        Session.set "pageUserId", @params._id
        Meteor.subscribe "userPosts", @params._id



    @route "pleaseLogin",
      path: "pleaseLogin/"
      template: "pleaseLogin"
      waitOn: ->
        user = Meteor.user()
        if user
          Router.go "index"


# if Meteor.isClient
#   Template.posts.helpers
#     posts: -> 
#       Posts.find({}, {sort:{createAt:-1}})

#   Template.posts.events
#     "change input#insertPost": (e,t) ->
#       e.stopPropagation()
#       text = $("input#insertPost").val()

#       Meteor.call "insertPost", text, (err, data)->
        
#         $("#insertPost").val("")
        
#         if not err
#           console.log "data = "
#           console.log data

#         else
#           console.log "err = "
#           console.log err

if Meteor.isClient
  Template.index.events
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

  Template.user.events
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

  Meteor.publish "allPosts", -> 
    Posts.find()

  Meteor.publish "userPosts", (userId) -> 
    Posts.find userId:userId


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

      
