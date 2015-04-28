Feature: Home Page

	As a user I would like to visit movie review website
	In order to available movies to review

	Scenario: Accessing the home page before log in 

	When I enter application url in the browser
	Then I see the home page
		And I see a link to log in
		And I see welcome message
		And I see a link to sign up

	Scenario: Accessing the home page after log in 

	When I enter application url in the browser
		And I log in
	Then I see the home page

	Given I am on home page