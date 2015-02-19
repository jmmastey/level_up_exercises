Feature: View upcoming weather
  In order to dress comfortably
  As a user
  I want to view the upcoming weather

  Scenario: View 24 hour weather
    Given I am on the weather page
    Then I can see the weather for the next 24 hours

  Scenario: View weekly weather
    Given I am on the weather page
    Then I can see the daily weather summary for the next week