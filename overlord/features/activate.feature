
Feature: Activate the bomb
  In order potentially blow myself up
  As the user
  I want to activate a booted bomb

  Scenario: Activate bomb
    Given I am on the activate page
    #And the bomb is booted
    When I enter 1234 
    Then I see the bomb is active

  Scenario: Fail to activate bomb
    Given I am on the activate page
    When I submit the wrong activation code 1111
    Then I see a wrong code error message

