Feature: Edit Cart

	As a user
	I want to add, remove and change quantities in my cart

	Scenario: Add item to empty cart
	Given I have logged in to the website
	And My cart is empty
	When I select item 'X'
	And I click 'Add to cart'
	Then I should go to the cart page
	And I should see item 'X' in my cart
	And Quantity for the item should be 1
	And Total quantity in cart should be 1

	Scenario: Update total quantity in the cart
	Given I have logged in to the website
	And I have added X item to the cart
	When I select another item 'Y'
	And I click 'Add to cart'
	Then I should go to the cart page
	And I should see items 'X' and 'Y' in my cart
	And Quantity for item 'Y' should be 1
	And Total quantity in cart should be 2

 	Scenario: Add duplicate item to cart
 	Given I have logged in to the website
 	And I have added item 'X' to the cart
 	When I select itme 'X'
 	And I click 'Add to cart'
 	Then I should go to the cart page
	And I should see item 'X' in my cart
	And Quantity for the item should be 2

	Scenario: Change quantity for an item in cart
	Given I have logged in to the website
	And I have added item 'X' in my cart
	And the quantity for the item is 1
	When I change quantity to N greater than 1
	Then Quantity for the item should be updated to N

	Scenario: Remove item from cart by changing quantity to 0
	Given I have logged in to the website
	And I have added item 'X' in my cart
	And the quantity for the item is 1
	When I change quantity to 0
	Then Item should be removed from cart

	Scenario: Remove item from cart by clicking remove button
	Given I have logged in to the website
	And I have added item 'X' in my cart
	When I click 'Remove' for item 'X'
	Then Item 'X' should be removed from cart		

	Scenario: Remove single item from cart containing multiple itmes
	Given I have logged in to the website
	And I have added items X and Y to my cart
	When I click 'Remove' for an item X
	Then I should see item 'Y' in my cart
	And Quantity for item 'Y' should be 1
	And Total quantity in cart should be updated to 1
	
	Scenario: Empty cart
	Given I have logged in to the website
	And I have added only 1 item in my cart
	When I click 'Remove' for that item
	Then Total Quantity in cart should be 0

	Scenairo: Persist anonymous cart updates on loggin in
	Given I visit shopping website
	And I add item 'X' to the cart
	When I login
	Then I should see item 'X' in my cart
	And Quantity for item 'X' should be 1
	And Total Quantity in cart should be 1

	Scenario: Persist cart updates on logout
	Given I login to shopping website
	And I add item 'X' to my cart
	And I logout
	When I login 
	Then I should see item 'X' in my cart
	And Quantity for item 'X' should be 1
	And Total Quantity in cart should be 1

	Scenario: Merge anonymous cart updates with saved cart
	Given I visit shopping website
	And I add item 'X' to the cart
	When I login
	And I add item 'Y' to the cart
	Then I should see items 'X' and 'Y' in my cart

	Scenrio: Negative quantity
	Given I have logged in to the website
	And I have added one item in my cart
	When I change quantity for that item to N less than 0
	Then I should see error message 'Quantity cannot be negative'

	Scenario: Too large quantity
	Given I have logged in to the website
	And I have added one item in my cart
	When I change quantity for that item to '5000000'
	Then I should see error message 'Quantity too large'

	Scenario: Non-numeric quantity
	Given I have logged in to the website
	And I have added one item in my cart
	When I change quantity for that item to 'ad'
	Then I should see error message 'Quantity should be numeric'
