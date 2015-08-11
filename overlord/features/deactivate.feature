Feature: Bomb Deactivation with default code
  As the overlord
  I want to make deactivating the bomb hard
  In order to take over the world

  Background:
    Given I am viewing "/"
    And I set the default codes
    And I enter the correct default activation code

  Scenario: Enter wrong code three times
    And I enter the "deactivate" code 1235
    And I click "DEACTIVATE"
    And I enter the "deactivate" code 1
    And I click "DEACTIVATE"
    And I enter the "deactivate" code 2345
    And I click "DEACTIVATE"
    Then bomb status is "exploded"

  Scenario: Enter right code
    And I enter the "deactivate" code 0000
    And I click "DEACTIVATE"
    Then bomb status is "deactivated"

  Scenario: Countdown ends and bomb is not deactivated
    And I wait for 20 seconds
    Then bomb status is "exploded"
    And I cannot enter "deactivate" code
