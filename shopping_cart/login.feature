Feature: Login
	As a user of the 21st century
	I want to be able to log in and out of online shopping website
	
	# Happy path
	
	Scenario: Display login form

	Given I have registered with the website
	When I click on 'Sign In'
	Then I should see 'Username' field
	And 'Password' field
	And 'Login' button

	Scenario: Successful login

	Given I visit login page
	When I enter correct username
	And I enter correct password
	And I click 'Login' button
	Then I should see home page

	Scenario: Logout
	Given I am logged in
	When I click 'Logout' button
	Then I should be logged out

	#Sad path

	Scenario: Incorrect username and password
	Given I visit login page
	When I enter incorrect username
	And I enter incorrect password
	And I click 'Login' button
	Then I should see error message

	#Bad path

	Scenario: Invalid username and password
	Given I visit login page
	When I enter invalid username
	And I enter invalid password
	And I click 'Login' button
	Then I should see error message