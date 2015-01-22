Feature: Activate the bomb
  As a super-villian
  I want to activate the bomb
  So that someone can try to deactivate the bomb

  Background:
  	The bomb has been booted with activation and deactivation codes set

  Scenario: Bomb activates with correct activation code
  	Given The bomb has been booted with the default codes
  	When I enter the correct activation code
  	Then the bomb should be activated

