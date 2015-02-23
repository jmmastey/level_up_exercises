Feature: Logging in to web account
	As a user
	I want to log in to my account
	To see which deeds I have tagged and to configure email alerts

	Background:
		Given I am at the user log in page

	Scenario: Enter valid login credentials
		When I submit valid login credentials
		Then I am logged in to my account
    And I see my account details
		And I see my favorite legislators
    And I see links to delete my favorite legislators

  Scenario: Enter incorrect password
    When I submit an incorrect password
    Then I see a log in error
    And I am not logged in to my account

  Scenario: Enter incorrect username
    When I submit an incorrect username
    Then I see a log in error
    And I am not logged in to my account

  Scenario: Leave log in fields blank
    When I try to log in without entering a username/password
    Then I see a log in error
    And I am not logged in to my account