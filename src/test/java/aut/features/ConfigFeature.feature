@configTest
Feature: Get value from karate config

Background: Get URL from the karate config
    Given url apiURL

Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200

    