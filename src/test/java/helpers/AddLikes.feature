Feature: Add Likes

Background: Add LIkes
    Given url apiURL

Scenario: Add Likes
    #picks the value slug from the calling object
    Given path 'articles', slug ,'favorite'
    And request {}
    When method Post
    Then status 200
    * def likesCount = response.article.favoritesCount