Feature: Discounts

	As a user
	I want to use coupons
	So that I can get discounts on my purchases

	Scenario: Using a valid non-expired coupon

	Given I am logged in to the website
		And I have items in my cart
	When I click 'Proceed to checkout'
	Then I see my order total
		And I see a filed to enter coupon code
	When I use a valid non-expired coupon code
		And click 'Apply'
	Then I see my order total updated after discount

	Scenario: Using a valid expired coupon

	Given I am logged in to the website
		And I have items in my cart
	When I click 'Proceed to checkout'
	Then I see my order total
		And I see a filed to enter coupon code
	When I use a valid but expired coupon code
		And click 'Apply'
	Then I see error message 'This coupon has expired'

	Scenario: Using an invalid coupon

	Given I am logged in to the website
		And I have items in my cart
	When I click 'Proceed to checkout'
	Then I see my order total
		And I see a filed to enter coupon code
	When I use an invalid coupon code
		And click 'Apply'
	Then I see error message 'This coupon is invalid'	



