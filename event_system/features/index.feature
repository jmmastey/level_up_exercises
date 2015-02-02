Feature: I need to get the daily forecast of the given city

  Scenario: Should not see high low temperatures
    Given I visit "weather/index" page
    And I did not submit the city name
    Then I should not see temperature forecast

  Scenario: Should see high low temperatures
    Given I visit "weather/index" page
    And I submit the city name
    Then I should see temperature forecast
