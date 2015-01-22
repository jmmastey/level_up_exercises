Feature: deactivating a bomb
  In order to have a bomb
  A user visits the web app

  Background:
    Given I go to the home page
    And I activate the bomb

  Scenario: the bomb can be deactivated
    When I deactivate the bomb
    Then I should see "Arm the Bomb with the Activation Code"

  Scenario: on receipt of an invalid deactivation code
    When I supply an invalid deactivation code
    Then I should see "Oops! That was an invalid deactivation code."
    And I should see "Disarm the Bomb with the Deactivation Code"

  Scenario: three bad attempts to deactivate and the bomb explodes
    When I supply an invalid deactivation code three times
    Then I should see "Oops! The bomb has exploded!"
