
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
      abc: "123"
      def: "234"    
    
    
