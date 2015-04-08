Feature: Anonymous cart updates

	As a user
	I want to add items to the cart even if I am not logged in
	In order to quickly add items to the cart wihout going through the login process

	Scenairo: Persist anonymous cart updates on loggin in
	
	Given I visit shopping website
		And I add item 'X' to the cart
	When I login
	Then I see item 'X' in my cart
		And Quantity for item 'X' is 1
		And Total Quantity in cart is 1

	Scenario: Persist cart updates on logout
	
	Given I login to shopping website
		And I add item 'X' to my cart
		And I logout
	When I login 
	Then I see item 'X' in my cart
		And Quantity for item 'X' is 1
		And Total Quantity in cart is 1

	Scenario: Merge anonymous cart updates with saved cart
	
	Given I visit shopping website
		And I add item 'X' to the cart
	When I login
	Then I see item 'X' in my cart
	When I add item 'Y' to the cart
	Then I see item Y' in my cart