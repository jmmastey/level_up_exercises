Feature: Add item to cart

	As a user
	I want to add items to the cart
	In order to purchase those items

	Scenario: Add item to empty cart
	
	Given I have logged in to the website
		And My cart is empty
	When I select item 'X'
		And I click 'Add to cart'
	Then I go to the cart page
		And I see item 'X' in my cart
		And Quantity for the item is 1
		And Total quantity in the cart is 1