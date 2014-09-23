Feature: Bomb Status
  In order to test the Bomb class
  As a developer who wrote Bomb
  I want to ensure the bomb maintains correct status across all actions

  Scenario: Check status for a newly created bomb
  	Given I create a bomb with no codes
    Then I should see status "Intact" + "Inactive" + 0 deactivation attempts

  Scenario: Check status for an activated bomb
  	Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
    Then I should see status "Intact" + "Active" + 0 deactivation attempts

  Scenario: Check status for an activated then deactivated bomb
  	Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
	And  I deactivate it with code 0941
    Then I should see status "Intact" + "Inactive" + 0 deactivation attempts

  Scenario: Check status for an activated bomb after wrong deactivation code
  	Given I create a bomb with codes 9854 and 0941
	And  I activate it with code 9854
	And  I deactivate it with code 0000
    Then I should see status "Intact" + "Active" + 1 deactivation attempts

  Scenario: Check status for an activated bomb after two wrong deactivation codes
  	Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
	And  I deactivate it with code 0000
	And  I deactivate it with code 0000
    Then I should see status "Intact" + "Active" + 2 deactivation attempts

  Scenario: Check status for an activated bomb after two wrong deactivation codes
  	Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
	And  I deactivate it with code 0000
	And  I deactivate it with code 0000
	And  I deactivate it with code 0000
    Then I should see status "Blown to shreds" + "NA" + 3 deactivation attempts


  # Bomb Snipped
  Scenario: Check status for a bomb that was snipped
  	Given I create a bomb with codes 9854 and 0941
	When I snip the wires
    Then I should see status "Wires are cut" + "NA" + 0 deactivation attempts

  Scenario: Check status for a bomb that was snipped then deactivation attempt
  	Given I create a bomb with codes 9854 and 0941
	When I snip the wires
	And  I deactivate it with code 0000
    Then I should see status "Wires are cut" + "NA" + 0 deactivation attempts

  Scenario: Check status for a bomb that was activated then snipped
  	Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
	And  I snip the wires 
    Then I should see status "Wires are cut" + "NA" + 0 deactivation attempts


  # Bomb (Manual) Detonation
  Scenario: Check status for a bomb that was detonated
  	Given I create a bomb with codes 9854 and 0941
	When I detonate it
    Then I should see status "Blown to shreds" + "NA" + 0 deactivation attempts

  Scenario: Check status for a bomb that was detonated then deactivation attempt
  	Given I create a bomb with codes 9854 and 0941
	When I detonate it
	And  I deactivate it with code 0000
    Then I should see status "Blown to shreds" + "NA" + 0 deactivation attempts

  Scenario: Check status for a bomb that was activated then detonated
  	Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
	And  I detonate it 
    Then I should see status "Blown to shreds" + "NA" + 0 deactivation attempts

  Scenario: Check status for a bomb that was snipped then detonated
  	Given I create a bomb with codes 9854 and 0941
	When I snip the wires
	And  I detonate it 
    Then I should see status "Wires are cut" + "NA" + 0 deactivation attempts

  Scenario: Check status for a bomb that was deactivated with wrong code then detonated
  	Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
	And  I deactivate it with code 0009
	And  I detonate it
    Then I should see status "Blown to shreds" + "NA" + 1 deactivation attempts
