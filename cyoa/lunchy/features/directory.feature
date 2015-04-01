Feature: View user directory
  As a user
  I want to view a user listing
  So I can see who else is using Lunchy

  Scenario: View listing as only user
    Given I am logged into my account
    And I am the only user
    When I visit the users page
    Then I should see a single user listing

  Scenario: View listing with multiple users
    Given I am logged into my account
    And there are 5 existing users
    When I visit the users page
    Then I should see 5 user listings
