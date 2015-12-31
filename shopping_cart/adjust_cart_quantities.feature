Feature: adjust quantities on items in my cart or delete them
	As a customer
	I want to adjust quantities on items in my cart or delete them
	So that I can buy the mix of items I want

	(happy path)
	Scenario: Delete item from cart on shopping cart page
		Given that I have 1 Broomstick in my cart
		And I am on the shopping cart page
		When I click the "Delete" button
		Then I should see 0 items in my cart

	(happy path)
	Scenario: Change item quantity in cart on shopping cart page
		Given that I have 1 Broomstick in my cart
		And I am on the shopping cart page
		When I fill in the item quantity for the first item with "3"
		And I click the "update quantity" button
		Then I should see 3 Broomsticks in my cart

	(happy path)
	Scenario: Updating item quantity in cart on shopping cart page doesn't affect other items in cart
		Given that I have 1 Broomstick and 1 Wand in my cart
		And I am on the shopping cart page
		When I fill in the item quantity for the first item with "3"
		And I click the "update quantity" button
		Then I should see 3 Broomsticks and 1 Wand in my cart

	(happy path)
	Scenario: Change item quantity in cart on shopping cart page to 0, deleting it from cart
		Given that I have 1 Broomstick in my cart
		And I am on the shopping cart page
		When I fill in the item quantity for the first item with "0"
		And I click the "update quantity" button
		Then I should see 0 items in my cart

	(sad path)
	Scenario: Change item quantity in cart to an integer over 99
		Given that I have 1 Broomstick in my cart
		And I am on the shopping cart page
		And I see "Adjust quantity? Enter an integer from 0-99"
		When I fill in the item quantity for the first item with "9001"
		And I click the "update quantity" button
		Then I should see "You can order up to 99 of each item type"
		And I should see 99 Broomsticks in my cart

	(sad path)
	Scenario: Attempt to change item quantity in cart to an integer less than 0
		Given that I have 1 Broomstick in my cart
		And I am on the shopping cart page
		And I see "Adjust quantity? Enter an integer from 0-99"
		When I fill in the item quantity for the first item with "-50"
		And I click the "update quantity" button
		Then I should see "Please enter an integer between 0-99"
		And I should see 1 Broomstick in my cart

	(bad path)
	Scenario: Change item quantity in cart to a non-integer
		Given that I have 1 Broomstick in my cart
		And I am on the shopping cart page
		When I fill in the item quantity for the first item with "ABCD"
		And I click the "update quantity" button
		Then I should see "That's not a valid entry"
		And I should see 1 Broomstick in my cart