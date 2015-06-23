Feature: Log into account
  In order to check out
  As the online shopper
  I want to log into my existing account

  Scenario: Log in to an existing account
  	Given I am on the login page
  	And quantity is 0
  	When I enter username JessTang
	  And I enter password iamthebest1
	  And click the "submit" button
	  Then I see the "Welcome Back JessTang" message 

	Scenario: Log in with with items in the cart
		Given I am on the login page
		And I am not logged in
		And I have items in my anonymous cart
		When I enter username JessTang
	  And I enter password iamthebest1
	  And click the "submit" button
	  I see the new items added to the existing items

	#sad
	Scenario: Forgot username or password
		Given I am on the login page
		And I am not logged in 
		When I enter and invalid username vvvvvvvv
		And I enter password 111111
		Then I see "incorrect" message

	#bad
	Scenario: Malicious overlord attack
		Given I am on the login page
		And I am not logged in 
		When I enter 70 "z"s
		And I enter password $*#$*&)$&^#$&*#$*(#$&#*$
		Then I see "incorrect" message

	Scenario:
		Given I am on the login page
		And I am not logged in 
		When I enter username as SQL code ' OR '1'='1
		And any password 111111
		Then I see "incorrect" message
	
	Scenario:
		Given I am on the login page
		And I am not logged in 
		When I enter username Jessica 
		And password SQL code ' OR '1'='1
		Then I see "incorrect" message