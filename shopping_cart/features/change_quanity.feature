Feature: Change Item Quantities

	As a shopper
	I want to be able to change the quantities of the items I add to my cart

	Scenario: Increase item quantity by 1
		Given a cart with 1 car at $10.00
		When I increase the quanity of cars by 1
		Then I expect the cart to have 2 items
		And a subtotal of $20.00

	Scenario: Decrease item quantity by 1
		Given a cart with 1 car at $10.00
		When I decrease the quanity of cars by 1
		Then I expect the cart to have 0 items
		And a subtotal of $0.00

	Scenario: Increase item quantity by 5
		Given a cart with 10 cars at $10.00 each
		When I increase the quanity of cars by 5
		Then I expect the cart to have 15 items
		And a subtotal of $150.00

	Scenario: Reduce item quantity by 5
		Given a cart with 10 cars at $10.00 each
		When I decrease the quanity of cars by 5
		Then I expect the cart to have 5 items
		And a subtotal of $50.00
