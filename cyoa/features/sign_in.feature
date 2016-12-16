Feature: Signing in
  As a website visitor
  I want to sign in
  Because I want to customize my preferences

  Background:
    Given I am signed out

  Scenario: Sign in
    And I have an account
    When I visit my account
    And I sign in correctly
    Then I see my account

  Scenario: Incorrect email
    And I have an account
    When I sign in with the wrong email
    Then I see an invalid email or password message

  Scenario: Incorrect password
    And I have an account
    When I sign in with the wrong password
    Then I see an invalid email or password message
