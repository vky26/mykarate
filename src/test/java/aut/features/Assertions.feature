

Feature: Assertions

Background: Assertions Check
        Given url apiURL

    Scenario: Check if the value is present in the response array
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains 'HITLER'
        
    
    Scenario: Check if the more than one value is present in the response array
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['HITLER', 'Gandhi']
        And match response.tags contains any ['HITLER', 'Obama'] 
        #any atleast one value should be present to be pass
        And match response.tags !contains  ['Bill', 'Obama'] 
        #to check if the response object has only one value 
        #And match response.tags contains only ['HITLER']
    Scenario: Doesnt Contain a value
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags !contains 'cars'

    
    Scenario: Check if the response is an array
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags == "#array"

        
    Scenario: Loop through the respone and check if its a string or null
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags == "#array"
        And match each response.tags == "#string" 

    @assertions
    Scenario: Check if the size of the array is 10
        #to do the time validations call the js file
        * def timeValidator = read('classpath:helpers/TimeValidator.js')        

        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        #checks if the article array is of length 10 
        And match response.articles == '#[10]'
        
        And match response.articlesCount == 500
        And match response.articlesCount != 100
        #Check if the response is an array and cehck some value 
        And match response == {"articles": "#array" , "articlesCount":500}
        #check the part of the string value
        And match response.articles[0].createdAt contains '2021'
         #check in the repsonse array, if any parameter has value 1
        And match response.articles[*].favoritesCount contains 0
         #check in the repsonse array, if any parameter has value null
        And match response.articles[*].author.bio contains null
        #checks all nodes
        And match response..bio contains null
        And match each response..following == false
        #check type
        And match each response..following == "#boolean"
        And match each response.articles[*].favoritesCount == "#number"
        #check if value is string or null
        And match each response.articles[*].author.bio == "##string"
        #check the schema for all the array from articles
        And match each response.articles == 
        """
            {
            "title": "#string",
            "slug": "#string",
            "body": "#string",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "tagList": '#array',
            "description": "#string",
            "author": {
                "username": "#string",
                "bio": '##string',
                "image": "#string",
                "following": '#boolean'
            },
            "favorited": '#boolean',
            "favoritesCount": '#number'
        }
        """

        #to do timezone validation - grab the js file and create a file helpers/TimeValidator.js - https://github.com/intuit/karate/blob/master/karate-junit4/src/test/java/com/intuit/karate/junit4/demos/time-validator.js