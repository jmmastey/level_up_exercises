Feature: Bomb

  Scenario: Create a bomb
  Given there are 0 bombs
  When I create a bomb
  And enter an activation code
  And enter a deactivation code
  Then there should be a bomb with an activation code
  And there should be deactivation code
  And the status should be inactive