Feature: creating a default bomb
  In order to have a bomb
  A user visits the web app

  Background:
    Given I go to the home page

  Scenario: visiting the web app
    When I go to the home page
    Then I should see "Your bomb is ready"

  Scenario: the bomb can be activated
    When I fill in "code" with "1234"
    And press "submit"
    Then I should see "Disarm the Bomb with the Deactivation Code"

  Scenario: the bomb can be deactivated
    Given the bomb is active
    When I fill in "code" with "0000"
    And press "submit"
    Then I should see "Arm the Bomb with the Activation Code"

  Scenario: the bomb should retain its state
    When I fill in "code" with "1234"
    And press "submit"
    And I go to the home page
    Then I should see "Disarm the Bomb with the Deactivation Code"
