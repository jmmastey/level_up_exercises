Feature: Login
  In order to save my shopping history
  As a user
  I want to login

  Background:
    Given I navigate to the login page
    And some registered users

  @happy
  Scenario: Successful login
    When I submit a valid login
    Then I see a successful login message

  @sad
  Scenario: Invalid Password
    When I submit an invalid password
    Then I see an invalid user or password message

  @sad
  Scenario: Invalid Username
    When I submit an invalid username
    Then I see an invalid user or password message

  @bad
  Scenario: Missing Password
    When I submit with a missing password
    Then I see a missing password message

  @bad
  Scenario: Missing Username
    When I submit with a missing password
    Then I see a missing username message

  @bad
  Scenario: Missing Username and Password
    When I submit with no username or password
    Then I see a missing username and password message