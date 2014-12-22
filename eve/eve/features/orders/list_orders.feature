@order
Feature: Listing orders
	As an EVE player
	I want to list orders
	In order to track item prices

	Scenario: Listing orders when no orders exist
		When I visit the orders page
		Then I see the message "Could not find any orders."

	Scenario: Listing orders
		Given some orders exist
		When I visit the orders page
		Then I see the details of those orders
