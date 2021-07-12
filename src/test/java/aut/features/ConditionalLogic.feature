@conditionalLogic
Feature: Conditional Logic

Background: Conditional Logic
    Given url apiURL


Scenario: Conditional Logic
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200

    * def favCount = response.articles[0].favoritesCount

    #get the article id or slug name
    * def article = response.articles[0]

    #if 0 increase the count - via feature
    #accepts object as a parameter, if condition matches call the feature file, which accepts an object
    #method 1
    #* if(favCount == 1) karate.call('classpath:helpers/AddLikes.feature', article)

    #method 2  below
    #other way to do is, js method. if favCount ==0 then call the feature file which accepts article object , then the result will hold likesCount returned from that feature file, if not return favCount
    * def result = favCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favCount
    
    #check if the fav count has been increased
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
  # for the method 1 - uncomment below#
  #  And match response.articles[0].favoritesCount == 2
    And match response.articles[0].favoritesCount == result


