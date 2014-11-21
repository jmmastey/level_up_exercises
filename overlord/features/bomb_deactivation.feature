Feature: De-Activate bomb with default code
  As a villain
  I want to de-activate my bomb with default codes
  So that I can avoid blowing shit up

  Background:
    Given I am on the home page
      And I have activated the bomb

  @javascript
  Scenario: De-Activate the bomb
    When I type "deactivate 0000"
    And I enter the query
    Then The bomb should be deactivated
