Feature: Bomb Creation

  Background:
    Given A bomb has already been activated

  Scenario: Configuring the bomb settings with all required fields
    Given I am on the bomb creation page
    Then I should see the field "disarming_code" within "row"
      And I should see the field "timer" within "row"
      And I should see the field "max_attempts" within "row"
    When I fill in the following:
      | disarming_code | 1234 |
      | timer          | 30 |
      | max_attempts   | 5 |
      And I click the submit button
    Then I should be on bomb disarming page

  Scenario: Configuring the bomb settings with missing required fields
    Given I am on the bomb creation page
    Then I should see the field "disarming_code" within "row"
      And I should see the field "timer" within "row"
      And I should see the field "max_attempts" within "row"
