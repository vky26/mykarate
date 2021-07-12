@genericToken 
Feature: Use the commonly generated token

Background: Get the token from that helpers file
    Given url 'https://conduit.productionready.io/api/'
    #Call will call everytime, callonce, will call and store the value in cache and use it whenever required
  #  * def genericTokenFile = call read('classpath:helpers/CreateToken.feature')
   #  * def genericTokenFile = callonce read('classpath:helpers/CreateToken.feature')
   #passing values as parameter
   * def genericTokenFile = callonce read('classpath:helpers/CreateToken.feature'){"email": "vkykarate@karate.com","password": "karate123" }
   * def genericToken = genericTokenFile.commonAuthToken

    
    Scenario: Create an article with Generic Token 
        Given header authorization = 'Token ' + genericToken
        Given path 'articles'
        And request { "article": {  "tagList": [],  "title": "Vky Article21", "description": "about post req2",  "body": "create article via post request2" }  }
        When method Post
        Then status 200
        And response.article.title == 'Vky Article21'
    
    Scenario: Create an article with Generic Token 
        Given header authorization = 'Token ' + genericToken
        Given path 'articles'
        And request { "article": {  "tagList": [],  "title": "Vky Article22", "description": "about post req2",  "body": "create article via post request2" }  }
        When method Post
        Then status 200
        And response.article.title == 'Vky Article22'