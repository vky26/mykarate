@perfCreateArticleGenericDynamic
Feature: Article Creation Performance
    #replace the values from json with random strings
    #load the java file and set the values  or override default json values

Background: Base URL
    * url apiURL
    * def articleBodyFromJSON = read('classpath:aut/json/newArticle.json')
    * print 'Before Setting new value ', articleBodyFromJSON
    * def dataLoader = Java.type('helpers.DataGenerator')
    * def dataLoaderObject = dataLoader.getArticleJSONBody()
    * set articleBodyFromJSON.article.title = dataLoaderObject.title
    * set articleBodyFromJSON.article.body = dataLoaderObject.body
    * set articleBodyFromJSON.article.description = dataLoaderObject.description
    * print 'After Setting new value ', articleBodyFromJSON
  
Scenario: Set the auth token and create an article
    Given path 'articles'
    * print 'json value is ' , (articleBodyFromJSON)
    #passing the payload or request body, with keyword request
    And request articleBodyFromJSON
    When method Post
    Then status 200
    And response.article.title == articleBodyFromJSON.article.title