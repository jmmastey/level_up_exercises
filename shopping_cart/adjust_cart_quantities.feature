Feature: adjust quantities on items in my cart or delete them
	As a customer
	I want to adjust quantities on items in my cart or delete them
	So that I can buy the mix of items I want

	Background: 
		Given that I have 1 Broomstick in my cart
		And I am on the shopping cart page

		Scenario: Delete item from cart on shopping cart page
			When I delete the Broomstick
			Then I should see 0 items in my cart

		Scenario: Change item quantity in cart on shopping cart page
			Given I see "Adjust quantity? Enter an integer from 0-99"
			When I change the number of Broomsticks in my cart to 3
			Then I should see 3 Broomsticks in my cart

		Scenario: Change item quantity in cart on shopping cart page to 0, deleting it from cart
			Given I see "Adjust quantity? Enter an integer from 0-99"
			When I change the number of Broomsticks in my cart to 0
			Then I should see 0 items in my cart
	
		Scenario: Change item quantity in cart to an integer over 99
			Given I see "Adjust quantity? Enter an integer from 0-99"
			When I change the number of Broomsticks in my cart to >99
			Then I should see "Please enter an integer between 0-99"
			And I should see 1 Broomstick in my cart
	
		Scenario: Attempt to change item quantity in cart to an integer less than 0
			Given I see "Adjust quantity? Enter an integer from 0-99"
			When I change the number of Broomsticks in my cart to <0
			Then I should see "Please enter an integer between 0-99"
			And I should see 1 Broomstick in my cart

		Scenario: Change item quantity in cart to a non-integer
			When I change the number of Broomsticks in my cart to a string
			Then I should see "Please enter an integer between 0-99"
			And I should see 1 Broomstick in my cart

	Scenario: User clicks "add to cart" on an item of which there is already one in cart
		Given I am on the Broomstick item page
		When I add the Broomstick to my cart
		And I visit the shopping cart page
		Then I should see 2 Broomsticks in my cart
		And the cart should see 1 SKU represented

	Scenario: Updating item quantity in cart on shopping cart page doesn't affect other items in cart
		Given that I have 1 Broomstick and 1 Wand in my cart
		And I am on the shopping cart page
		When I change the number of Broomsticks in my cart to 3
		Then I should see 3 Broomsticks and 1 Wand in my cart

