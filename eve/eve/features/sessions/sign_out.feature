@session
Feature: Sign out
	As an account holder
	I want to sign out
	In order to prevent others from messing up my stuff

	Background:
		Given I am signed in
		When I click the "Sign Out" link
		Then I see the message "Signed out successfully."
