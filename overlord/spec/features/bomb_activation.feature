Feature: Bomb Activation is possible with correct activation code
  and only once

  Scenario: Check that incorrect code does not activate bomb
    Given a new bomb presented to super villian
    When incorrect activation code is entered
    Then bomb state is inactive 

  Scenario: Check that non-numeric code does not activate bomb
    Given a new bomb presented to super villian
    When non-numeric activation code is entered
    Then error "Please enter 4-digit number" is displayed to user
    And bomb state is inactive

  Scenario: Check that correct code activates bomb upon first attempt
    Given a new bomb presented to super villian
    When correct activation code is entered
    Then bomb state is active

  Scenario: Ensure entering code for activated bomb does nothing
    Given a new bomb presented to super villian
    And correct activation code is entered
    When correct activation code is entered
    Then bomb state is active
