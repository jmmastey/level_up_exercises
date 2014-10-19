Feature: Signing up

  Scenario: Successful Signup
    Given a user visits the signup page
    When they submit valid signup information
    Then they see their own page
    And they see themselves logged in

  Scenario: Unsuccessful Signup
    Given a user visits the signup page
    When they submit invalid signup information
    Then they see the signup page
    And they see signup errors
