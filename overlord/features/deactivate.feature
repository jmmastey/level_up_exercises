Feature: deactivate the bomb

  Background:
    Given I booted the bomb
    And I activated the bomb

  Scenario: deactivate the bomb with correct deactivation code
    When I try to deactivate the bomb using the code "0000"
    Then the bomb timer should be stopped 
    And I should see the bomb is "deactivated"

  Scenario: deactivate the bomb with incorrect deactivation code
    When I try to deactivate the bomb using the code "1111"
    Then the "Deactivate" button should remains on the page
    And I should see alert message "Deactivation code does not match"

  Scenario: enter wrong deactivation code 3 times
    When I enter wrong deactivation code 3 times
    Then I should be on the detonate page 
