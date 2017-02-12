Feature: Deactivate the bomb

  Background:
    When I boot the bomb "/boot"
    Then I enter activation code "1234"
    And I click "Activate"
    And I should see the bomb state : "Activated"
    And the bomb timer is counting down

  @javascript
  Scenario: deactivate the bomb with correct deactivate code
    Then I enter deactivation code "0000"
    When I click "Deactivate"
    Then the bomb timer should stop
    And I should see the bomb state : "Deactivated"
    

  @javascript
  Scenario: deactivate the bomb with incorrect deactivate code
    Then I enter deactivation code "1111"
    When I click "Deactivate"
    Then I should see "Deactivate" button
    And I should see alert message "Deactivation code does not match"

  @javascript
  Scenario: enter wrong deactivation code 3 times
    When I enter wrong deactivation code 3 times
    Then I should be on the detonate page 
