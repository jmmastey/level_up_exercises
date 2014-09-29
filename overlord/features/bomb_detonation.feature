Feature: Bomb Detonation
  In order to test the Bomb class
  As a developer who wrote Bomb
  I want to ensure the bomb maintains correct status across detonation

  Background:
    Given I create a bomb with default codes

  Scenario: Check status for a bomb that was detonated
	When I detonate it
    Then I should see status: Integrity => "Blown to shreds", Activation => "NA", Attempts => 0

  Scenario: Check status for a bomb that was activated then detonated
    When I activate the bomb
	And  I detonate it
    Then I should see status: Integrity => "Blown to shreds", Activation => "NA", Attempts => 0

  Scenario: Check status for a bomb that was deactivated then detonated
    When I activate the bomb
    And  I deactivate the bomb
	And  I detonate it
    Then I should see status: Integrity => "Blown to shreds", Activation => "NA", Attempts => 0

  Scenario: Check status for a bomb that was deactivated with wrong code then detonated
    When I activate the bomb
	And  I unsuccessfully deactivate it 1 time
	And  I detonate it
    Then I should see status: Integrity => "Blown to shreds", Activation => "NA", Attempts => 1

  Scenario: Check status for a bomb that was snipped then detonated
	When I snip the wires
	And  I detonate it 
    Then I should see status: Integrity => "Wires are cut", Activation => "NA", Attempts => 0
