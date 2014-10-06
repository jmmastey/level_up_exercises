Feature: Bomb Activation
  In order to make someones day terrible
  As a vilian
  I want to be able to activate the bomb

  Background:
    Given the bomb is booted with codes "1234" and "0000"

  Scenario: Valid activation code entered
    When I go to the home page
    And I fill in "Code" with "1234"
    And I press "Enter"
    Then I should see "The Bomb is Active"

  Scenario: Invalid activation code entered
    When I go to the home page
    And I fill in "Code" with "2222"
    And I press "Enter"
    Then I should see "The Bomb is Booted"
