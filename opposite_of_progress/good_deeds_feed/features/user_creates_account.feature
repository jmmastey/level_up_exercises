Feature: Creating an account
  As a user
  I want to create an account
  To add or remove legislators from my favorites

  Background:
    Given I am at the account creation page

  Scenario: Create account with valid parameters
    Given I have entered a valid name, email and password
    When I try to create an account
    Then my account is created

  Scenario: Leave name blank
    Given I have not entered a name
    When I try to create an account
    Then my account is not created and I see an error

  Scenario: Enter invalid email
    Given I have entered an invalid email address
    When I try to create an account
    Then my account is not created and I see an error

  Scenario: Password confirmation does not match
    Given I have entered a password confirmation that is not the password
    When I try to create an account
    Then my account is not created and I see an error