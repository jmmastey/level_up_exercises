Feature: Events Page

  Background:
    Given a signed-in user that has events in their list
	And there are other events not on their list
    And they are on the events page

  Scenario: User sees their own events in the list
    Then they should see an remove-link next to each of their events

  Scenario: User has option to remove those events that are in their own list
    Then they see an add-link next to each event that is not in their events

  Scenario: User removes an event from their own list
    When they click on the remove-link next to an event
	Then the removed event will have an add-link next to it

  Scenario: User adds an event into their own list
    When they click on the add-link next to an event
	Then the added event will have a remove-link next to it
