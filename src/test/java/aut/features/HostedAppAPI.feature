
Feature: Testing services hosted on Angular App

    Scenario: Get all tags
        Given url 'https://conduit.productionready.io/api/tags'
        When method Get
        Then status 200


    Scenario: Get 10 articles by passing parameters in url 
        Given url 'https://conduit.productionready.io/api/articles?limit=10&offset=0'
        When method Get
        Then status 200

    
    Scenario: Get 10 articles by passing parameters in steps
        Given param limit = 10
        Given param offset = 0
        Given url 'https://conduit.productionready.io/api/articles'
        When method Get
        Then status 200

    
    Scenario: Get 10 articles by passing parameters in params object
        Given params {limit: 10, offset: 0}
        Given url 'https://conduit.productionready.io/api/articles'
        When method Get
        Then status 200

        
    Scenario: The endpoint via path
        Given params {limit: 10, offset: 0}
        Given url 'https://conduit.productionready.io/api/'
        Given path 'articles'
        When method Get
        Then status 200