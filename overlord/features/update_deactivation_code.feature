Feature: updating a bomb's deactivation code
  In order to have a secret deactivation code
  A user can update the deactivation code

  Background:
    Given I go to the home page

  Scenario: updating with a valid deactivation code
    When I update the bomb's deactivation code
    Then I should see "Deactivation code updated"

  Scenario: updated deactivation code should be sticky
    Given I activate the bomb
    And I update the bomb's deactivation code
    And I deactivate the bomb with the new deactivation code
    Then I should see "Arm the Bomb with the Activation Code"

  Scenario: updating with an invalid deactivation code
    When I update the bomb's deactivation code with an invalid value
    Then I should see "Error: Deactivation code can only contain digits"
