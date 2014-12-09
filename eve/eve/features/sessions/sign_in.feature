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
	
	Scenario Outline: Valid logins
		When I enter the email <email>
		And I enter the password <password>
		And I click the "Sign In" button
		Then I see the message "Signed in successfully."

		Examples:
			| email                 | password |
			| testuser@example.com  | testtest |
			| testuser2@example.com | test1234 |
			| testuser3@example.com | test4567 |


	Scenario Outline: Bad logins
		When I enter the email <email>
		And I enter the password <password>
		And I click the "Sign In" button
		Then I see the message "Invalid email or password."

		Examples:
			| email                | password         |
			| testuser@example.com | invalid_password |
			| bademail@test.com    | test             |


	Scenario: Missing email
		When I enter the password test
		And I click the "Sign In" button
		Then I see the message "Invalid email or password."

	Scenario: Missing password
		When I enter the email testuser@example.com
		And I click the "Sign In" button
		Then I see the message "Invalid email or password."
