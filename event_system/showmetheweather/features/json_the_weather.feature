Feature: JSON the weather

  As a developer
  I would like to access weather forecasts in JSON
  So that I can build the next Weather Channel

  Scenario: weather forecast by zip code
    When I access the the JSON URL for a forecast
    Then I receive the forecast in JSON
