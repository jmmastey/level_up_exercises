Feature: User signup
  In order to use the application w/ custom settings
  As a user
  I want to be able to signup for the site

  Background:
    Given I am not logged in
    And I click "Sign Up"

  Scenario: Sign up w/ valid email/password
    When I enter valid email and password
    And I click "Sign up"
    Then I see the message "You have signed up successfully."

  Scenario: Sign up w/ invalid email
    When I enter invalid email and valid password
    And I click "Sign up"
    Then I see the message "Invalid email or password."

  Scenario: Sign up w/ invalid password
    When I enter valid email and invalid password
    And I click "Sign up"
    Then I see the message "Invalid email or password."

  Scenario: Sign up w/ differing password/confirmation
    When I enter valid email/password and differing confirmation
    And I click "Sign up"
    Then I see the message "Invalid email or password."
