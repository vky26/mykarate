Feature: Generate Random String

Scenario: Generate Ramdom String 
    * def dataGen = Java.type('helpers.DataGenerator')
    * def userName = dataGen.generateUserName()
    * print 'Print inside Dummy Feature ' , userName