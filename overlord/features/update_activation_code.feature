Feature: updating a bomb's activation code
  In order to have a secret activation code
  A user visits the web app

  Background:
    Given I go to the home page

  Scenario: updating with a valid activation code
    When I fill in "activation_code" with "4567"
    And press "update_activation_code"
    Then I should see "Activation code updated"

  Scenario: updated validation code should be sticky
    When I fill in "activation_code" with "4567"
    And press "update_activation_code"
    And I go to the home page
    And I fill in "code" with "1234"
    And press "submit"
    Then I should see "The bomb is active"
