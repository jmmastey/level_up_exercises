Feature: Authentication
	
	As a user
	I want to log in to movie review website
	In oder to review my favorite movies 
	
	# Happy path
	
	Scenario: Logging in to website

	Given I am on home page
	When I click on 'Log in'
	Then I see 'Email' field
		And I see 'Password' field
		And I see 'Log in' button

	Scenario: Entering correct username and password

	Given I visit login page
	When I enter correct email
		And I enter correct password
		And I click 'Log in' button
	Then I see the home page

	Scenario: Logging out of website
	
	Given I am logged in
	When I click 'Logout' link
	Then I see 'Log in' link

	#Sad path

	Scenario: Entering valid username but invalid password
	
	Given I visit login page
	When I enter valid email
		And I enter invalid password
		And I click 'Log in' button
	Then I see error message

	Scenario: Entering invalid username but valid password
	
	Given I visit login page
	When I enter invalid email
		And I enter valid password
		And I click 'Log in' button
	Then I see error message

	#Bad path

	Scenario: Username does not pass validation
	
	Given I visit login page
	When I enter junk characters email
		And I enter valid password
		And I click 'Login' button
	Then I see error message