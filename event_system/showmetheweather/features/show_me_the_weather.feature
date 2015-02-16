Feature: show me the weather

  As a human
  I would like to see a weather forecast
  So that I can protect my fragile meatbag with the appropriate clothing

  Scenario: weather forecast is shown for zip code
    Given I have navigated to the site
    When I enter my zip code
    Then I see today's weather forecast
    And I see tonight's weather forecast
    And I see the week's weather forecast

  Scenario: error is shown for invalid zip code
    Given I have navigated to the site
    When I enter an invalid zip code
    Then I see an error
