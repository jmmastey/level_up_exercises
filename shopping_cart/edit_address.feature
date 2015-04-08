Feature: Edit an address

	As a user
	I want to edit my address inforamtion
	So that I can ship stuff to my new house

	Scenario: Updating address information

	Given I am logged in to the website
	When I click 'Edit address'
	Then I see my address information
	When I enter new address information  
		And I click 'Save'
	Then My new address is saved in the system

	Scenario: Updating invalid street code
	
	Given I am logged in to the website
	When I click 'Add address'
	Then I see address information form
	When I enter a invalid street code for address information
		And I click 'Save'
	Then I see error message

	Scenario: Updating invalid street name
	
	Given I am logged in to the website
	When I click 'Add address'
	Then I see address information form
	When I enter a invalid street name for address information
		And I click 'Save'
	Then I see error message

	Scenario: Updating invalid city
	
	Given I am logged in to the website
	When I click 'Add address'
	Then I see address information form
	When I enter a invalid city for address information
		And I click 'Save'
	Then I see error message

	Scenario: Updating invalid state

	Given I am logged in to the website
	When I click 'Add address'
	Then I see address information form
	When I enter a invalid state for address information
		And I click 'Save'
	Then I see error message

	Scenario: Updating zip code in shipping address
	
	Given I am logged in to the website
	When I click 'Add address'
	Then I see address information form
	When I enter a invalid zip code for address information
		And I click 'Save'
	Then I see error message