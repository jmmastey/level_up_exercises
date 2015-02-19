Feature: Add Email Notifications
  In order to be notified of weather
  As one sensitive to weather
  I want to add an email notification

  Scenario: Add Notification
    Given I am on the settings page
    When I add a notification
    Then I see the saved notification
