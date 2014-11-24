Feature: User Password Reset
  As a user, I want to be able to reset
  my password.

  Scenario: Reset comfirmed user password
    Given I am on the reset password page
    When I submit a registered email
    Then I should see "You will receive a password reset email in a few minutes"

  Scenario: Link from sign in page
    Given I am on the sign in page
    When I click on reset password
    Then I should be on the reset password page

  Scenario: Reset without being a user
    Given I am on the reset password page
    When I submit a non user email
    Then I should see "Email not found"

  @LoggedIn
  Scenario: Change my password
    Given I am on the change password page
    When I change my password
    Then I should see "Your account has been updated successfully"

  @LoggedIn
  Scenario: I can log back in
    Given I am on the change password page
    When I change my password
    And I sign out
    And I visit the sign in page
    And I enter valid sign in credentials
    Then I should be on the main page
    And I should be signed in

  Scenario: Change my password not logged in
    Given I am on the main page
    When I visit the change password page
    Then I should be on the sign in page
    And I should see "You can't access this page without coming from a password reset email"
