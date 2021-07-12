@retryLogic
Feature: Retry Logic

Background: Retry Logic
    Given url apiURL


Scenario: Retry Logic
    #define the logic for retry - retry count of 10 and on 5 seconds interval before each call 
    * configure retry = { count: 10, interval: 5000}

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    #always use the retry before the action class
    And retry until response.articles[0].favoritesCount == 2
    When method Get
    Then status 200


@sleepLogic
Scenario: Sleep Logic
    #define the logic for retry - retry count of 10 and on 5 seconds interval before each call 
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

    Given params {limit: 10, offset: 0}
    Given path 'articles'
   
    And eval sleep(5000)

    When method Get
    Then status 200