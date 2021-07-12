@debugScenarioOutline
Feature: SingUp Feature Test Data from outline

    Background: Load app url
        #call the java file to generate random strings
        * def dataLoader = Java.type('helpers.DataGenerator')
        #call js file to validate the timestamp
        Given url apiURL
        #Given, when, and then or * all same only internally

    Scenario Outline: Scenario Outline - Examples - Sign Up
        #pass random value from Java file
        * def randomEmail = dataLoader.generateEmail()
        * def randomUserName = dataLoader.generateUserName()

        Given path 'users'
        # triple double quoutes you can pass the json format request body in it
        And request
         """
          {
              "user": {
                  "email": "<emailData>",
                  "password": "<passWordData>",
                  "username": "<userNameData>"
              }
          }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

    Examples:
    | emailData      | userNameData | passWordData | errorResponse                                      |
    | #(randomEmail) | vtest1       | karate123    | {"errors":{"username":["has already been taken"]}} |
    | vtest1@test.com | vtest132221       | karate123    | {"errors":{"email":["has already been taken"]}} |

    #can extend for all possible inputs and combinations, eg. short username, email cant be blank, invaid and so on
    