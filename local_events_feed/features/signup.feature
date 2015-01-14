Feature: Signing up
  As a potential user
  In order to create an account
  I want to be able to sign-up

  Scenario: Successful Signup
    Given I visit the signup page
    When I submit valid signup information
    Then I am logged in
    And I am on my showings page

  Scenario: Unsuccessful Signup
    Given I visit the signup page
    When I submit invalid signup information
    Then I see the signup page
    And I see signup errors
