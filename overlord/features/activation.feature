Feature: Bomb Activation
  In order to make someones day terrible
  As a vilian
  I want to be able to activate the bomb

  Background:
    Given the bomb is booted with codes "1234" and "0000"
    And I am on the home page

  # Happy Path Tests
  Scenario: Go to hame page
    When I go to the home page
    Then I should see "The Bomb is Booted"
    And I should see field "code"
    And the "time" field should contain "30"

  Scenario: Valid activation code entered
    When I fill in "Code" with "1234"
    And I press "Enter"
    Then I should see "The Bomb is Active"
    And I should see field "code"

  # Sad Path Tests
  Scenario: Invalid activation code entered
    When I fill in "Code" with "2222"
    And I press "Enter"
    Then I should see "The Bomb is Booted"
    And I should see field "code"

  # Happy and Sad Path Tests
  Scenario Outline: Bomb explodes after time expires
    When I fill in "Code" with "1234"
    And I fill in "Time" with "<time>"
    And I press "Enter"
    And I wait <delay> seconds
    And I go to the home page
    Then I should see "<message>"

    Examples:
      | time | delay | message        |
      | 30   | 31    | Bomb Exploded  |
      | 45   | 31    | Bomb is Active |
      | 30   | 29    | Bomb is Active |
