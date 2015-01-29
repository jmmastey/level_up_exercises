Feature: Deactivate the bomb
  As a bomb recipient
  I want to deactivate the bomb
  So that it does not explode

  Background:
    Given the bomb has been booted and activated with the default codes

  Scenario: Bomb deactivates with default deactivation code
  	When I enter the default deactivation code
  	Then the bomb should deactivate

  Scenario: Bomb does not deactivate after one incorrect deactivation attempt
  	When I enter an incorrect deactivation code
    And I try to deactivate the bomb
  	Then the bomb should not deactivate
  	And there are 2 deactivation attempts remaining

  Scenario: Bomb does not deactivate after two incorrect deactivation attempts
  	When I try to deactivate the bomb with an incorrect code 2 times
  	Then the bomb should not deactivate
  	And there is 1 deactivation attempt remaining
