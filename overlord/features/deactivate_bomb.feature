Feature: Deactivate the bomb
  As a bomb recipient
  I want to deactivate the bomb
  So that it does not explode

  Background: The bomb has been booted and activated with the default codes

  Scenario: Bomb deactivates with default deactivation code
  	When I enter the default deactivation code
  	Then the bomb should deactivate

  Scenario: Bomb does not deactivate after one incorrect deactivation attempt
  	When I enter an incorrect activation code 1 time(s)
  	Then the bomb should not deactivate
  	And the number of deactivation attempts remaining should be 2

  Scenario: Bomb does not deactivate after two incorrect deactivation attempts
  	When I enter an incorrect activation code 2 time(s)
  	Then the bomb should not deactivate
  	And the number of deactivation attempts remaining should be 1

  Scenario: Bomb does not deactivate when I navigate elsewhere
    When I visit another page
    Then the bomb should still be active
    And there should be 3 deactivation attempts left