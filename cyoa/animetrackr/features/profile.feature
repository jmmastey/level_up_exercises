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

  Scenario: Must be signed in to view profile
    When I am signed out
    And I am on my profile page
    Then I should be redirected to the sign in page