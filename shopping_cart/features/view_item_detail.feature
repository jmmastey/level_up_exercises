Feature: View item detail for each item in cart
	As a shopper
	I want to be able to view an items product page from the cart
	So that I can review an items details before carrying out a purchase


	Scenario: View product detail page by clicking on item in cart
		Given I am on the cart index page 
		And I have a cart with multiple items
		When I click on an item in the item list
		Then I should be taken to the item detail page