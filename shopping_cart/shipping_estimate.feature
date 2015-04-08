Feature: Shipping Estimate
	
	As a user
	I want to know the shipping cost and time for the things I purchased
	So that I can decicde whether to purchase the items or not

	Scenario: Selecting valid address for shipping estimate
	
	Given I am logged in to the website
		And I have added item 'X' to my cart
	When click 'Shipping Estimate'
		And I select existing address on my account
	Then I see an estimated shipping cost
		And I see an estimated shipping time

	Scenario: Entering invalid address for shipping estimate
	
	Given I am logged in to the website
		And I have added item 'X' to my cart
	When click 'Shipping Estimate'
		And I select to use a different address not listed on account
	Then I see an address information form
	When I enter invalid address information
	Then I see an error message

	
