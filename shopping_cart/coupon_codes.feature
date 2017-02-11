Feature: add coupon code for discount
	As a user
	I want to add a coupon code
	So I can save money and get the discount I was promised

	Background:
		Given that I have 1 Textbook in my cart
		And I am on the shopping cart page

		Scenario: User enters a valid coupon code to save a static amount
			Given a coupon code that gives a flat discount is active
			When I enter the active coupon code
			Then I should see that I saved a flat amount on my order
			
		Scenario: User enters a valid coupon code for a particular item on the right item
			Given a coupon code that discounts Textbooks is active
			When I enter the active coupon code
			Then I should see that I saved money on the Textbook

		Scenario: User enters a valid coupon code to save a percent
			Given a coupon code that saves 10% is active
			When I enter the active coupon code
			Then I should see that I saved a percentage on my order

		Scenario: User enters an expired coupon code
			Given a coupon code has expired
			When I enter the expired coupon code
			Then I should see that the coupon has expired

		Scenario: User enters an invalid coupon code
			Given an invalid coupon code
			When I enter the invalid coupon code
			Then I should see that the coupon is invalid

		Scenario: User enters a coupon code for a particular item on the wrong item
			Given a coupon code that discounts Butterbeer is active
			And I have 0 Butterbeer in my cart
			When I enter the coupon code that discounts Butterbeer
			Then I should see that the coupon code doesn't apply to items in my cart