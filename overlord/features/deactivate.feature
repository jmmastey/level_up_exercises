
Feature: Deactivate an active bomb
  In order to not get blown up
  As the user
  I want to deactivate the active bomb

  Scenario: I deactivate the bomb
    Given The bomb is activated
    When I input the correct deactivation code 0000
    And the countdown is greater than 0
    Then I see the bomb deactivated message

  Scenario: I fail to deactivate the bomb
    Given The bomb is active
    When I input the wrong code
    Then I should see the countdown stopped
    And a wrong code message

  Scenario: I enter the wrong code 3 times
    Given The bomb is active
    And I have entered the wrong code 2 other times
    When I input the wrong code 
    Then the bomb blows up

  Scenario: I do nothing 
    Given The bomb is active
    When I wait 
    Then the bomb blows up

