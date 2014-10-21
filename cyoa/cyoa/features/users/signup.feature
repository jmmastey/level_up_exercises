Feature: User signup
  In order to use the application w/ custom settings
  As a user
  I want to be able to signup for the site

  Background:
    Given I am not logged in
    And I go to the signup page

  Scenario: Sign up w/ valid email/password
    When I submit valid email and password
    Then I see the message "You have signed up successfully."

  Scenario: Sign up w/ invalid email
    When I submit invalid email and valid password
    Then I see the message "Email is invalid"

  Scenario: Sign up w/ invalid password
    When I submit valid email and invalid password
    Then I see the message "Password is too short"

  Scenario: Sign up w/ differing password/confirmation
    When I submit valid email/password and differing confirmation
    Then I see the message "Password confirmation doesn't match"

  Scenario: Sign up w/ already registered email
