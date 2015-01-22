Feature: Edit notification preferences
  In order to be notified about the weather
  As a registered user
  I want to edit my notification preferences
  
  Background:
    Given I am logged in
    And I have email notifications turned on

  Scenario: Add a repeating daily notification
    When I add a daily notification for 6:00AM
    Then I see a notification on the calendar at 6:00AM every day
    And at 6:00AM each day I receive an email

  Scenario: Add a second repeating daily notification
    Given an existing daily notification for 6:00AM
    When I add a daily notification for 4:00PM
    Then I see a notification on the calendar at 6:00AM every day
    And I see a notification on the calendar at 4:00PM every day
    And at 6:00AM each day I receive an email
    And at 4:00PM each day I receive an email
