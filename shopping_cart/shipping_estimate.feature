Feature: Shipping Estimate
	As a user
	I want to know the shipping cost and time for the things I purchased

	Scenario: Get shipping estimate
	Given I am logged in to the website
	And I have added item 'X' to my cart
	When I enter valid address information
	And click 'Shipping Estimate'
	Then I should see an estimated shipping cost
	And I should an estimated shipping time

	Scenario: Invalid street code in shipping address
	Given I am logged in to the website
	And I have added item 'X' to my cart
	When I enter street code that does not exist
	And I click 'Shipping Estimate'
	Then I should see error message

	Scenario: Invalid street name in shipping address
	Given I am logged in to the website
	And I have added item 'X' to my cart
	When I enter street name that does not exist
	And I click 'Shipping Estimate'
	Then I should see error message

	Scenario: Invalid city in shipping address
	Given I am logged in to the website
	And I have added item 'X' to my cart
	When I enter city that does not exist
	And I click 'Shipping Estimate'
	Then I should see error message

	Scenario: Invalid state in shipping address
	Given I am logged in to the website
	And I have added item 'X' to my cart
	When I enter state that does not exist
	And I click 'Shipping Estimate'
	Then I should see error message

	Scenario: Invalid zip code in shipping address
	Given I am logged in to the website
	And I have added item 'X' to my cart
	When I enter zip code that does not exist
	And I click 'Shipping Estimate'
	Then I should see error message
