Feature: updating a bomb's activation code
  In order to have a secret activation code
  A user can update the activation code

  Background:
    Given I go to the home page

  Scenario: updating with a valid activation code
    When I update the bomb's activation code
    Then I should see "Activation code updated"

  Scenario: updated activation code should be sticky
    When I update the bomb's activation code
    And I activate the bomb with the new activation code
    Then I should see "Disarm the Bomb with the Deactivation Code"

  Scenario: updating with an invalid activation code
    When I update the bomb's activation code with an invalid value
    Then I should see "Error: Activation code can only contain digits"
