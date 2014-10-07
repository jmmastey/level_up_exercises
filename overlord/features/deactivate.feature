Feature: Bomb Deactivation
  In order to stop my evil plot
  As a villain
  I want to be able to deactivate the bomb

  Background:
    Given the bomb is booted with codes "1234" and "0000"
    And the bomb is activated with code "1234"
    And I am on the home page

  Scenario: Home poge
    When I go to the home page
    Then I should see "The Bomb is Active"
    And I should see field "code"

  Scenario: Valid deactivation code entered
    When I fill in "Code" with "0000"
    And I press "Enter"
    Then I should see "Welcome to Your Bomb"

  Scenario: Valid deactivation code entered after time expired
    When I wait 31 seconds
    And I fill in "Code" with "0000"
    And I press "Enter"
    Then I should see "The Bomb Exploded"

  Scenario: Invalid deactivation code entered
    When I fill in "Code" with "1111"
    And I press "Enter"
    Then I should see "The Bomb is Active"

  Scenario: Invalid deactivation code entered 3 times
    When I enter code "1111" "3" times
    Then I should see "The Bomb Exploded"

  Scenario: Invalid deactivation followed by valid
    When I enter code "1111" "2" times
    And I fill in "Code" with "0000"
    And I press "Enter"
    Then I should see "Welcome to Your Bomb"
