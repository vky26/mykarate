@debugDelete
Feature: Articles Delete Request

Background: Set the auth token
    Given url 'https://conduit.productionready.io/api/'
    Given path 'users/login'
    And request { "user": {  "email": "vkykarate@karate.com",    "password": "karate123" }}
    When method Post
    Then status 200
    * def authToken = response.user.token
    

Scenario: Set the auth token and create and delete an article
    Given header authorization = 'Token ' + authToken
    Given path 'articles'
    And request { "article": {  "tagList": [],  "title": "Vky ArticleDelete", "description": "about post req2",  "body": "create article via post request2" }  }
    When method Post
    Then status 200
    And response.article.title == 'Vky ArticleDelete'

    * def articleID = response.article.slug

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == 'Vky ArticleDelete'

    Given header authorization = 'Token ' + authToken
    Given path 'articles', articleID
    When method Delete
    Then status 200
    
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != 'Vky ArticleDelete'
