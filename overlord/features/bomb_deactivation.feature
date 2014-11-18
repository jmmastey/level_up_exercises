Feature: De-Activate bomb with default code
  As a villain
  I want to de-activate my bomb with default codes
  So that I can avoid blowing shit up

  Background:
    Given I am on the home page
      And I should see "activated" within ".console .output"

  Scenario Outline: De-Activate the bomb
    And I fill in "query-input" with "deactivate <code>"
    And I press "Submit Query"
    Then I should see "<state>" within ".console .output"

  Examples:
    | code | state     |
    | 0000 | inactive  |
    | abcd | activated |

