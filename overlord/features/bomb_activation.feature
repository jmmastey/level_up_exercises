Feature: Bomb Activation/Deactivation
  In order to test the Bomb class
  As a developer who wrote Bomb
  I want to ensure the bomb maintains correct across activation/deactivation attempts

  Background:
    Given I create a bomb with default codes

  Scenario: Check status for a newly created bomb
    Then I should see status: Integrity => "Intact", Activation => "Inactive", Attempts => 0

  Scenario: Check status for an activated bomb
    When I activate the bomb
    Then I should see status: Integrity => "Intact", Activation => "Active", Attempts => 0

  Scenario: Check status for an activated then deactivated bomb
    When I activate the bomb
	And  I deactivate the bomb
    Then I should see status: Integrity => "Intact", Activation => "Inactive", Attempts => 0

  Scenario: Check status for an activated bomb after wrong deactivation code
	And  I activate the bomb
	And  I unsuccessfully deactivate it 1 time
    Then I should see status: Integrity => "Intact", Activation => "Active", Attempts => 1

  Scenario: Check status for an activated bomb after two wrong deactivation codes
    When I activate the bomb
	And  I unsuccessfully deactivate it 2 times
    Then I should see status: Integrity => "Intact", Activation => "Active", Attempts => 2

  Scenario: Check status for an activated bomb after three wrong deactivation codes
    When I activate the bomb
	And  I unsuccessfully deactivate it 3 times
    Then I should see status: Integrity => "Blown to shreds", Activation => "NA", Attempts => 3
