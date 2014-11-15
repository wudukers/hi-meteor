
@testPosts = [
      {text:"Hi! Meteor!",author:"c3h3"},
      {text:"Meteor is great!"},
      {text:"Meteor is the best!"}
    ]

@Posts = new Meteor.Collection "posts"

if Meteor.isClient
  # Template.posts.testVar1 = "testVar1"
  # Template.posts.testVar2 = "testVar2"

  Template.posts.helpers
    testVar1: "testVar1"
    testVar2: "testVar2"
    testVar3: true
    testVar4: false
    testVar5: 123.321
    testVar6: new Date

    testObjVar: 
      abc: 123
      def: 234    
    
    testFnVar: (a,b) -> a+b

    testArrayVar: testPosts


if Meteor.isServer
  if Posts.find().count() is 0
    Posts.insert post for post in testPosts
      
