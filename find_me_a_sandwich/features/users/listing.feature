Feature: Listing users
  As a user
  I want to see other users
  In order to compare favorites

  Background:
    Given I have a valid account
    And I am logged in
    And there are many users

  Scenario: Viewing users
    When I visit the user directory
    Then I see public users' names
    And I do not see private users' names
