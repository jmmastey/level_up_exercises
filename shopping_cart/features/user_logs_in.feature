Feature: User logs in
    As a user
    I want to be able to log in
    or sign in as a guest
    In order to make a purchase

  Background:
    Given I am on the home page

  Scenario: Sign in with a valid username and password
    When I enter username "Admin"
    And I enter password "Admin"
    And I click "Sign In"
    Then I should be able to make a purchase

  Scenario: Sign in with an invalid username and password
    When I enter username "Invalid"
    And I enter password "Invalid"
    And I click "Sign In"
    Then I should be taken to the home page again
    And the page should display "Invalid Credentials"

  Scenario: Continue as guest
    When I click "Guest"
    Then I should be able to make a purchase
