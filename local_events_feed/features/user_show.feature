Feature: User Page

  Scenario: User sees their own event list
    Given a signed-in user that has events in their list
    Then they should see their events on their page
    And they should see a signout link

  Scenario: User removes event from their list
    Given a signed-in user that has events in their list
	When they click on remove for an event
	Then they should no longer see that event in their list

  Scenario: User navigates from their page to events page
    Given a signed-in user
	When they click on the all-events link
	Then they should see the events page
