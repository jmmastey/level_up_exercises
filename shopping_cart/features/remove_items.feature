Feature: Add item to cart

	As a shopper
	I want to be able to remove items from my shopping cart
	So I can purchase only the items I want

	Background:
		Given I add "item_1" at priced at "price_1"
		And I add "item_2" at priced at "price_2"

	Scenario: Remove single item from cart with multiple items
		When I remove "item_1" from the cart
		Then I should not see "item_1" in the cart
		And I expect the total quantity to be 1 item
		And the subtotal should be "price_2"

	Scenario: I Remove all item from cart with multiple items
		When I remove all items from the cart
		Then I should see not see "item_1" or "item_2" in the cart
		And the total quantity should be 0
		And the subtotal should $0.00

	Scenario: I can remove, and re-add a product
		When I remove "item_1"
		And I add "item_1"
		Then I should see "item_1" in the cart
		And the total quantity should be 2
		And the subtotal should ("price_1" + "price_2")
