Feature: Friends
  As a user
  I want to be able to interact with friends with my profile

  Background:
    Given I am authenticated
    And I go to search for users

  Scenario: Search for existing users
    When I search for an existing user
    Then I expect to see the user in the search results

  Scenario: Search for private user
    When I search for a private user
    Then I expect not to see the user in the search results

  Scenario: Search for non-existant user
    When I search for a non-existant user
    Then I expect to see an empty search result

  Scenario: Send friend request to user
    When I search for an existing user
    And I send a friend request
    Then I should see that user in my pending list

  Scenario: Reject a friend request from a user
    When I receive a friend request
    And I reject the friend request
    Then I should not see the request in my friends list
    And the friend should not me in their pending list

  Scenario: Accept a friend request from a user
    When I receive a friend request
    And I accept the friend request
    Then I should see the friend in my friends list
    And the friend should see me in their friends list

  Scenario: Go to a friend's profile via the friends list
    Given I have a friend
    When I click on their username in my friends list
    Then I should be on their profile page