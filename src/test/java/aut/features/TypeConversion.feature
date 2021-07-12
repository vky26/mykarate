
Feature: Type Conversion

Background: Type Conversion
    Given url apiURL

Scenario: Number to String
    #will fail
    * def val = 10
    * def val2 = 10+''
    * def val1 = '10'
    * match val2 == val1

@typeConversion
Scenario: String to Number
    * def val = 10
    * def val1 = '10'
    * def val2 = ('10')*1
  #  * match val1 == val
    * match val2 == val