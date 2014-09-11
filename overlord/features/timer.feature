Feature: The bomb has a timer
  In order to control the amount of time to disarm the bomb
  As a user
  I should be able to specify a value for the same

  @disarm
  Scenario: I enter a valid number for the timer value
    Given I am on the arming page
    When I fill in "activation_code" with "1234"
    And I fill in "timer" with "15"
    And I click "submit"
    Then I should see "Bomb armed. You have 15 seconds left!"

  @disarm
  Scenario: Timer default to 30secs if left empty
    Given I am on the arming page
    When I fill in "activation_code" with "1234"
    And I click "submit"
    Then I should see "Bomb armed. You have 30 seconds left!"

  @javascript
  Scenario: I can only input numbers for the timer value
    Given I am on the arming page
    When I fill in "timer" with "abc"
    Then I should see "* Input digits (0 - 9)"

  @javascript
  Scenario: The bomb explodes if not disarmed within the timer value
    Given I am on the arming page
    When I fill in "activation_code" with "1234"
    And I fill in "timer" with "15"
    And I click "submit"
    And I move forward "15" seconds in time
    Then I should see "Boom, be*ch!"
