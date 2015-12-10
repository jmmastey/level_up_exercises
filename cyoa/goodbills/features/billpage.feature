Feature: Bill Page

Scenario: Load bill information
  Given some bills
  When I am on the homepage
  And I click an individual bill link
  Then I should be on the individual bill page
  And there should be information about the bill
  And there should be voting controls

Scenario: Vote Positive
  Given some bills
  When I am on an individual bill page
  And I click the like button
  Then the bill score should increase

Scenario: Vote Negative
  Given some bills
  When I am on a different individual bill page
  And I click the dislike button
  Then the bill score should decrease
