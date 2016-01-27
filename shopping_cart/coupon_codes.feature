Feature: add coupon code for discount
	As a user
	I want to add a coupon code
	So I can save money and get the discount I was promised

	Scenario: User enters a valid coupon code to save a static amount
		Given that I have 1 Textbook in my cart
		And the price of a Textbook is $100
		And the "LOCKHART_FAN" coupon code is active
		And I am on the shopping cart page
		When I fill in the coupon code form with "LOCKHART_FAN"
		And I click the "Apply coupon code" button
		Then I should see "-20.00"
		And I should see "You saved 20.00"

	Scenario: User enters a valid coupon code for a particular item on the right item
		Given that I have 1 Butterbeer in my cart
		And the price of a Butterbeer is $15
		And the "5_OFF_BUTTERBEER" coupon code is active
		And I am on the shopping cart page
		When I fill in the coupon code form with "5_OFF_BUTTERBEER"
		And I click the "Apply coupon code" button
		And I should see "-5.00"

	Scenario: User enters a valid coupon code to save a percent
		Given that I have 1 Butterbeer in my cart
		And the price of a Butterbeer is $15
		And the "SAVE_10_PERCENT" coupon code is active
		And I am on the shopping cart page
		When I fill in the coupon code form with "SAVE_10_PERCENT"
		And I click the "Apply coupon code" button
		Then I should see "-1.50"
		And I should see "You saved 10%"

	Scenario: User enters an expired or invalid coupon code
		Given that I have 1 Textbook in my cart
		And the price of a Textbook is $100
		And the "SNAPE_SUX" coupon code is not active
		And I am on the shopping cart page
		When I fill in the coupon code form with "SNAPE_SUX"
		And I click the "Apply coupon code" button
		Then I should see "That's not currently a valid coupon code"

	Scenario: User enters a coupon code for a particular item on the wrong item
		Given that I have 1 Textbook in my cart
		And the price of a Textbook is $100
		And the "5_OFF_BUTTERBEER" coupon code is active
		And I am on the shopping cart page
		When I fill in the coupon code form with "5_OFF_BUTTERBEER"
		And I click the "Apply coupon code" button
		Then I should see "That coupon code doesn't apply to the items in your cart"