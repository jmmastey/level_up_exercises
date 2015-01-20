Feature: creating a default bomb
  In order to have a bomb
  A user visits the web app

  Background:
    Given I go to the home page

  Scenario: the bomb can be deactivated
    Given the bomb is active
    When I fill in "code" with "0000"
    And press "submit"
    Then I should see "Arm the Bomb with the Activation Code"
