@watch
Feature: Watch listing
	As a user
	I want to list my watches
	In order to track order prices and trends

	Scenario: Displaying watches when not logged in
		When I visit the watches page
		Then I see the message "You need to sign in or sign up before continuing."

	Scenario: Displaying watches when none exist
		Given I am signed in
		When I visit the watches page
		Then I see the message "You have no watches."

	Scenario: Displaying watches
		Given I am signed in
		And some watches exist
		When I visit the watches page
		Then I see the details of those watches
