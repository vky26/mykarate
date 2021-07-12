@debugMulti
Feature: SingUp Feature Multiline

    Background: Load app url
        Given url apiURL
        #Given, when, and then or * all same only internally

    Scenario: Multi Line Input Example - User Sing Up
       # directly pass value in feature file
        Given def userData = {"email":"vtest4@test.com", "username": "vtest4"}
     
        Given path 'users'
        # triple double quoutes you can pass the json format request body in it
        And request
         """
          {
              "user": {
                  "email": "#(userData.email)",
                  "password": "karate123",
                  "username": "#(userData.username)"
              }
          }
        """
     
        When method Post
        Then status 200