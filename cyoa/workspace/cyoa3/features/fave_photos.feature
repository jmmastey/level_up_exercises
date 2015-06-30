Feature: Fave/unfave photos as a logged in user
	In order to fave photos
	As the logged in user
	I want to click the heart icon to fave/unfave photos

	Scenario: Fave a photo
		Given I am on the photos page
		And I am logged in
		When I click a heart icon
		Then I see the photo is faved

	Scenario: Unfave a photo
		Given I am on the photos page
		And I am logged in
		When I clicked the heart icon on a faved photo
		Then I see the photo is unfaved

	Scenario: See only my fave photos
		Given I am on the photos page
		And I am logged in
		When I click the "my faves" button
		Then I see only my faved photos

	Scenario: See all photos 
		Given I am on the faves photo page
		And I am logged in	
		When I click the "all photos" button
		Then I see all photos

	Scenario: See fave indicator on photos
		Given I am on the photos page
		And I am logged in
		Then I see red heart fave indicator on faved photos 

