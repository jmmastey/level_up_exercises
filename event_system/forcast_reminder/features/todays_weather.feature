Feature: Today's Weather
  In order to prepare for the day
  As a Chicagoan
  I would like to be able to see the forecast for the next 24 hours

  Scenario: Weather does not exists
    Given I am on the home page
    Then I should see "No current weather information available"
    And I should see "No hourly forecast information available"
    And I should see "No forecast weather information available"

  Scenario: Weather data available
    Given current weather exists for station id "KMDW"
    And forecast weather data exists for zip code 60606
    And hourly forecast weather data exists for zip code 60606
    When I go to the home page
    Then I should see "Forecast Reminder"
    And I should see the current weather conditions for station id "KMDW"
    And I should see hourly forecast data for zip code 60606
    And I should see the forecast data for zip code 60606

  Scenario: Data for different zip code defined
    Given current weather exists for station id "KORD"
    And forecast weather data exists for zip code 60616
    And hourly forecast weather data exists for zip code 60616
    When I go to the home page
    Then I should see "No current weather information available"
    And I should see "No hourly forecast information available"
    And I should see "No forecast weather information available"
