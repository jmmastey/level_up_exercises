Feature: Bomb Creation

  Background:
    Given A bomb has already been activated

  Scenario: Configuring the bomb settings with all required fields
    Given I am on the bomb creation page
    Then I should see a field for disarming code
      And I should see a field for timer
      And I should see a field for max attempts
    When I fill in the disarming code
      And I fill in the timer
      And I fill in the max attempts
      And I click submit
    Then I should be redirected to the bomb disarming page

