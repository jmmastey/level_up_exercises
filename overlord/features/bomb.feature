Feature: Bomb
  In order to test the Bomb class
  As a developer who wrote Bomb
  I want to create/activate/deactivate a bomb

  Scenario: Create a default bomb
    Given I create a bomb with no code
	Then I should see it is not active

  Scenario: Activate a default bomb with correct code
    Given I create a bomb with no code
	When I activate it with code 1234
	Then I should see it is active

  Scenario: Deactivate a default bomb with correct code
    Given I create a bomb with no code
	When I activate it with code 1234
	And I deactivate it with code 0
	Then I should see it is not active

  Scenario: Create a bomb with codes
    Given I create a bomb with codes 9854 0941
	Then I should see it is not active

  Scenario: Activate a coded bomb with correct code
    Given I create a bomb with codes 9854 0941
	When I activate it with code 9854
	Then I should see it is active

  Scenario: Dectivate a coded bomb with correct code
    Given I create a bomb with codes 9854 0941
	When I activate it with code 9854
	And I deactivate it with code 0941
	Then I should see it is not active

  Scenario: Activate a coded bomb with incorrect code
    Given I create a bomb with codes 9854 0941
	When I activate it with code 1234
	Then I should see it is not active

  Scenario: Dectivate a coded bomb with incorrect code
    Given I create a bomb with codes 9854 0941
	When I activate it with code 9854
	And I deactivate it with code 0000
	Then I should see it is active

  Scenario: Create a bomb with bad codes (non-Integer)
    Given I create a bomb with bad codes ABCD 0941 it raises an ArgumentError

  Scenario: Create a bomb with bad codes (non-Integer)
    Given I create a bomb with bad codes 1234 ABCD it raises an ArgumentError

  Scenario: Activate with a bad code
    Given I create a bomb with codes 9854 0941

  Scenario: Dectivate with a bad code
    Given I create a bomb with codes 9854 0941

  Scenario: Deactive with wrong code three times
    Given I create a bomb with codes 9854 0941
	When I activate it with code 9854
	And  I deactivate it with code 1111
	And  I deactivate it with code 1111
	And  I deactivate it with code 1111
	Then I should see it exploded

  Scenario: Deactive with wrong code two times
    Given I create a bomb with codes 9854 0941
	When I deactivate it with code 1111
	And  I deactivate it with code 1111
	Then I should see it not exploded

  Scenario: Check status for a newly created bomb
  	Given I create a bomb with no codes
    Then I should see status "Intact" + "Inactive" + 0 deactivation attempts

  Scenario: Check status for an activated bomb
  	Given I create a bomb with codes 9854 0941
	When I activate it with code 9854
    Then I should see status "Intact" + "Active" + 0 deactivation attempts

  Scenario: Check status for an activated then deactivated bomb
  	Given I create a bomb with codes 9854 0941
	When I activate it with code 9854
	And  I deactivate it with code 0941
    Then I should see status "Intact" + "Inactive" + 0 deactivation attempts

  Scenario: Check status for an activated bomb after wrong deactivation code
  	Given I create a bomb with codes 9854 0941
	And  I activate it with code 9854
	And  I deactivate it with code 0000
    Then I should see status "Intact" + "Active" + 1 deactivation attempts

  Scenario: Check status for an activated bomb after two wrong deactivation codes
  	Given I create a bomb with codes 9854 0941
	When I activate it with code 9854
	And  I deactivate it with code 0000
	And  I deactivate it with code 0000
    Then I should see status "Intact" + "Active" + 2 deactivation attempts

  Scenario: Check status for an activated bomb after two wrong deactivation codes
  	Given I create a bomb with codes 9854 0941
	When I activate it with code 9854
	And  I deactivate it with code 0000
	And  I deactivate it with code 0000
	And  I deactivate it with code 0000
    Then I should see status "Blown to shreds" + "NA" + 3 deactivation attempts

  Scenario: Check status for a bomb that was snipped
  	Given I create a bomb with codes 9854 0941
	When I snip the wires
    Then I should see status "Wires are cut" + "NA" + 0 deactivation attempts

  Scenario: Check status for a bomb that was snipped then deactivation attempt
  	Given I create a bomb with codes 9854 0941
	When I snip the wires
	And  I deactivate it with code 0000
    Then I should see status "Wires are cut" + "NA" + 0 deactivation attempts

  Scenario: Check status for a bomb that was snipped then deactivation attempt
  	Given I create a bomb with codes 9854 0941
	When I activate it with code 9854
	And  I snip the wires 
    Then I should see status "Wires are cut" + "NA" + 0 deactivation attempts
