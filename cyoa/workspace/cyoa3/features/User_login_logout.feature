Feature: User log in / out
	In order to see my account and log out
	As the user
	I want to log in and out

	Scenario: Log in
		Given I am on the login page
		And I am not logged in
		When I enter my email address
		And I enter my password
		Then I see a log in success message

	Scenario: Log out
		Given I am on the photos page
		And I am logged in
		When I click the log out button
		Then I see a log out message

	Scenario: Log in fail - email
		Given I am on the login page
		And I am not logged in
		When I enter an invalid email address
		Then I see an email error message

	Scenario: Log in fail - password	
		Given I am on the login page
		And I am not logged in
		When I enter an invalid password
		Then I see a password error message
		