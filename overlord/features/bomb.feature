Feature: creating a default bomb
  In order to have a bomb
  A user visits the web app

  Scenario: visiting the web app
    When I go to the home page
    Then I should see "Your bomb is ready"

  Scenario: the bomb can be activated
    When I go to the home page
    And fill in "code" with "1234"
    And press "submit"
    Then I should see "The Bomb is active"

  Scenario: the bomb can be deactivated
    Given the bomb is active
    When I go to the home page
    And fill in "code" with "0000"
    And press "submit"
    Then I should see "Activate it, already"

  Scenario: the bomb should retain its state
    Given the bomb is active
    When I go to the home page
    Then I should see "The Bomb is active"
