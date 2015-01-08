Feature: Scrape for Events
  As a signed-in user
  In order to stay up-to-date on upcoming events
  I want to be able to search source sites for the latest information

  Background:
    Given I sign in

  Scenario: No events were ever scraped
    Given No events exist in the database
    When I visit the events page
    Then I do not see events on the page

  Scenario: User scrapes for events
    When I scrape for events
    And I visit the events page
    Then I see events on the page
