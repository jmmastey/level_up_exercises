Feature: Logging in to web account
	As a user
	I want to log in to my account
	To see which deeds I have tagged and to configure email alerts

	Background:
		Given I am at the user log in page

	Scenario: Enter valid login credentials
		When I submit valid login credentials
		Then I am logged in to my account
		And I can see my tagged deeds and email alerts