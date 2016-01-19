Feature: Bomb Deactivation is possible with correct deactivation code
  and only certain number of times. Otherwise Bomb explodes!

  Scenario: Check that incorrect code does not deactivate bomb
    Given a active bomb presented to super villian
    When incorrect deactivation code is entered
    Then bomb state is active
 
  Scenario: Check that non-numeric code does not activate bomb
    Given a active bomb presented to super villian
    When non-numeric deactivation code is entered
    Then error "Please enter 4-digit number" is displayed to user
    And bomb state is active

  Scenario: Check that correct code deactivates bomb
    Given a active bomb presented to super villian
    When correct deactivation code is entered
    Then bomb state is inactive

  Scenario: Check that 2nd incorrect attempt does not deactivate bomb
    and does not explode it
    Given a active bomb presented to super villian with 1 unsuccessful deactivation attempts
    When incorrect deactivation code is entered
    Then bomb state is active

  Scenario: Check that 3rd incorrect attempt explodes bomb
    Given a active bomb presented to super villian with 2 unsuccessful deactivation attempts
    When incorrect deactivation code is entered
    Then bomb state is exploded
    And nothing is visible
