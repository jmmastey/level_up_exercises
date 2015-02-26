Feature: Logging in to or out of web account
    As a user
    I want to log in to or out my account
    To see which legislators I've added to my favorites

    Background:
    Given a user account exists
    And a legislator exists
    And the legislator is in the user's favorites
    And I am at the user log in page

    Scenario: Enter valid login credentials
    When I submit valid login credentials
    Then I am logged in to my account and see my account details
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

  Scenario: Log out
    Given I have logged in to my account
    And I log out
    Then I am not logged in to my account