
Feature: Deactivate an active bomb
  In order to not get blown up
  As the user
  I want to deactivate the active bomb

  Scenario: I deactivate the bomb
    Given I am on the activated bomb page
    When I input the correct deactivation code 0000
    #And the countdown is greater than 0
    Then I see the bomb deactivated message

  Scenario: I fail to deactivate the bomb
    Given I am on the activated bomb page
    When I input the wrong code 1111
    Then I see a bomb active message

  Scenario: I do nothing 
    Given I am on the activated bomb page
    When I wait 31 seconds
    Then the bomb blows up

