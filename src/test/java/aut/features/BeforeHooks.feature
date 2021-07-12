@beforeHooks
Feature: Hooks

Background: Hooks
   #call - BeforeEach, callonce - Before
   #Before all Scenario - we can configure in Karate-config.js, we are using it currently 
    * def result =  callonce read('classpath:helpers/Dummy.feature')
    * def userNameStr = result.userName

Scenario: First Scenario
    * print userNameStr
    * print 'This is 1st'
    

Scenario: Second Scenario
    * print userNameStr
    * print 'This is 2nd'
   
