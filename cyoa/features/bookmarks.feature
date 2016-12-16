Feature: Managing bookmarks
  As a logged in user
  I want to add and remove bookmarks
  Because I want to see the bills I care about

  Scenario: New users have no bookmarks
    Given I am a new user
    When I visit the bookmarks page
    Then I have no bills

  Scenario: Add bookmark
    Given I am a new user
    And I visit a bill
    When I bookmark the bill
    Then I see "Bookmarked!"

  Scenario: No option to bookmark
    Given I visit a bill
    Then I can not bookmark

  Scenario: Seeing a list of bookmarks
    Given I am new user with 2 bookmarks
    And I visit the bookmarks page
    Then I should see 2 bills

  @javascript
  Scenario: Clicking on a bookmark
    Given I am new user with 2 bookmarks
    And I visit the bookmarks page
    When I click on the first one
    Then I see the bill page

  Scenario: Removing a bookmark
    Given I am new user with 2 bookmarks
    And I visit the bookmarks page
    When I remove the first bookmark
    Then I should see 1 bill
