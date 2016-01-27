Feature: Add another item of the same SKU that's already in user's cart updates qty in cart
	As a user
	I want to add more items to cart of the ones I already had
	So I can stock up on Sour Patch Kids in preparation for a zombie apocalypse

	Scenario: User clicks "add to cart" on an item of which there is already one in cart
		Given that I have 1 Broomstick in my cart
		And I am on the Broomstick item page
		When I click the "Add to cart" button
		And I visit the shopping cart page
		Then I should see "2 Broomsticks"
		And the cart should see 1 SKU represented