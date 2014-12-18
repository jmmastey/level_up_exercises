@session
Feature: Registration
	As an EVE player
	I want to register an account
	In order to save personalized information

	Scenario Outline: Signing up
		Given I am on the registration page
		When I enter the email "<email>"
		And I enter the password "<password>"
		And I enter the password confirmation "<password_confirmation>"
		And I click the "Sign Up" button
		Then I see the message "<message>"

		Examples:
			| email            | password | password_confirmation | message                             |
			| test@example.com | testtest | testtest              | You have signed up successfully.    |
			| test             | testtest | testtest              | Email is invalid                    |
			|                  | testtest | testtest              | Email can't be blank                |
			| test@example.com |          |                       | Password can't be blank             |
			| test@example.com | testtest | test123               | Password confirmation doesn't match |
			| test@example.com | test     | test                  | Password is too short               |

	Scenario: Signing up with an email that has already been registered
		Given the following users exist:
			| email            | password |
			| test@example.com | testtest |
		And I am on the registration page
		When I enter the email "test@example.com"
		And I enter the password "test1234"
		And I enter the password confirmation "test1234"
		And I click the "Sign Up" button
		Then I see the message "Email has already been taken"

	Scenario: Signing up while signed in
		Given I am signed in
		When I visit the registration page
		Then I see the message "You are already signed in."
