Feature: Add an address

	As a user
	I want to add my address inforamtion
	So that I can ship stuff to my house

	Scenario: Entering valid address information

	Given I am logged in to the website
	When I click 'Add address'
	Then I see address information form
	When I enter a valid address
		And I click 'Save'
	Then My address is saved in the system

	Scenario: Entering invalid street code
	
	Given I am logged in to the website
	When I click 'Add address'
	Then I see address information form
	When I enter a invalid street code for address information
		And I click 'Save'
	Then I see error message

	Scenario: Entering invalid street name
	
	Given I am logged in to the website
	When I click 'Add address'
	Then I see address information form
	When I enter a invalid street name for address information
		And I click 'Save'
	Then I see error message

	Scenario: Entering invalid city
	
	Given I am logged in to the website
	When I click 'Add address'
	Then I see address information form
	When I enter a invalid city for address information
		And I click 'Save'
	Then I see error message

	Scenario: Entering invalid state

	Given I am logged in to the website
	When I click 'Add address'
	Then I see address information form
	When I enter a invalid state for address information
		And I click 'Save'
	Then I see error message

	Scenario: Invalid zip code in shipping address
	
	Given I am logged in to the website
	When I click 'Add address'
	Then I see address information form
	When I enter a invalid zip code for address information
		And I click 'Save'
	Then I see error message