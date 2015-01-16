Feature: Valid configuration inputs only accepted
	In order to configure the bomb safely
	As a super villain
	I want to accept only numeric configuration inputs

	Background:
		Given I have booted the bomb

	Scenario Outline: I enter alpha codes
		When I fill in the <code_type> code as "<code>"
		And I submit the configuration
		Then I am on the configuration page
		And the error message "Codes must be numeric" shows

	@bad
	Examples:
		| code_type    | code |
		| activation   | abcd |
		| deactivation | abcd |