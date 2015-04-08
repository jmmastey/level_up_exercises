Feature: Edit Cart

	As a user
	I want to edit my cart by adding, removing and changing quantities on items
	In order stay within my budget

	Scenario: Update total quantity in the cart
	
	Given I have logged in to the website
		And I have added X item to the cart
	When I select another item 'Y'
		And I click 'Add to cart'
	Then I go to the cart page
		And I see items 'X' and 'Y' in my cart
		And Quantity for item 'Y' is 1
		And Total quantity in cart is 2

 	Scenario: Add duplicate item to cart
 	
 	Given I have logged in to the website
 		And I have added item 'X' to the cart
 	When I select itme 'X'
 		And I click 'Add to cart'
 	Then I go to the cart page
		And I see item 'X' in my cart
		And Quantity for the item is 2

	Scenario: Change quantity for an item in cart
	
	Given I have logged in to the website
		And I have added item 'X' in my cart
		And the quantity for the item is 1
	When I change quantity to N greater than 1
	Then Quantity for the item is updated to N

	Scenario: Remove item from cart by changing quantity to 0
	
	Given I have logged in to the website
		And I have added item 'X' in my cart
		And the quantity for the item is 1
	When I change quantity to 0
	Then I do not see item 'X' in cart

	Scenario: Remove item from cart by clicking remove button
	
	Given I have logged in to the website
		And I have added item 'X' in my cart
	When I click 'Remove' for item 'X'
	Then I do not see item 'X' in cart		

	Scenario: Remove single item from cart containing multiple itmes
	
	Given I have logged in to the website
		And I have added items X and Y to my cart
	When I click 'Remove' for an item X
	Then I see item 'Y' in my cart
		And Quantity for item 'Y' is 1
		And Total Quantity in cart is updated to 1
	
	Scenario: Empty cart
	
	Given I have logged in to the website
		And I have added only 1 item in my cart
	When I click 'Remove' for that item
	Then Total Quantity in cart is 0

	Scenrio: Negative quantity
	
	Given I have logged in to the website
		And I have added one item in my cart
	When I change quantity for that item to N less than 0
	Then I see error message 'Quantity cannot be negative'

	Scenario: Too large quantity
	
	Given I have logged in to the website
		And I have added one item in my cart
	When I change quantity for that item to '5000000'
	Then I see error message 'Quantity too large'

	Scenario: Non-numeric quantity
	
	Given I have logged in to the website
		And I have added one item in my cart
	When I change quantity for that item to 'ad'
	Then I see error message 'Quantity should be numeric'
