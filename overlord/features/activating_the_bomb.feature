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

  Scenario: the bomb should retain its state
    When I fill in "code" with "1234"
    And press "submit"
    And I go to the home page
    Then I should see "Disarm the Bomb with the Deactivation Code"

  Scenario: on receipt of an invalid deactivation code
    When I fill in "code" with "9999"
    And press "submit"
    Then I should see "Oops! That was an invalid activation code."
