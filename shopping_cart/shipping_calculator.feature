Feature: weight-agnostic shipping calculator
	As a user
	I want to know the cost to ship products to my address
	So I can expect how much my grand order total will be

	Background:
		Given that I have 1 Broomstick in my cart
		And I am on the checkout page

	Scenario: User submits form with valid address
		Given I fill in the shipping estimate form with valid values
		When I submit the shipping estimate form
		Then I should see "Your Shipping Estimate: $9.99"

	Scenario: User submits form with a nonexistent shipping address in a valid format
		Given I fill in the shipping estimate form with a valid address that is not in our system
		When I submit the shipping estimate form
		Then I should see an alert "Our system shows that address as invalid. Proceed anyway?"

	Scenario: User submits form with invalid values
		Given I fill in the shipping estimate form with invalid values
		When I submit the shipping estimate form
		Then I should see a notification that my form is invalid