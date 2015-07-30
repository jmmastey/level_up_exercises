Feature: Disarming Bomb
  In case I change my mind and do not want to make the bomb explode
  As a crime overlord
  I need to be able to disarm the bomb after its activated

  Background:
    Given I am on the bomb page
    And the bomb is armed

  Scenario: Disarming the bomb 
    When I submit a valid code input
    Then the bomb should be disarmed

  Scenario: Entering in the wrong code three times cuases bomb to explode
    And I submit an invalid code input
    And I submit an invalid code input
    And I submit an invalid code input
    Then the bomb state should be exploded