Feature: Valid control inputs only accepted
	In order to make sure we can use the bomb safely
	As a super villain
	I want to accept only numeric control inputs

	Background:
		Given I have booted the bomb
		And I change no configuration code

	@bad
	Scenario: I enter an alpha code
		When I enter the code "abcd" 1 time(s)
		Then I am on the control page
		And the error message "Codes must be numeric" shows
		And the status indicator shows as deactivated