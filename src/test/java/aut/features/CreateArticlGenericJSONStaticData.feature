@debugCreateArticleGeneric
Feature: Articles

Background: Base URL
    Given url apiURL
    * def articleBodyFromJSON = read('classpath:aut/json/newArticle.json')

Scenario: Set the auth token and create an article
    Given path 'articles'
    And request articleBodyFromJSON
    When method Post
    Then status 200
    And response.article.title == 'Vky Article3'