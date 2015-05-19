Feature: deactivate the bomb

  In order to deactivate the bomb
  As the Player
  I should enter the deactivation code.

  Scenario: successfully deactivate the bomb in 1 attempt
    Given I successfully boot and activate the bomb
    When I submit the valid deactivation code
    Then I see the bomb has successfully deactivated

  Scenario: unsuccessfully deactivate the bomb
    Given I successfully boot and activate the bomb
    When I submit an invalid deactivation code
    Then I see the bomb has not deactivated

  Scenario: unsuccessfully deactivate the bomb after 3 attempts
    Given I successfully boot and activate the bomb
    When I submit 3 invalid activation codes
    Then I see the bomb exploded
