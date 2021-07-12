
Feature: Since the url is same move it to BackGround option

Background: Define URL
        Given url 'https://conduit.productionready.io/api/'

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        
    Scenario: The endpoint via path
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200