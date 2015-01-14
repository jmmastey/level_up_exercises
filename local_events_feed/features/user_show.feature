Feature: User Page
  As a signed-in user
  In order to manage my personal list of showings
  I want to be able to see them on my user-page and remove them

  Scenario: I can see my showings
    Given I sign in and have showings in my list
    Then I see my showings

  Scenario: I can remove a showing from my list
    Given I sign in and have showings in my list
	When I remove a showing from my personal list
	Then I no longer see that showing in my list
