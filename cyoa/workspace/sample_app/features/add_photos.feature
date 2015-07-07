Feature: See new photos
  In order to see more interesting photos
  As the user
  I want to add more processed photos

  Scenario: Add new photos from csv file
  	Given I am on the photos page
  	And I have new photo URLs and names in the CSV file
  	When I click the submit new photos button
  	Then the processed photos are displayed on the photos page
  	And I see "Photos processed succesfully" message

  Scenario: No new photos to add in CSV file
  	Given I am on the photos page
  	And I have not changed the CSV file since last submision
  	When I click the submit new photos button
  	Then I see "No new photos" message