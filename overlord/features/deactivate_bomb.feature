Feature: Deactivate Bomb
  As a Super Hero or Villain
  I want deactivate a bomb
  so that it can not detonate

  Scenario: Click on deactivate button
    Given a bomb is activated
    When I input a deactivation code "0000"
    And click on deactivate button
    Then deactivate the bomb
    And show a notification "Bomb deactivated"

  Scenario: Wrong input of deactivate code
    Given a bomb is activated
    When I input a deactivation code "1234"
    And click on deactivate button
    Then do not deactivate the bomb
    And show a notification "Wrong Code"

  Scenario: 3rd wrong input of deactivate code
    Given a bomb is activated
    And number of previous attempts is equal to 2
    When I input a deactivation code "1234"
    And click on deactivate button
    Then detonate the bomb
    And show a notification "Wrong Code, Bomb detonated"
