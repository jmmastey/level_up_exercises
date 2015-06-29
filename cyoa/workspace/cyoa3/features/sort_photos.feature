Feature: User cansort people's photos by attribute
  In order to get insight into Enova's people
  As the user
  I want to sort photos by facial attribute

  Scenario: See photos in default order
  	Given I am on the photos page
  	Then I see the photos sorted by happiness

  Scenario: Sort by the emotion disgust descending
  	Given I am on the photos page
  	When I choose emotion in the dropdown selector
  	And I choose disgust in the next dropdown selector
  	And I choose descending
  	And I click the submit button
  	Then I see the photos sorted by disgust desc

  Scenario: Sort by emotion disgust ascending
  	Given I am on the photos page
  	When I choose disgust in the next dropdown selector
  	And I choose ascending
  	And I click the submit button
  	Then I see the photos sorted by disgust ascending


 