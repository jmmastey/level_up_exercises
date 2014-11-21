Feature: Activate bomb with default code
  I am Overlord
  I have public codes
  Awaken, my bomb

  Background:
    Given I am on the home page
      And The bomb is deactivated

  @javascript
  Scenario: Activate the bomb
    When I type "activate 1234"
    And I enter the query
    Then The bomb should be activated
