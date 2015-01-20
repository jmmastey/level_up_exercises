Feature: creating a default bomb
  In order to have a bomb
  A user visits the web app

  Background:
    Given I go to the home page

  Scenario: the bomb can be deactivated
    Given I activate the bomb
    When I deactivate the bomb
    Then I should see "Arm the Bomb with the Activation Code"

  Scenario: on receipt of an invalid deactivation code
    Given I activate the bomb
    When I supply an invalid deactivation code
    Then I should see "Oops! That was an invalid deactivation code."

  Scenario: three bad attempts to deactivate and the bomb explodes
    Given I activate the bomb
    And I supply an invalid deactivation code three times
    Then I should see "Oops! The bomb has exploded!"
