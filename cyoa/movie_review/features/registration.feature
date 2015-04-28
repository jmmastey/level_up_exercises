Feature: Registration

	As user I want to sign up for movie review webiste
	So that I can rate and review movies

	Scenario: Signing Up for the website
	Given I am on home page
	When I click 'Sign Up to Write A Review'
	Then I see registration form

	Scenario: Entering valid email and password for registration
	Given I see registration form
	When I enter valid email 
		And I enter valid password
		And I enter same password for confirmation
		And I click 'Sign up'
	Then I see the home page

	Scenario: Entering invalid email and valid password for registration
	Given I see registration form
	When I enter invalid email 
		And I enter valid password
		And I enter same password for confirmation
		And I click 'Sign up'
	Then I see error message for invalid email

	Scenario: Entering valid email and empty password for registration
	Given I see registration form
	When I enter invalid email 
		And I do not enter password
		And I do not enter password for confirmation
		And I click 'Sign up'
	Then I see error message for empty password

	Scenario: Entering valid email and too short password for registration
	Given I see registration form
	When I enter invalid email 
		And I enter password that is to short 
		And I enter same password for confirmation
		And I click 'Sign up'
	Then I see error message for too short password