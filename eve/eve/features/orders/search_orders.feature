Feature: Searching orders
	As an EVE player
	I want to search orders
	In order to track item prices for certain locations

	Background:
		Given some orders exist

	Scenario: Searching orders with no matches
		When I visit the orders page
		And I search for orders without expected matches
		Then I see the message "Could not find any orders."

	Scenario: Searching orders with matches
		When I visit the orders page
		And I search for orders with expected matches
		Then I see the details of matching orders
