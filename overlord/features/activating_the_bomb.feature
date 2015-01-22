Feature: creating a default bomb
  In order to have a bomb
  A user visits the web app

  Background:
    Given I go to the home page

  Scenario: visiting the web app
    Then I should see "Your bomb is ready"

  Scenario: the bomb can be activated
    When I activate the bomb
    Then I should see "Disarm the Bomb with the Deactivation Code"

  Scenario: the bomb should retain its state
    When I activate the bomb
    And I go to the home page
    Then I should see "Disarm the Bomb with the Deactivation Code"

  Scenario: on receipt of an invalid activation code
    When I supply an invalid activation code
    Then I should see "Oops! That was an invalid activation code."
    And I should see "Arm the Bomb with the Activation Code"
