Feature: Explode the bomb
  As a bomb recipient
  I want to explode the bomb
  To see if I survive the blast

  Background:
  	The bomb has been booted and activated with the default codes

  Scenario: Bomb explodes
  	Given The bomb has been booted and activated with the default codes
  	When I enter an incorrect deactivation code three times
  	Then the bomb should explode
  