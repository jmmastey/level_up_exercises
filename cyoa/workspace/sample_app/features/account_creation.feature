Feature: User account creation
	In order to fave photos
	As the user
	I want to sign up for an account

	Scenario: New user sign up 
		Given I am on the sign up page
		And I am a new user
		When I enter my email address
		And I enter a password
		Then I see a signup success message

	Scenario: New user sign up failure
		Given I am on the sign up page
		And I am a new user
		When I enter an invalid email
		Then I see an email error message

	Scenario: New user sign up password failure
		Given I am on the sign up page
		And I am a new user
		When I enter an invalid password
		Then I see a password error message

	Scenario: Existing user sign up
		Given I am on the sign up page
		And I am an existing user
		When I enter my email address 
		And I enter my password
		Then I am logged in 
