Feature: User sign up
  As a user, I want to be able to sign up for the webservice.

  Scenario: Singup a good user
    Given I am on the sign up page
    When I enter valid sign up credentials
    Then I should be on the main page
    And I should see "A message with a confirmation link has been sent to your email address"

  Scenario: sign up a bad email user
    Given I am on the sign up page
    When I enter bad email sign up credentials
    Then I should see "Email is invalid Sign up Email Password"

  Scenario: sign up an existing user email
    Given I am on the sign up page
    When I enter existing email sign up credentials
    Then I should see "Email has already been taken"

  Scenario: sign up a bad confirm password
    Given I am on the sign up page
    When I enter bad password sign up credentials
    Then I should see "Password is too short"
