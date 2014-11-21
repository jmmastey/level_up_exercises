Feature: Scrape for Events

  Scenario: User scrapes for events
    Given a signed-in user
    And they click on scrape-events
    When they are on the events page
    Then there will be events on the page

  Scenario: No events were ever scraped
    Given a signed-in user
    And they are on the events page
    Then there will not be events on the page
