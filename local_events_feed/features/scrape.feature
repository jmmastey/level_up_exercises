Feature: Scrape for Events

  Scenario: User sees their own events in the list
    Given a signed-in user
    And they are on the events page
    When they click on scrape-events
    Then there should be events on the page

  Scenario: User sees their own events in the list
    Given a signed-in user
    And they are on the events page
    Then there should be no events on the page
