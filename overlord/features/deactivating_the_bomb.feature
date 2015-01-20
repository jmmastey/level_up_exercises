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

  Scenario: three bad attempts to deactivate and the bomb explodes
    Given the bomb is active
    And I go to the home page

    When I fill in "code" with "1234"
    And press "submit"

    When I fill in "code" with "9999"
    And press "submit"

    And I fill in "code" with "9999"
    And press "submit"

    And I fill in "code" with "9999"
    And press "submit"

    Then I should see "Oops! The bomb has exploded!"
