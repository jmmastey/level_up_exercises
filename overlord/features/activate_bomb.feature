Feature: Activate Bomb
  As a Super Villain
  I want to activate the bomb
  so that it can be detonated

  Scenario: Click on activate button
    Given a bomb is created/booted
    When I input an activation code "4242"
    And click on activate button
    Then activate the bomb
    And show a notification "Bomb Activated"

  Scenario: Wrong input of activation code
    Given a bomb is created/booted
    When I input an activation code "0000"
    And click on activate button
    Then do not activate bomb
    And show a notification "Wrong Code"
