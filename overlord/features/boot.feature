Feature: Boot Bomb
  In order to achive world domination
  As a vilian
  I want to be able to create a bomb

  Scenario: First visit the bomb page
    Given the bomb is not yet booted
    When I go to the home page
    Then I should see "Welcome to Your Bomb Let's boot the bomb!"

  Scenario: Boot bomb with default codes
    Given the bomb is not yet booted
    When I go to the home page
    And I press "Boot"
    Then I should see "The Bomb is Booted Up"

  Scenario: Boot bomb with valid codes
    Given the bomb is not yet booted
    When I go to the home page
    And I fill in "Activation Code" with "4321"
    And I fill in "Deactivation Code" with "9999"
    And I press "Boot"
    Then I should see "The Bomb is Booted Up"

  Scenario: Boot bomb with invalid codes
    Given the bomb is not yet booted
    When I go to the home page
    And I fill in "Activation Code" with "22"
    And I fill in "Deactivation Code" with "11"
    And I press "Boot"
    Then I should see "Invalid codes entered"

  Scenario: Visit home page after bomb is booted
    Given the bomb is booted with codes "1234" and "0000"
    When I go to the home page
    Then I should see "The Bomb is Booted Up"
