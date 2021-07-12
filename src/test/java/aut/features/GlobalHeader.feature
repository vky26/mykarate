@genericHeaderAndToken 
Feature: Use the commonly generated token

Background: Get the token from that helpers file
    Given url apiURL
    
    Scenario: Create an article with Generic Token asd
        Given path 'articles'
        And request { "article": {  "tagList": [],  "title": "Vky Article21", "description": "about post req2",  "body": "create article via post request2" }  }
        When method Post
        Then status 200
        And response.article.title == 'Vky Article21'