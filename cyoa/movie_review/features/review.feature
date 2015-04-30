Feature: Write a review

	As a registered user I want to visit the website
	So that I can rate movies and write reviews

	Scenario: Accessing reveiew page
	Given I am logged in
		And I am on home page
	When I click on a movie poster
	Then I am redirected to movie page
	When I click Write a Review link
		Then I see review page

	Scenario: Writing a review
	Given I am logged in
		And I am on review page
	When I give a rating
		And I enter valid comment
		And I click 'Create Review' button
	Then I am redirected to movie page
		And I see my comment on movie page

	Scenario: Submitting an empty comment
	Given I am logged in
		And I am on review page
	When I give a rating
		And I do not enter anything in the comment field
		And I click 'Create Review' button
	Then I see error message for empty comment
		And I stay on the same page