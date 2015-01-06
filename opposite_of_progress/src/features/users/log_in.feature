Feature: Log in
  In order to get access to the access controlled section
  As a user
  I want to Log in to the site with my account

  Background:
    Given I am on Log in page

  Scenario: Log in with valid credentials
    Given I exist as a user
    When I log in with valid credentials
    Then I should be logged in

  Scenario: Log in with invalid credentials
    Given I exist as a user
    When I log in with invalid credentials
    Then I should not be logged in

  Scenario: Clicks sign up link to go to the sign up page
    When I click Sign up link
    Then I should be on Sign up page

  Scenario: Clicks Forgot your password link to go to the sign up page
    When I click Forgot your password link
    Then I should be on Forgot your password page


