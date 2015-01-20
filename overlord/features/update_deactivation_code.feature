Feature: updating a bomb's deactivation code
  In order to have a secret deactivation code
  A user can update the deactivation code

  Background:
    Given I go to the home page

  Scenario: updating with a valid deactivation code
    When I fill in "deactivation_code" with "4567"
    And press "update_deactivation_code"
    Then I should see "Arm the Bomb with the Activation Code"

  Scenario: updated deactivation code should be sticky
    Given the bombs deactivation code is updated
    And I go to the home page
    And I fill in "code" with "0007"
    And press "submit"
    Then I should see "Arm the Bomb with the Activation Code"

  Scenario: updating with an invalid deactivation code
    When I fill in "deactivation_code" with "abcd"
    And press "update_deactivation_code"
    Then I should see "Error: Deactivation code can only contain digits"
