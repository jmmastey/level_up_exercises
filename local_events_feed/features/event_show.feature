Feature: Event Show page

  Background:
    Given a signed-in user that has showings in their list
	And they are on the event page for one of their shows

  Scenario: User has option to remove those showings that are in their own list
    Then they can remove showings already in their list

  Scenario: User has option to add those showings that are not in their own showings
    Then they can add showings not already in their list

  Scenario: User removes a showing from their own list
    When they click on the remove-link next to a showing
	Then the removed showing will have an add-link next to it

  Scenario: User adds a showing into their own list
    When they click on the add-link next to a showing
	Then the added showing will have a remove-link next to it
