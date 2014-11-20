Feature: Scrape for Events


  Scenario: User scrapes for events
    xGiven a signed-in user
    xAnd they click on scrape-events
	xWhen they are on the events page
    xThen there will be events on the page

  Scenario: No events were ever scraped
    Given a signed-in user
    And they are on the events page
    Then there will not be events on the page
