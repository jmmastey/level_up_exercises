Feature: Activate bomb with default code
  I am Overlord
  I have public codes
  Awaken, my bomb

  I want to activate my bomb with default codes
  So that I may detonate the bomb

  Background:
    Given I am on the home page
      And I should see "inactive" within ".console .output"

  Scenario Outline: Activate the bomb
    And I fill in "query-input" with "activate <code>"
    And I press "Submit Query"
    Then I should see "<state>" within ".console .output"

  Examples:
    | code | state     |
    | 1234 | activated |
    | abcd | inactive  |

