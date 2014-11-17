Feature: Custom weather per user
  In order to see custom forecasts for my area
  As a person
  I would like to be able to see forecasts for the location I want

  Background:
    Given I am a new authenticated user in zip code 53209 near station "KMKE"

  Scenario: Weather does not exists
    Given I am on the home page
    Then I should see "Forecast Reminder"
    And I should see "Logged in as testing@enova.com"
    And I should see "No current weather information available"
    And I should see "No hourly forecast information available"
    And I should see "No forecast weather information available"

  Scenario: Weather available at default location
    Given current weather exists for station id "KMDW"
    And forecast weather data exists for zip code 60606
    And hourly forecast weather data exists for zip code 60606
    When I go to the home page
    Then I should see "Forecast Reminder"
    And I should see "Logged in as testing@enova.com"
    And I should see "No current weather information available"
    And I should see "No hourly forecast information available"
    And I should see "No forecast weather information available"

  Scenario: Weather data available
    Given current weather exists for station id "KMKE"
    And forecast weather data exists for zip code 53209
    And hourly forecast weather data exists for zip code 53209
    When I go to the home page
    Then I should see "Forecast Reminder"
    And I should see "Logged in as testing@enova.com"
    And I should see "Logged in as testing@enova.com"
    And I should see the current weather conditions for station id "KMKE"
    And I should see hourly forecast data for zip code 53209
    And I should see the forecast data for zip code 53209
