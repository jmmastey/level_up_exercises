@session
Feature: Signing in
	As an EVE player
	I want to sign in to my account
	In order to lookup my personalized info

	Background:
		Given the following users exist:
			| email                 | password |
			| testuser@example.com  | testtest |
			| testuser2@example.com | test1234 |
			| testuser3@example.com | test4567 |
		And I am on the login screen
	
	@login
	Scenario Outline: Login attempts
		When I enter the email "<email>"
		And I enter the password "<password>"
		And I click the "Sign In" button
		Then I see the message "<message>"

		Examples:
			| email                 | password         | message                    |
			| testuser@example.com  | testtest         | Signed in successfully.    |
			| testuser2@example.com | test1234         | Signed in successfully.    |
			| testuser3@example.com | test4567         | Signed in successfully.    |
			| testuser@example.com  | invalid_password | Invalid email or password. |
			| bademail@test.com     | test             | Invalid email or password. |
			| testuser@example.com  |                  | Invalid email or password. |
			|                       | testtest         | Invalid email or password. |
