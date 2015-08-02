Feature: Profile page
  As a user with an account
  I want to be able to view my own profile page
  And interact with my profile

  Background:
    Given I have an account
    And I am signed in

  Scenario: Profile overview
    When I am on my profile page
    Then I should see my gravatar
    And I should see my username
    And I should see when I joined


  Scenario: Activity Feed - Empty
    When I am on my profile page
    And I have not entered anything in my activity feed
    Then I should see my activity feed
    But my activity feed should be empty


  Scenario: Activity Feed - Existing items
    When I am on my profile page
    And I have entered at least 1 activity in my feed
    Then I should see my activity feed
    And my activity feed should contain entries

    