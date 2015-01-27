Feature: Explode the bomb
  As a bomb recipient
  I want to explode the bomb
  To see if I survive the blast

  Scenario: Bomb explodes
  	Given The bomb has been booted and activated with the default codes
  	When I enter an incorrect deactivation code 3 time(s)
  	Then the bomb should explode
  