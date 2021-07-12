@afterHooks
Feature: Hooks

Background: Hooks
#to call after every feature
  #  * configure afterFeature = function(){karate.call('classpath:helpers/Dummy.feature')}

#to call after every scenario - call a js function
  * configure afterScenario = function(){karate.call('classpath:helpers/Dummy.feature')}
#write any logic inside js function , take care of space and = after afterFeature keyword, extra space it wont run
   * configure afterFeature = 
    """
        function(){
            karate.log('This is after Feature file');
        }
    """
Scenario: First Scenario
    * print 'This is 1st'
    

Scenario: Second Scenario
    * print 'This is 2nd'
   
