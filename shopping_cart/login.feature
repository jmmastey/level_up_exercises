Feature: Authentication
	
	As a user of the 21st century
	I want to log in to online shopping website
	In oder to buy things and get discounts as a member
	
	# Happy path
	
	Scenario: Logging in to website

	Given I have registered with the website
	When I click on 'Sign In'
	Then I see 'Username' field
		And I see 'Password' field
		And I see 'Login' button

	Scenario: Entering correct username and password

	Given I visit login page
	When I enter correct username
		And I enter correct password
		And I click 'Login' button
	Then I see home page

	Scenario: Logging out of website
	
	Given I am logged in
	When I click 'Logout' button
	Then I am logged out

	#Sad path

	Scenario: Entering valid username but invalid password
	
	Given I visit login page
	When I enter valid username
		And I enter invalid password
		And I click 'Login' button
	Then I see error message

	Scenario: Entering invalid username but valid password
	
	Given I visit login page
	When I enter invalid username
		And I enter valid password
		And I click 'Login' button
	Then I see error message

	#Bad path

	Scenario: Username does not pass validation
	
	Given I visit login page
	When I enter junk characters username
		And I enter valid password
		And I click 'Login' button
	Then I see error message
