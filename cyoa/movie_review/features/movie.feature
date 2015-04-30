Feature: Movie Page

	As a user I want to view movie details
	So that I can see reviews posted by other users

	Scenario: Accessing movie page with no reviews
	Given I am on home page
	When I click on a movie poster
	Then I am redirected to movie page
		And I see movie title
		And I see movie release date
		And I see no reviews posted
		And I see a link to write a review

	Scenario: Accessing movie page with reviews
	Given I am on home page
	When I click on a movie poster
	Then I am redirected to movie page
		And I see movie title
		And I see movie release date
		And I see prevously posted reviews
		And I see a link to write a review
