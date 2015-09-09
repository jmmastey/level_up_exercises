Feature: Account creation
  As a new user
  I want to register for an account
  So I can have my own data

  Scenario: Page should require email, password, and password confirmation
    Given I am on the registration page
    Then I should see the "user_email" field
    And I should see the "user_password" field
    And I should see the "user_password_confirmation" field

  Scenario: Valid email, password, and password confirmation should work
    Given I am on the registration page
    When I register with email "x@example.com", password "xkcd327!", confirmation "xkcd327!"
    Then I should be signed up as "x@example.com"

  Scenario: Requesting an existing email should produce an error
    Given the account "x@example.com" with password "xkcd327!" exists
    And I am on the registration page
    When I register with email "x@example.com"
    Then I should see "has already been taken"

  Scenario: Requesting an email with a bad format should produce an error
    Given I am on the registration page
    When I register with email "t*p"
    Then I should see "is invalid"

  Scenario: Requesting an empty email should produce an error
    Given I am on the registration page
    When I register with email ""
    Then I should see "Email can't be blank"

  Scenario: Requesting an overly short password should produce an error
    Given I am on the registration page
    When I register with password "nope"
    Then I should see "Password is too short"

  Scenario: Requesting an empty password should produce an error
    Given I am on the registration page
    When I register with password ""
    Then I should see "Password can't be blank"

  Scenario: Password and password confirmation mismatch should produce an error
    Given I am on the registration page
    When I register with password "xkcd327!", confirmation "!723dckx"
    Then I should see "Password confirmation doesn't match Password"
