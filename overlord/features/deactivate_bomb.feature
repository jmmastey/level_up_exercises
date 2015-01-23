Feature: Deactivate the bomb
  As a bomb recipient
  I want to deactivate the bomb
  So that it does not explode

  Background:
  	The bomb has been booted and activated

  Scenario: Bomb deactivates with default deactivation code
  	Given The bomb has been booted and activated with the default codes
  	When I enter the correct deactivation code
  	Then the bomb should deactivate