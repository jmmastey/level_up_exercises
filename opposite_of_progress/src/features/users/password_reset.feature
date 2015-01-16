Feature: Password reset feature
  In order to recover my account once I lose my password
  As a user
  I want to reset my password

  Background:
    Given I am on Forgot your password page

  Scenario: Reset password
    Given I exist as a user
    When I reset password with account email
    Then I should see reset mail sent message

  Scenario: Try to reset password with non-registered email
    When I reset password with non-registered email
    Then I should see account not found error

  Scenario: Clicks Log in link in the page
    When I click Log in link
    Then I should be on Log in page

  Scenario: Clicks Sign up link in the page
    When I click Sign up link
    Then I should be on Sign up page
