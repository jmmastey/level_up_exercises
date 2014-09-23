Feature: Bomb Activation and Deactivation 
  In order to test the Bomb class
  As a developer who wrote Bomb
  I want to ensure the bomb can be activated, dwactivated, snipped and detonated

  Scenario: Create a default bomb
    Given I create a bomb with no code
	Then I should see it is not active

  Scenario: Activate a default bomb with correct code
    Given I create a bomb with no code
	When I activate it with code 1234
	Then I should see it is active

  Scenario: Deactivate a default bomb with correct code
    Given an activated bomb with default codes
	And I deactivate it with code 0000
	Then I should see it is not active

  Scenario: Create a bomb with codes
    Given I create a bomb with codes 9854 and 0941
	Then I should see it is not active

  Scenario: Activate a coded bomb with correct code
    Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
	Then I should see it is active

  Scenario: Dectivate a coded bomb with correct code
    Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
	And I deactivate it with code 0941
	Then I should see it is not active

  Scenario: Activate a coded bomb with incorrect code
    Given I create a bomb with codes 9854 and 0941
	When I activate it with code 1234
	Then I should see it is not active

  Scenario: Dectivate a coded bomb with incorrect code
    Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
	And I deactivate it with code 0000
	Then I should see it is active

  Scenario: Create a bomb with bad activation code, it resorts to default code
    Given I create a bomb with codes ABCD and 0941
	When I activate it with code 1234
	Then I should see it is active

  Scenario: Create a bomb with bad deactivation code, it resorts to default code
    Given I create a bomb with codes 9854 and ABCD
	When I activate it with code 9854
	And I deactivate it with code 0000
	Then I should see it is not active

  Scenario: Activate with a bad code
    Given I create a bomb with codes 9854 and 0941
	When I activate it with code 1234
	Then I should see it is not active

  Scenario: Dectivate with a bad code
    Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
    And I deactivate it with code 0000
    Then I should see it is active

  # Bomb Deactivation With Wrong Codes
  Scenario: Deactive with wrong code three times
    Given I create a bomb with codes 9854 and 0941
	When I activate it with code 9854
	And  I deactivate it with code 1111
	And  I deactivate it with code 1111
	And  I deactivate it with code 1111
	Then I should see it exploded

  Scenario: Deactive with wrong code two times
    Given I create a bomb with codes 9854 and 0941
	When I deactivate it with code 1111
	And  I deactivate it with code 1111
	Then I should see it not exploded


  # Bomb Status (States)
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
