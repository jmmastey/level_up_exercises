Feature: Events Page
  As a signed-in user
  In order to browse upcoming events
  I want to be able to see which events are in my list and navigate to them
 
  Background:
    Given I sign in and have showings in my list
	And there are some events not on my list
    And I visit the events page

  Scenario: I see my events highlighted
    Then I see my events highlighted

  Scenario: I see non-highlighted events
    Then I see non-highlighted events

  Scenario: I click on an event and am directed to its page
    When I click on an event
    Then I see the details for that event
