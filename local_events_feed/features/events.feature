Feature: Events Page

  Background:
    Given a signed-in user that has showings in their list
	And there are other events not on their list
    And they are on the events page

  Scenario: User sees events highlighted
    Then they see highlighted events

  Scenario: User sees non-highlighted events
    Then they see non-highlighted events

  Scenario: User clicks on event and sees the event page
    When they click on an event
    Then they see the event page for that event
