Feature: Bomb Snipping
  In order to test the Bomb class
  As a developer who wrote Bomb
  I want to ensure the bomb maintains correct status when snipped

  Background:
    Given I create a bomb with default codes

  Scenario: Check status for a bomb that was snipped
	When I snip the wires
    Then I should see status: Integrity => "Wires are cut", Activation => "NA", Attempts => 0

  Scenario: Check status for a bomb that was activated then snipped
    When I activate the bomb
	And  I snip the wires 
    Then I should see status: Integrity => "Wires are cut", Activation => "NA", Attempts => 0

  Scenario: Check status for a bomb that was deactivated then snipped
    When I activate the bomb
    And  I deactivate the bomb
	And  I snip the wires 
    Then I should see status: Integrity => "Wires are cut", Activation => "NA", Attempts => 0

  Scenario: Check status for a bomb that was snipped then activation attempt
	When I snip the wires
	And  I activate the bomb
    Then I should see status: Integrity => "Wires are cut", Activation => "NA", Attempts => 0

  Scenario: Check status for a bomb that was snipped then deactivation attempt
	When I snip the wires
	And  I deactivate the bomb
    Then I should see status: Integrity => "Wires are cut", Activation => "NA", Attempts => 0

  Scenario: Check status for a bomb that was snipped then detonated
	When I snip the wires
	And  I detonate it
    Then I should see status: Integrity => "Wires are cut", Activation => "NA", Attempts => 0
