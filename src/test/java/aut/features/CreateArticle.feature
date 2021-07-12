@debugJAVA
Feature: Articles

Background: Base URL
    Given url 'https://conduit.productionready.io/api/'
    Given path 'users/login'
    And request { "user": {  "email": "vkykarate@karate.com",    "password": "karate123" }}
    When method Post
    Then status 200
    * def authToken = response.user.token
    

Scenario: Set the auth token and create an article
    Given header authorization = 'Token ' + authToken
    Given path 'articles'
    And request { "article": {  "tagList": [],  "title": "Vky Article2", "description": "about post req2",  "body": "create article via post request2" }  }
    When method Post
    Then status 200
    And response.article.title == 'Vky Article2'