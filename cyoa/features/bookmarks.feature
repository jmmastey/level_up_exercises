Feature: Managing bookmarks
  As a logged in user
  I want to add and remove bookmarks
  Because I want to see the bills I care about

  Scenario: New users have no bookmarks
    Given I am a new user
    When I visit "/bookmarks"
    Then I have no bills

  Scenario: Add bookmark
    Given I am a new user
    And I visit a bill
    When I click "Add to bookmarks"
    Then I see "Bookmarked!"
    And I see "Bookmarked"

  Scenario: No option to bookmark
    Given I visit a bill
    Then I can not bookmark

  Scenario: Seeing a list of bookmarks
    Given I am new user with 2 bookmarks
    And I visit "/bookmarks"
    Then I see 2 bills

  @javascript
  Scenario: Clicking on a bookmark
    pending
    Given I am new user with 2 bookmarks
    And I visit "/bookmarks"
    When I click on the first one
    Then I see ""

  Scenario: Removing a bookmark
    Given I am new user with 2 bookmarks
    And I visit "/bookmarks"
    When I remove the first bookmark
    Then I see 1 bills
