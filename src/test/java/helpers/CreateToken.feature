Feature: Create a common file for Auth Token and use it in another files

@createAuthToken
Scenario:Create a auth token
    Given url 'https://conduit.productionready.io/api/'
    Given path 'users/login'
    #And request { "user": {  "email": "vkykarate@karate.com",    "password": "karate123" }}
    
    #Getting value as parameter from a feature file - Refer Use Generic Auth Token feature file for usage
    #And request { "user": {  "email": "#(email)",    "password": "#(password)" }}

    #Getting the value from config file
    And request { "user": {  "email": "#(userEmail)",    "password": "#(userPassword)" }}
    
    When method Post
    Then status 200
    * def commonAuthToken = response.user.token