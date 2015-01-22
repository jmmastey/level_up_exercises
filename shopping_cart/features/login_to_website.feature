Feature: logging into the website
  In order place an order on the website
  A user must first log in

  Scenario: a user logs in with a valid username and password
    Given an account exists for the user
    When they log in with their username and password
    Then they are shown "Welcome Back!"

  Scenario: a user logs in with a invalid username
    Given an account exists for the user
    When they log in with an invalid username
    Then they are shown "Incorrect Login."
    And the login form is displayed

  Scenario: a user logs in with an invalid password
    Given an account exists for the user
    When they log in with an invalid password
    Then they are shown "Incorrect Login."
    And the login form is displayed
