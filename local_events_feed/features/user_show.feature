Feature: User Page

  Scenario: User sees their own showings list
    Given a signed-in user that has showings in their list
    Then they see their showings on their page
    And they see a signout link

  Scenario: User removes showing from their list
    Given a signed-in user that has showings in their list
	When they click on remove for a showing
	Then they no longer see that showing in their list

  Scenario: User navigates from their page to events page
    Given a signed-in user
	When they click on the all-events link
	Then they see the events page
