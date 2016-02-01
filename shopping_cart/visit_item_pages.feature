Feature: Visit item pages from cart
	As a user
	I want to visit item pages by clicking on the line items in my cart
	So I can review the item description when I second-guess whether I should purchase it

	Scenario: Visit item page by clicking on line item
		Given that I have 1 Broomstick and 1 Wand in my cart
		And I am on the shopping cart page
		When I click the "Broomstick" link
		Then I should be on the Broomstick item page