Feature: User Showings
  As a signed-in user
  In order to manage my personal list of showings
  I want to be able to add and remove showings

  Background:
    Given I sign in and have showings in my list
	And I visit the event page for one of my shows

  Scenario: I remove a showing from my list
    When I remove one of my showings from the event's list
	Then I have the option to add the removed showing back to my list

  Scenario: I add a showing to my list then have the option to remove it
    When I add a showing from the event's list
	Then I have the option to remove the added showing
