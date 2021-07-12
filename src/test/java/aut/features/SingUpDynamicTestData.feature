@debugDynamicTestData
Feature: SingUp Feature Dynamic Test Data

    Background: Load app url
        #call the java file to generate random strings
        * def dataLoader = Java.type('helpers.DataGenerator')
        #call js file to validate the timestamp
        Given url apiURL
        #Given, when, and then or * all same only internally

    Scenario: Multi Line Input Example - User Sing Up
        #pass random value from Java file
        * def randomEmail = dataLoader.generateEmail()
        * def randomUserName = dataLoader.generateUserName()
        * def timeValidator = read('classpath:helpers/TimeValidator.js') 
        * print 'created randomEmail is: ', (randomEmail)
        * print 'created randomUserName is: ', (randomUserName)

        Given path 'users'
        # triple double quoutes you can pass the json format request body in it
        And request
         """
          {
              "user": {
                  "email": #(randomEmail),
                  "password": "karate123",
                  "username": #(randomUserName)
              }
          }
        """
     
        When method Post
        Then status 200
        And match response ==
        """
            {
                "user": {
                    "id": "#number",
                    "email": #(randomEmail),
                    "createdAt": "#? timeValidator(_)",
                    "updatedAt": "#? timeValidator(_)",
                    "username": #(randomUserName),
                    "bio": null,
                    "image": null,
                    "token": "#string"
                }
            }
        """