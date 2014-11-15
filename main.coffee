
@testPosts = [
      {text:"Hi! Meteor!",author:"c3h3"},
      {text:"Meteor is great!"},
      {text:"Meteor is the best!"}
    ]

@Posts = new Meteor.Collection "posts"

if Meteor.isClient
  Template.posts.helpers
    posts: -> 
      Posts.find()


if Meteor.isServer
  if Posts.find().count() is 0
    Posts.insert post for post in testPosts
      
