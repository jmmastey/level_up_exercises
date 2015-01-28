Feature: Register
  In order to save my shopping history
  As a user
  I want to register

  Background:
    Given I navigate to the registration page
    And some registered users

  @happy
  Scenario: Good Registration
    When I enter a valid new registration
    Then I see the home page
    And I see a "successful registration" message

  @sad
  Scenario: Existing User Registration
    When I try to register with an existing username
    Then I see a "username exists" message

  @bad
  Scenario: No Username
    When I try to register with no username
    Then I see a "missing username" message

  @bad
  Scenario: No Password
    When I try to register with no password
    Then I see a "missing password" message

  @bad
  Scenario: No Username or Password
    When I try to register with no information
    Then I see a "missing username and password" message