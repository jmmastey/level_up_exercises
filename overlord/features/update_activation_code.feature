Feature: updating a bomb's activation code
  In order to have a secret activation code
  A user can update the activation code

  Background:
    Given I go to the home page

  Scenario: updating with a valid activation code
    When I fill in "deactivation_code" with "4567"
    And press "update_deactivation_code"
    Then I should see "Deactivation code updated"

  Scenario: updated activation code should be sticky
    When I fill in "activation_code" with "4567"
    And press "update_activation_code"
    And I go to the home page
    And I fill in "code" with "1234"
    And press "submit"
    Then I should see "Disarm the Bomb with the Deactivation Code"

  Scenario: updating with an invalid activation code
    When I fill in "activation_code" with "abcd"
    And press "update_activation_code"
    Then I should see "Error: Activation code can only contain digits"
