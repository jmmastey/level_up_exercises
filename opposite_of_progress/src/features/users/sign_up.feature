Feature: Sign up
  In order to get access to the access controlled section
  As a user
  I want to sign up for the site

  Background:
    Given I am not logged in
      And I am on Sign up page

  Scenario: Successfully signs up
    When I sign up with valid data
    Then I should be signed up
      And I should be logged in

  Scenario: Try to sign up with short password
    When I sign up with short password
    Then I should see short password error

  Scenario: Try to sign up with mismatched password
    When I sign up with mismatched passwords
    Then I should see mismatched password error

  Scenario: Try to sign up with invalid email
    When I sign up with invalid email
    Then I should see invalid email error

  Scenario: Clicks log in link in the page
    When I click Log in link
    Then I should be on Log in page

